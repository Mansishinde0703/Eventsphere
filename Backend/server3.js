
const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
  host: 'localhost',
  user: 'event_sphere',
  password: 'Shruti@11',
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

app.post('/api/register', (req, res) => {
  const { eventId, participantId, fee } = req.body;
  db.query('CALL RegisterParticipant(?, ?, ?)', [eventId, participantId, fee], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ message: 'Registration successful', result });
  });
});

app.listen(5000, () => {
  console.log('Member 3 server running on port 5000');
});