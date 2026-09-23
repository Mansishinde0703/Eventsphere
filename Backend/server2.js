
const express=require("express");
const mysql=require("mysql2");
const cors=require("cors");

const app=express();
app.use(cors());
app.use(express.json());

const db=mysql.createConnection({
host:'localhost',
user:'event_sphere',
password:'Shruti@11',
database:'event_sphere'
});

db.connect((err)=>{
if(err)throw err;
console.log('MySQL Connected (Member 4)');
});

app.get('/api/participants',(req,res)=>{
db.query('SELECT * FROM Participant',(err,results)=>{
if(err)return res.status(500).json({error:err.message});
res.json(results);
});
});

app.post('/api/participants',(req,res)=>{
const{Name,Email,Phone,ParticipantType}=req.body;
const sql=`INSERT INTO Participant (Name,Email,Phone,ParticipantType) VALUES (?,?,?,?)`;
db.query(sql,[Name,Email,Phone,ParticipantType],(err,result)=>{
if(err)return res.status(500).json({error:err.message});
res.json({message:'Participant added',participantId:result.insertId});
});
});

app.put('/api/attendance/:id',(req,res)=>{
const{status}=req.body;
const sql=`UPDATE Registration SET AttendanceStatus=? WHERE RegistrationID=?`;
db.query(sql,[status,req.params.id],(err,result)=>{
if(err)return res.status(500).json({error:err.message});
res.json({message:'Attendance updated'});
});
});
app.get('/api/fee/:type/:base',(req,res)=>{
const sql='SELECT CalculateFee(?,?) AS fee';
db.query(sql,[req.params.type,req.params.base],(err,result)=>{
if(err)return res.status(500).json({error:err.message});
res.json(result[0]);
});
});
app.get('/api/reports/attendees',(req,res)=>{
const sql=`SELECT E.EventName,COUNT(R.RegistrationID) AS TotalRegistered
FROM Event E JOIN Registration R ON E.EventID=R.EventID
GROUP BY E.EventName`;
db.query(sql,(err,results)=>{
if(err)return res.status(500).json({error:err.message});
res.json(results);
});
});
app.get('/api/reports/revenue',(req,res)=>{
const sql=`SELECT E.EventName,SUM(R.FeePaid) AS Revenue
FROM Event E JOIN Registration R ON E.EventID=R.EventID
GROUP BY E.EventName`;
db.query(sql,(err,results)=>{
if(err)return res.status(500).json({error:err.message});
res.json(results);
});
});
app.listen(5001,()=>{
console.log('Member 4 server running on port 5001');
});
