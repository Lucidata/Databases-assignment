create database DentistX;
use DentistX
--create table Employee
create table Employee(
     ID int  not null,
	 First_name varchar(12) not null,
	 Last_name varchar(12) not null,
	 Email varchar(50) not null,
	 Contact varchar(9) not null,
	 Adress varchar(40) not null); 

-- create table Dental_traeatment
create table Dental_treatment(
     Hygienist_Id int not null,
	 Senior_Dentist_Id int not null,
	 Treatment_Id int not null);

-- create table Fees
create table Fees(
     Treatment_Id int not null,
	 Amount int not null);

--create table hygiene_control
create table Hygiene_control(
     Hygienist_Id int not null,
	 Trainee_Dentist_Id int not null,
	 Treatment_Id int not null);
-- create table Hygienist
create table Hygienist(
     Hygienist_Id int not null);
-- create table Receptionist
create table Receptionist(
     Receptionist_Id int not null);
-- create table Trainee_Dentist
create table TraineeDentist(
     Trainee_dentist_Id int not null);
-- create table SeniorDentist
create table SeniorDentist(
     Senior_dentist_Id int not null);

-- create table Job
create table Job(
     Job_Id int not null,
	 Title varchar(20) not null,
	 Salary int not null);

-- create table JuniorTraineeAppointment
create table JuniorTraineeAppointment(
     Treatment_Id int not null,
	 Trainee_dentist_Id int not null);
-- create table Patient
create table Patient(
     Patient_Id int not null,
	 First_name varchar(12) not null,
	 Last_name varchar(12) not null,
	 Age int not null,
	 Email varchar(40) not null,
	 Contact varchar(10) not null,
	 Adress varchar (40) not null);

--create table Problem
create table Problem(
     Patient_Id int not null,
	 Problem_Id int not null,
	 Description text not null);
-- create table Records
create table Records(
     Receptionist_Id int not null,
	 Patient_Id int not null,
	 Date date not null,
	 Time time not null,
	 Problem_Id int not null);

-- create table Room
create table Room(
     Room_Id varchar(1) not null,
	 Start_time time not null);
-- create table Time_slot
create table Time_slot(
     Start_time time not null,
	 End_time time not null);
-- create table Treatment
create table Treatment(
     Treatment_Id int not null,
	 Problem_Id int not null,
	 Room_Id varchar(1) not null,
	 Date date not null,
	 Start_time time not null);



--indexes 

--Employee
ALTER TABLE Employee ADD PRIMARY KEY (ID);
--Dental_treatment
ALTER TABLE Dental_treatment ADD PRIMARY KEY (Treatment_Id);
-- Fees
ALTER TABLE Fees ADD PRIMARY KEY (Treatment_Id);
--Hygiene-control
ALTER TABLE Hygiene_control ADD PRIMARY KEY (Treatment_Id);
--Hygienist
ALTER TABLE Hygienist ADD PRIMARY KEY (Hygienist_Id);
--Job
ALTER TABLE Job ADD PRIMARY KEY (Job_Id);
--JuniorDentistAppointment
ALTER TABLE JuniorTraineeAppointment ADD PRIMARY KEY (Treatment_Id,Trainee_dentist_Id);
--Patient
ALTER TABLE Patient ADD PRIMARY KEY (Patient_Id);
--Problem
ALTER TABLE Problem ADD PRIMARY KEY (Problem_Id);
ALTER TABLE Problem ADD FOREIGN KEY (Patient_Id) REFERENCES Patient(Patient_Id);

--Receptionist
ALTER TABLE Receptionist ADD PRIMARY KEY (Receptionist_Id);
--Records
ALTER TABLE Records ADD PRIMARY KEY (Receptionist_Id, Date, Time);
ALTER TABLE Records ADD FOREIGN KEY (Patient_Id) REFERENCES Patient(Patient_Id);
ALTER TABLE Records ADD FOREIGN KEY (Problem_Id) REFERENCES Problem(Problem_Id);
-- Room
ALTER TABLE Room ADD PRIMARY KEY (Room_Id, Start_time);
--Senior dentist
ALTER TABLE SeniorDentist ADD PRIMARY KEY (Senior_dentist_Id);
--Time slot
ALTER TABLE Time_slot ADD PRIMARY KEY (Start_time);
--Trainee dentist
ALTER TABLE TraineeDentist ADD PRIMARY KEY (Trainee_dentist_Id);
--Treatment
ALTER TABLE Treatment ADD PRIMARY KEY (Treatment_Id);

--- constraint

-- Hygiene control

ALTER TABLE Hygiene_control 
  ADD CONSTRAINT Hygiene_control_ibfk_1 FOREIGN KEY (Treatment_Id) REFERENCES
    Treatment(Treatment_Id) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE Hygiene_control 
  ADD CONSTRAINT Hygiene_control_ibfk_3 FOREIGN KEY (Hygienist_Id) REFERENCES
    Hygienist(Hygienist_Id) ON DELETE NO ACTION ON UPDATE CASCADE;

