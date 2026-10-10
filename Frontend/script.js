function loginOrganizer(event) {
    event.preventDefault();
    window.location.href = "organizer-dashboard.html";
}

function formatDate(value) {
    const d = new Date(value);
    if (isNaN(d)) return value;
    return d.toLocaleDateString("en-IN", { day: "numeric", month: "short", year: "numeric" });
}

function formatTime(value) {
    return value ? String(value).slice(0, 5) : "";
}

document.addEventListener("DOMContentLoaded", function () {

    const registrationForm = document.querySelector(".registration-card form");
    const createEventForm = document.querySelector(".create-event-card form");
    const eventListContainer = document.querySelector(".events-container");
    const myEventsBody = document.querySelector("#my-events-body");
    const attendeeReportList = document.querySelector("#attendee-report");
    const revenueReportList = document.querySelector("#revenue-report");
    const eventNameEl = document.querySelector("#eventName");

    // ---- Registration (real fee -> create participant -> register) ----
    if (registrationForm) {
        registrationForm.addEventListener("submit", function (event) {
            event.preventDefault();
            const formData = new FormData(registrationForm);
            const eventId = new URLSearchParams(window.location.search).get("eventId");

            if (!eventId) {
                alert("Please open this page using the Register button on an event.");
                return;
            }

            fetch("http://localhost:5000/api/events/" + eventId)
                .then(res => res.json())
                .then(eventData => {
                    const type = encodeURIComponent(formData.get("ParticipantType"));
                    return fetch("http://localhost:5001/api/fee/" + type + "/" + eventData.Fee)
                        .then(res => res.json());
                })
                .then(feeData => {
                    return fetch("http://localhost:5001/api/participants", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({
                            Name: formData.get("Name"),
                            Email: formData.get("Email"),
                            Phone: formData.get("Phone"),
                            ParticipantType: formData.get("ParticipantType")
                        })
                    })
                    .then(res => res.json())
                    .then(participantData => ({ participantData: participantData, fee: feeData.fee }));
                })
                .then(info => {
                    return fetch("http://localhost:5000/api/register", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({
                            eventId: eventId,
                            participantId: info.participantData.participantId,
                            fee: info.fee
                        })
                    });
                })
                .then(res => res.json())
                .then(data => {
                    // The stored procedure returns a "No seats available" message when the event is full
                    const rows = Array.isArray(data.result) && Array.isArray(data.result[0]) ? data.result[0] : [];
                    if (rows.length > 0 && rows[0].Message) {
                        alert(rows[0].Message);
                        return;
                    }
                    alert(data.message || data.error || "Registration could not be completed.");
                    if (data.message) {
                        window.location.href = "participant.html";
                    }
                })
                .catch(err => alert("Error: " + err.message));
        });
    }

    // ---- Create Event (venue first, then event) ----
    if (createEventForm) {
        createEventForm.addEventListener("submit", function (event) {
            event.preventDefault();
            const formData = new FormData(createEventForm);

            fetch("http://localhost:5000/api/venues", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    VenueName: formData.get("VenueName"),
                    Address: formData.get("Address"),
                    City: formData.get("City"),
                    Capacity: formData.get("Capacity")
                })
            })
            .then(res => res.json())
            .then(venueData => {
                return fetch("http://localhost:5000/api/events", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({
                        EventName: formData.get("EventName"),
                        EventDate: formData.get("EventDate"),
                        EventTime: formData.get("EventTime"),
                        Description: formData.get("Description"),
                        OrganizerID: 1,
                        VenueID: venueData.venueId,
                        TotalSeats: formData.get("TotalSeats"),
                        Fee: formData.get("Fee")
                    })
                });
            })
            .then(res => res.json())
            .then(data => {
                alert(data.message || data.error || "Event could not be created.");
                if (data.message) {
                    window.location.href = "organizer-dashboard.html";
                }
            })
            .catch(err => alert("Error: " + err.message));
        });
    }

    // ---- Event listing (participant.html) ----
    if (eventListContainer) {
        fetch("http://localhost:5000/api/events")
            .then(res => res.json())
            .then(events => {
                eventListContainer.innerHTML = "";
                events.forEach(ev => {
                    eventListContainer.innerHTML += `
                        <div class="event-card">
                            <h2>${ev.EventName}</h2>
                            <p><strong>Event Date:</strong> ${formatDate(ev.EventDate)}</p>
                            <p><strong>Event Time:</strong> ${formatTime(ev.EventTime)}</p>
                            <p class="event-description">${ev.Description}</p>
                            <p><strong>Available Seats:</strong> ${ev.AvailableSeats}</p>
                            <a href="event-details.html?id=${ev.EventID}" class="event-button">View Event</a>
                        </div>`;
                });
            })
            .catch(err => console.error("Error fetching events:", err));
    }

    // ---- Dashboard: events table (organizer-dashboard.html) ----
    if (myEventsBody) {
        fetch("http://localhost:5000/api/events")
            .then(res => res.json())
            .then(events => {
                myEventsBody.innerHTML = "";
                events.forEach(ev => {
                    myEventsBody.innerHTML += `
                        <tr>
                            <td>${ev.EventName}</td>
                            <td>${formatDate(ev.EventDate)}</td>
                            <td>${ev.TotalSeats}</td>
                            <td>${ev.AvailableSeats}</td>
                            <td>₹${ev.Fee}</td>
                        </tr>`;
                });
            })
            .catch(err => console.log("Error loading events table:", err));
    }

    // ---- Dashboard: reports (organizer-dashboard.html) ----
    if (attendeeReportList) {
        fetch("http://localhost:5001/api/reports/attendees")
            .then(res => res.json())
            .then(data => {
                attendeeReportList.innerHTML = "";
                data.forEach(row => {
                    attendeeReportList.innerHTML += `<li>${row.EventName}: ${row.TotalRegistered}</li>`;
                });
            })
            .catch(err => console.log("Error loading attendee report:", err));
    }

    if (revenueReportList) {
        fetch("http://localhost:5001/api/reports/revenue")
            .then(res => res.json())
            .then(data => {
                revenueReportList.innerHTML = "";
                data.forEach(row => {
                    revenueReportList.innerHTML += `<li>${row.EventName}: ₹${row.Revenue}</li>`;
                });
            })
            .catch(err => console.log("Error loading revenue report:", err));
    }

    // ---- Event details (event-details.html) ----
    if (eventNameEl) {
        const eventId = new URLSearchParams(window.location.search).get("id");

        if (eventId) {
            fetch("http://localhost:5000/api/events/" + eventId)
                .then(res => res.json())
                .then(ev => {
                    document.querySelector("#eventName").textContent = ev.EventName;
                    document.querySelector("#eventDescription").textContent = ev.Description;
                    document.querySelector("#eventDate").textContent = formatDate(ev.EventDate);
                    document.querySelector("#eventFee").textContent = ev.Fee;
                    document.querySelector("#eventSeats").textContent = ev.AvailableSeats;
                    document.querySelector("#registerLink").href = "registration.html?eventId=" + ev.EventID;
                })
                .catch(err => console.log("Error loading event details:", err));
        }
    }

});