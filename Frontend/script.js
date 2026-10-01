function loginOrganizer(event) {
    event.preventDefault();
    window.location.href = "organizer-dashboard.html";
}

document.addEventListener("DOMContentLoaded", function () {

    const registrationForm = document.querySelector(".registration-card form");
    const createEventForm = document.querySelector(".create-event-card form");

    if (registrationForm) {
        registrationForm.addEventListener("submit", function (event) {
            event.preventDefault();
            alert("Registration submitted successfully!");
        });
    }

    if (createEventForm) {
        createEventForm.addEventListener("submit", function (event) {
            event.preventDefault();
            alert("Event published successfully!");
            window.location.href = "organizer-dashboard.html";
        });
    }

});