-- dental_treatment
ALTER TABLE Dental_treatment 
  ADD CONSTRAINT Dental_treatment_ibfk_1 FOREIGN KEY (Hygienist_Id) REFERENCES
    Hygienist(Hygienist_Id) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE Dental_treatment
  ADD CONSTRAINT Dental_treatment_ibfk_2 FOREIGN KEY (Senior_dentist_Id) REFERENCES
    SeniorDentist(Senior_dentist_Id) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE Dental_treatment
  ADD CONSTRAINT Dental_treatment_ibfk_4 FOREIGN KEY (Treatment_Id) REFERENCES
    Treatment(Treatment_Id) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Treatment
ALTER TABLE Treatment
  ADD CONSTRAINT Treatment_ibfk_1 FOREIGN KEY (Problem_Id) REFERENCES
    Problem(Problem_Id) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE Treatment
  ADD CONSTRAINT Treatment_ibfk_2 FOREIGN KEY (Room_Id, Start_time) REFERENCES
    Room(Room_Id, Start_time);

-- Fees
ALTER TABLE Fees
  ADD CONSTRAINT Fees_ibfk_1 FOREIGN KEY (Treatment_Id) REFERENCES
    Treatment(Treatment_Id) ON DELETE NO ACTION ON UPDATE CASCADE;
--Records
ALTER TABLE Records DROP CONSTRAINT  Records_ibfk_3;
ALTER TABLE Records
  ADD CONSTRAINT Records_ibfk_3 FOREIGN KEY (Receptionist_Id) REFERENCES
    Receptionist(Receptionist_Id) ON DELETE NO ACTION ON UPDATE CASCADE;
--Room
ALTER TABLE Room
  ADD CONSTRAINT Room_ibfk_1 FOREIGN KEY (Start_time) REFERENCES
    Time_slot(Start_time) ON DELETE NO ACTION ON UPDATE CASCADE;
--Receptionist
ALTER TABLE Receptionist
  ADD CONSTRAINT Receptionist_ibfk_1 FOREIGN KEY (Receptionist_Id) REFERENCES
    Employee(ID);
--Hygienist
ALTER TABLE Hygienist
  ADD CONSTRAINT Hygienist_ibfk_1 FOREIGN KEY (Hygienist_Id) REFERENCES
    Employee(ID) ON DELETE NO ACTION ON UPDATE CASCADE;
--Trainee dentist
ALTER TABLE TraineeDentist
  ADD CONSTRAINT TraineeDentist_ibfk_1 FOREIGN KEY (Trainee_dentist_Id) REFERENCES
    Employee(ID) ON DELETE NO ACTION ON UPDATE CASCADE;
--Senior dentist
ALTER TABLE SeniorDentist
  ADD CONSTRAINT Seniordentist_ibfk_3 FOREIGN KEY (Senior_dentist_Id) REFERENCES
    Employee(ID);

-- Junior Trainee appointment
ALTER TABLE JuniorTraineeAppointment
  ADD CONSTRAINT TraineeAppointment_ibfk_1 FOREIGN KEY (Trainee_dentist_Id) REFERENCES
  TraineeDentist(Trainee_dentist_Id) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE JuniorTraineeAppointment
  ADD CONSTRAINT TraineeAppointment_ibfk_2 FOREIGN KEY (Treatment_Id) REFERENCES
  Treatment(Treatment_Id) ON DELETE NO ACTION ON UPDATE CASCADE;
------------------
------------Add columns Job_Id into table Employee
alter table Employee add Job_Id int not null;
---------------

-- insert values

--Dental treatment
INSERT INTO Dental_treatment (Hygienist_Id, Senior_Dentist_Id, Treatment_Id) VALUES
(9, 15, 11), (8, 22, 12), (14, 22, 13), (10, 15, 14), (7, 16, 15),
(7, 16, 16), (10, 19, 17), (12, 18, 18), (8, 1, 19), (7, 22, 20);

