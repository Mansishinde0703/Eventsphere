
const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'root123',
  database: 'event_sphere'
});

db.connect((err) => {
  if (err) throw err;
  console.log('MySQL Connected (Member 3)');
});

app.get('/api/events', (req, res) => {
  db.query('SELECT * FROM Event', (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});
app.get('/api/events/:id', (req, res) => {
  db.query('SELECT * FROM Event WHERE EventID = ?', [req.params.id], (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results[0]);
  });
});

app.post('/api/events', (req, res) => {
  const { EventName, EventDate, EventTime, Description, OrganizerID, VenueID, TotalSeats, Fee } = req.body;
  const sql = `INSERT INTO Event (EventName, EventDate, EventTime, Description, OrganizerID, VenueID, TotalSeats, AvailableSeats, Fee)
               VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`;
  db.query(sql, [EventName, EventDate, EventTime, Description, OrganizerID, VenueID, TotalSeats, TotalSeats, Fee], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ message: 'Event created', eventId: result.insertId });
  });
});

app.get('/api/venues', (req, res) => {
  db.query('SELECT * FROM Venue', (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});
app.post('/api/venues', (req, res) => {
  const { VenueName, Address, City, Capacity } = req.body;
  const sql = `INSERT INTO venue (VenueName, Address, City, Capacity) VALUES (?, ?, ?, ?)`;
  db.query(sql, [VenueName, Address, City, Capacity], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ message: 'Venue created', venueId: result.insertId });
  });
});

app.post('/api/register', (req, res) => {
  const { eventId, participantId, fee } = req.body;

  const sql = `INSERT INTO Registration
               (EventID, ParticipantID, RegistrationDate, FeePaid, AttendanceStatus)
               VALUES (?, ?, CURDATE(), ?, 'absent')`;

  db.query(sql, [eventId, participantId, fee], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });

    db.query(
      'UPDATE Event SET AvailableSeats = AvailableSeats - 1 WHERE EventID = ?',
      [eventId],
      (err2) => {
        if (err2) return res.status(500).json({ error: err2.message });

        res.json({
          message: 'Registration successful',
          registrationId: result.insertId
        });
      }
    );
  });
});

app.listen(5000, () => {
  console.log('Member 3 server running on port 5000');
});