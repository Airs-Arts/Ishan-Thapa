create database railway_management_system;
create table railway_management_system.train (
    trainID INT PRIMARY KEY,
    train_name VARCHAR(255) NOT NULL,
    source_station VARCHAR(255) NOT NULL,
    destination_station VARCHAR(255) NOT NULL
);
INSERT INTO railway_management_system.train(trainID,train_name,source_station,destination_station)
VALUES
  ('1', 'Orient Express', 'Oriana Station', 'Isaland'),
  ('2', 'Bullet Lightning', 'Lightning Station', 'Euphoria'),
  ('3', 'Iron Titan', 'Stark Station', 'Iron Man'),
  ('4', 'Soilders ', 'Eren Station', 'Attack On Titan'),
  ('5', 'Golden Arrow', 'Ram Station', 'Mahabharat'),
  ('6', 'Sharingan', 'Sasuke Station', 'Uchiha Clan'),
  ('7', 'Naruto', 'Hidden Station', 'Sasuke Station'),
  ('8', 'Eraser', 'Blue Station', 'Golden Arrow'),
  ('9', 'Sky', 'Blue Station', 'Sea World');
  select* from Railway_Management_System.train;

create table railway_management_system.stations(
    stationID INT PRIMARY KEY,
    station_name VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    state VARCHAR(255) UNIQUE NOT NULL
);

INSERT INTO railway_management_system.stations(stationID, station_name,city,state)
VALUES
('1001', 'Naruto', 'Konoha', 'Shippuden'),
('1002', 'Golden Arrow', 'Archer', 'Kingdom'),
('1003', 'Strathfield', 'Canada Bay', 'NSW'),
('1004', 'Central', 'Victor', 'Victoria'),
('1005', 'George st', 'penrith', 'QLD'),
('1006', 'Blue Station', 'Skypiea', 'ACT'),
('1007', 'Banasthali', 'Kathmandy', 'Bagmati'),
('1008', 'Ghorai', 'Dang', 'Kagbeni'),
('1009', 'Queens', 'Queensland', 'United');
  select* from railway_management_system.stations;
  
create table railway_management_system.passengers (
    passengerID INT PRIMARY KEY,
    passenger_name VARCHAR(255),
    contact INT,
    age INT
);
INSERT INTO railway_management_system.passengers(passengerID, passenger_name,contact,age)
VALUES
('201', 'Uzumaki', '0404123453', 18),
('302', 'Arthur', '0409809753', 28),
('403', 'Itachi', '0405280432', 23),
('504', 'Ishan', '0404209908', 45),
('605', 'Kurapika', '0404509872', 20),
('706', 'Killua', '0403209384', 18),
('906', 'Haruka', '043409384', 18);
  select* from railway_management_system.passengers;

create table railway_management_system.tickets (
    ticketID INT PRIMARY KEY,
    passengerID INT,
    trainID INT,
    departure date,
	FOREIGN KEY (passengerID) REFERENCES passengers(passengerID),
	FOREIGN KEY (trainID) REFERENCES train(trainID)
);
INSERT INTO railway_management_system.tickets(ticketID, passengerID,trainID,departure)
VALUES
(111,'201','1','2022-01-01'),
(222,'302', '2','2022-03-02'),
(333,'403', '3','2022-02-03'),
(444,'504', '1','2022-01-04'),
(555,'605', '5','2022-01-05'),
(666,'605', '6','2022-02-06'),
(777,'906','7','2022-03-07'),
(888,'906','1','2022-04-07'),
(999,'906','6','2022-04-06'),
(1101,'201','1','2022-02-22'),
(1102,'201','2','2022-01-07');


select* from railway_management_system.tickets;

create table railway_management_system.employees (
    employeeID INT PRIMARY KEY,
    employee_name VARCHAR(255),
    position_name VARCHAR(255),
    stationID INT,
	FOREIGN KEY (stationID) REFERENCES stations(stationID)
);
INSERT INTO railway_management_system.employees (employeeID, employee_name, position_name, stationID)
VALUES
  ('601','Amit Patel','Loco Pilot','1001'),
   ('621','Amit Poudel','Station Master','1001'),
    ('611','Anurag Maichang','Cleaner','1001'),
  ('550','Priya Sharma', 'Station Master','1002'),
  ('571','Raj Singh',  'Assistant Manager','1003'),
  ('750','Sneha Gupta', 'Head Pilot','1004'),
  ('733','Praman Patra', 'Supervisor','1004'),
  ('754','Paan Prasad', 'Crew Member','1004'),
  ('755','Anurodh Nagara', 'General Manager','1004'),
  ('800','Deepak Kumar', 'Crew Member','1005'),
  ('650', 'Sandeep Singh Kunwar','Constable','1005'),
   ('850', 'Sanjok Shrestha','Communication Team Leader','1006'),
    ('753', 'Nangshi Dolma Sherpa','loco Pilot','1006'),
     ('350', 'Ishan Thapa','Station Master','1006');