--Employee
INSERT INTO Employee (ID,First_name,Last_name,Email,Job_Id,Contact,Adress) VALUES
(1,'Andy','Arvind','Andy@gmail.com',1,'93376234','Rosenvolt gate 19'),
(2,'Noah','Øystein','noah@gmail.com',1,'46734123','Sognvannveien 21'),
(3,'Clara','Johansen','clara@gmail.com',2,'93412346','Vestli gate 12'),
(4,'Alesandra','Berg','alesandra@yahoo.com',2,'47723978','Rosenhoff 8A'),
(5,'Frederik','Eriksen','fredrik@gmail.com',3,'97656233','Bogstadveien 10'),
(6,'Ditmir','Kraja','ditmir@gmail.com',3,'47612908','Majourstuen gate 20'),
(7,'Julia','Valgen','julia@yahoo.com',4,'92318356','Frogner gata 10'),
(8,'Kiran','Balsen','kiran@gmail.com',4,'43612904','Linderoff 12'),
(9,'Simina','Hansen','simina@gmail.com',4,'46712600','Linderudd 11'),
(10,'Greta','Helgen','greta@yahoo.com',4,'92333456','Torgata 19A'),
(11,'Pia','Johsen','pia@gmail.com',4,'92376458','Bjørvika 12'),
(12,'Philip','Damen','philip@yahoo.com',4,'47799023','Gaustadveien 2'),
(13,'Erik','Helgeland','erik@yhaoo.com',4,'98976543','Kongleveien 23'),
(14,'Sarah','Eriksen','sarah@gmail.com',4,'45621378','Akker brygge 12'),
(15,'Egle','Lindsen','egle@gmail.com',1,'90656123','Troinheimgata 19'),
(16,'Madalina','Ioana','mada@gmail.com',1,'93367256','Grønnland 6B'),
(17,'Johnie','Andersen','johnie@gmail.com',1,'46723905','Krigsjå 4'),
(18,'Anna','Nechita','anna2gmail.com',1,'97834512','Sandvika 33'),
(19,'Helene','Berg','helene@gmail.com',1,'48900234','Kjelsjå 11'),
(20,'Andrea','Hassen','andrea@gmail.com',1,'93067542','Bislett 8A'),
(21,'Camila','Halvag','camila@gmail.com',1,'45689023','Lilestrøms 22'),
(22,'Linea','Hansen','linea@gmail.com',1,'94512789','Problemveien 15'),
(23,'Linn','Johansen','linn@gmail.com',3,'47736345','Slemdal 17'),
(24,'Mira','Devolt','mira@gmail.com',3,'46362309','Sognveien 87'),
(25,'Melodi','Hannes','melodi@gmail.com',3,'97332568','Torgata 36');
 
 --- Hygiene control
 INSERT INTO Hygiene_control (Hygienist_Id,Trainee_Dentist_Id,Treatment_Id) VALUES
 (7,5,1),(8,6,2),(9,24,3),(12,25,4),(11,24,5),(13,6,6),
 (8,23,7),(10,24,8),(13,6,9),(7,24,10);
 
 ----Treatment
 INSERT INTO Treatment(Treatment_Id,Problem_Id,Room_Id,Date,Start_time) VALUES
 (1, 3, 'A', '2020-12-02', '09:00:00'),
(2, 3, 'D', '2020-12-03', '09:00:00'),
(3, 3, 'C', '2020-12-05', '12:00:00'),
(4, 4, 'D', '2020-11-02', '15:00:00'),
(5, 5, 'B', '2020-11-23', '09:00:00'),
(6, 2, 'B', '2020-11-19', '09:00:00'),
(7, 4, 'B', '2020-12-19', '12:00:00'),
(8, 1, 'G', '2020-12-01', '12:00:00'),
(9, 4, 'G', '2020-12-01', '15:00:00'),
(10, 3, 'D', '2020-12-12', '09:00:00'),
(11, 5, 'F', '2020-12-12', '15:00:00'),
(12, 1, 'C', '2020-12-12', '12:00:00'),
(13, 2, 'A', '2020-11-22', '09:00:00'),
(14, 5, 'A', '2020-11-22', '09:00:00'),
(15, 1, 'B', '2020-12-17', '09:00:00'),
(16, 1, 'C', '2020-12-18', '12:00:00'),
(17, 5, 'G', '2020-12-13', '12:00:00'),
(18, 2, 'G', '2021-01-13', '12:00:00'),
(19, 1, 'B', '2020-12-24', '09:00:00'),
(20, 3, 'E', '2020-12-24', '12:00:00');

----Fees
INSERT INTO Fees(Treatment_Id, Amount) VALUES
(1, 1000),
(2, 500),
(3, 1000),
(4, 1500),
(5, 900),
(6, 1800),
(7, 900),
(9, 1900),
(10, 1300),
(11, 2000),
(12, 1200),
(13, 1300),
(14, 1600),
(15, 1400),
(16, 1300),
(17, 1100),
(18, 1000),
(19, 800),
(20, 900);
----
-----Receptionist
INSERT INTO Receptionist (Receptionist_Id) VALUES
(3),(4);
----
----Patient
INSERT INTO Patient(Patient_Id,First_name,Last_name,Age,Email,Contact,Adress) VALUES
(1,'Dennis','Høgli',26, 'denis@gmail.com','48936693', 'Høgskoleveien 194'),
(2,'Ronja','Svendsen',40,'ronja@gmail.com','43290705','Hellerveien 74'),
(3,'Vilde', 'Kristianse',44,'vilde@yahoo.com','97105393','Tjømegaten 225'),
(4,'Jenny','Bredesen',9,'jenny@hotmail.com','43187824','Adolph Bergs vei 99'),
(5,'Tiril','Nilsen',70,'tiril@gmail.com','91897693','Balders vei 215');

---Problem
INSERT INTO Problem (Patient_Id, Problem_Id, Description) VALUES
(1, 1, 'Bad Breath'),
(2, 2, 'Tooth Decay'),
(3, 3, 'Gum (Periodontal) Disease'),
(4, 4, 'Mouth Sore, Bad Breath'),
(5, 5, 'Toothaches and Dental Emergencies');
----
-----Room
INSERT INTO Room (Room_Id, Start_time) VALUES
('A', '09:00:00'),
('A', '12:00:00'),
('A', '15:00:00'),
('B', '09:00:00'),
('B', '12:00:00'),
('B', '15:00:00'),
('C', '09:00:00'),
('C', '12:00:00'),
('C', '15:00:00'),
('D', '09:00:00'),
('D', '12:00:00'),
('D', '15:00:00'),
('E', '09:00:00'),
('E', '12:00:00'),
('E', '15:00:00'),
('F', '09:00:00'),
('F', '12:00:00'),
('F', '15:00:00'),
('G', '09:00:00'),
('G', '12:00:00'),
('G', '15:00:00');
---
---Time slot
INSERT INTO Time_slot (Start_time, End_time) VALUES
('09:00:00', '11:00:00'),
('12:00:00', '14:00:00'),
('15:00:00', '17:00:00');
---
----Job
INSERT INTO Job (Job_Id, Title, Salary) VALUES
(1, 'Senior_Dentist', 100000),
(2, 'Receptionist', 40000),
(3, 'Trainee dentist', 60000),
(4, 'Hygienist', 70000);
---
---Hygienist
INSERT INTO Hygienist (Hygienist_Id) VALUES
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14);
---
---senior dentist
INSERT INTO SeniorDentist (Senior_dentist_Id) VALUES
(1),
(2),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22);

-----Trainee dentist
INSERT INTO TraineeDentist (Trainee_dentist_Id) VALUES
(5),
(6),
(23),
(24),
(25);

-----Record
INSERT INTO Records (Receptionist_Id, Patient_Id, Date, Time, Problem_Id) VALUES
(3, 3, '2020-12-02', '06:00:00', 3),
(3, 5, '2020-12-03', '08:00:00', 5),
(3, 3, '2020-12-04', '10:00:00', 3),
(3, 3, '2020-12-05', '03:00:00', 3),
(4, 4, '2020-12-01', '07:00:00', 4);
----
----Junior trainee appointment
INSERT INTO JuniorTraineeAppointment (Treatment_Id, Trainee_dentist_Id) VALUES
(1, 5),
(1, 6),
(1, 24),
(2, 6),
(2, 23),
(5, 6),
(6, 23),
(7, 5),
(7, 24),
(17, 24);

----Retrieve values
--1.Which Dentist treated the highest number of patients?
     SELECT * FROM Employee WHERE ID in (SELECT MAX(maxTreatment) 
	 FROM (SELECT Senior_Dentist_Id,COUNT(*) AS     
	 maxTreatment FROM Dental_treatment 
	 GROUP BY Dental_treatment.Senior_Dentist_Id) AS Result);

--2.List number of appointments per month in order of the date and time they occurred.
SELECT * FROM Treatment ORDER BY Date, Start_time;
--3.Retrieve Patient details whose treatment(s) spanned over more 
--than 3 appointments for each treatment. 
SELECT * FROM Patient WHERE Patient_Id in (SELECT Patient_Id 
FROM Problem WHERE Problem_Id IN (SELECT Problem_Id 
FROM Treatment GROUP BY Problem_Id HAVING COUNT(Treatment_Id)>3));

--4.Retrieve list of appointments where more than one junior/trainee
--dentists were assigned
SELECT * FROM Treatment WHERE Treatment_Id in (SELECT Treatment_Id 
FROM JuniorTraineeAppointment GROUP BY Treatment_Id 
HAVING COUNT(Trainee_dentist_Id)>1);

--5.List number of treatments performed in each room.
SELECT Room_Id, COUNT (Treatment_Id) AS 
"Number of treatments" FROM Treatment GROUP BY Room_Id;

--6.Retrieve list of patients whose age is more than 40 years.
SELECT * FROM Patient WHERE age>40;
--Calculate and present Total Hours used on each Patient in the database
SELECT Problem_Id, COUNT(*)*2 AS Totaltime FROM Treatment GROUP BY Problem_Id;