select* from railway_management_system.employees;

create table railway_management_system.maintenance (
    maintenanceID INT PRIMARY KEY,
    trainID INT,
    employeeID INT,
    stationID INT,
    maintenancedate DATE,
	FOREIGN KEY (trainID) REFERENCES train(trainID),
	FOREIGN KEY (employeeID) REFERENCES employees(EmployeeID)

);

INSERT INTO railway_management_system.maintenance(maintenanceID,trainID,employeeID,stationID,maintenancedate)
VALUES
  ('001','1','601','1005','2021-12-22'),
  ('002','2','550','1005','2022-01-07'),
  ('003','1','800','1003','2022-02-01'),
  ('004','4','750','1004','2022-03-01'),
  ('005','5','800','1005','2022-04-03'),
  ('006','3','650','1003','2022-05-01'),
  ('007','4','850','1003','2022-06-01'),
  ('008','4','753','1002','2022-07-05'),
  ('009','4','350','1004','2022-08-04'),
  ('010','4','350','1004','2022-09-01'),
  ('011','2','350','1002','2022-08-04'),
  ('012','4','650','1006','2022-08-04'),
  ('013','4','650','1006','2022-08-04'),
  ('014','2','350','1005','2022-08-04'),
  ('015','6','350','1003','2022-12-04'),
  ('016','9','650','1003','2022-10-04');
  
  select* from railway_management_system.maintenance;
  
  -- QUERIES TO SOLVE--
 -- 1. List all the trains departing from a specific station.
 select*
 from railway_management_system.train
 where source_station="Blue Station";
 

 
-- 2. Find the passenger who has booked the most number of tickets.
select distinct count(ticketID) as Most_ticket, p1.passenger_name
from railway_management_system.passengers p1
inner join railway_management_system.tickets t1
on p1.passengerID=t1.passengerID
group by p1.passenger_name
order by count(ticketID) desc
limit 1;


-- 3. List all the tickets booked for a specific train.
select tc1.ticketID, t1.train_name
from railway_management_system.tickets tc1
inner join railway_management_system.train t1
on tc1.trainID=t1.trainID
where train_name="Orient Express";


-- 4. Count the number of employees at each station.
select count(e1.employeeID) as Total_Employee, s1.stationID, s1.station_name
from railway_management_system.employees e1
inner join railway_management_system.stations s1
on e1.stationID=s1.stationID
group by s1.stationID,s1.station_name;

-- 5. Find the station with the most number of trains departing.
select count(*) as Departure_Count, source_station
from railway_management_system.train 
group by source_station
order by Departure_Count desc
limit 1;


-- 6. List all the employees working at a specific station.
select e1.employee_name, s1.station_name
from railway_management_system.employees e1
inner join railway_management_system.stations s1
on e1.stationID=s1.stationID
where s1.station_name="Central";

-- 7. Find the employees who have performed maintenance on more than one train.

select m1.trainID, m1.employeeID
from railway_management_system.maintenance m1
group by m1.employeeID
having m1.trainID>1;

-- 8. List the passengers who have booked tickets on more than one train.

SELECT p.passenger_name, COUNT(DISTINCT t.trainID) AS TrainCount
FROM railway_management_system.passengers p
INNER JOIN railway_management_system.tickets t ON p.passengerID = t.passengerID
GROUP BY p.passenger_name, p.passengerID
HAVING TrainCount > 1;

-- 9. Find the train with the most number of tickets booked.
select t1.train_name,count(*) as TotalTickets
from railway_management_system.train t1
inner join railway_management_system.tickets t2
on t1.trainID=t2.trainID
group by t1.train_name
order by TotalTickets desc;


-- 10. Count the number of tickets booked for each train.

select t1.train_name,count(*) as TotalTickets
from railway_management_system.train t1
inner join railway_management_system.tickets t2
on t1.trainID=t2.trainID
group by t1.train_name
order by TotalTickets desc;

