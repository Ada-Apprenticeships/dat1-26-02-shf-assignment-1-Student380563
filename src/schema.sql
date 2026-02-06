.open fittrackpro.db
.mode box

DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS class_schedule;
DROP TABLE IF EXISTS memberships;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS class_attendance;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS personal_training_sessions;
DROP TABLE IF EXISTS member_health_metrics;
DROP TABLE IF EXISTS equipment_maintainance_log;

PRAGMA foreign_keys = ON;

CREATE TABLE locations
(
location_id TEXT PRIMARY KEY NOT NULL,
name VARCHAR (30) NOT NULL,
address TEXT NOT NULL,
phone_number INTEGER NOT NULL,
email TEXT CHECK (email LIKE '%@%') NOT NULL,
opening_hours TEXT NOT NULL,
UNIQUE (phone_number),
CHECK (length(phone_number) <=13)
CHECK (length(name) > 1)
);

CREATE TABLE members
(
member_id TEXT PRIMARY KEY NOT NULL,
first_name VARCHAR (13) NOT NULL,
last_name VARCHAR (13) NOT NULL,
email TEXT CHECK (email LIKE '%@%') NOT NULL,
phone_number INTEGER NOT NULL,
date_of_birth TEXT NOT NULL,
join_date TEXT NOT NULL,
emergency_contact_name VARCHAR (20) NOT NULL,
emergency_contact_phone INTEGER NOT NULL,
UNIQUE (phone_number),
CHECK (length(phone_number) <=13)
CHECK (length(emergency_contact_phone) <=13)
CHECK (length(first_name) > 1)
CHECK (length(last_name) > 1)
CHECK (length(emergency_contact_name) > 1)
CHECK (length(email) > 1)
);

CREATE TABLE staff
(
staff_id TEXT PRIMARY KEY NOT NULL,
first_name VARCHAR (13) NOT NULL,
last_name VARCHAR (13) NOT NULL,
email TEXT CHECK (email LIKE '%@%') NOT NULL,
phone_number INTEGER NOT NULL,
position TEXT CHECK (position IN ('Trainer', 'Manager', 'Receptionist','Maintenance')), 
hire_date TEXT NOT NULL, 
location_id TEXT NOT NULL,
FOREIGN KEY (location_id) REFERENCES locations(location_id) 
UNIQUE (phone_number),
CHECK (length(phone_number) <=13)
CHECK (length(first_name) > 1)
CHECK (length(last_name) > 1)
CHECK (length(email) > 1)
);

CREATE TABLE equipment
(
equipment_id TEXT PRIMARY KEY NOT NULL,
name VARCHAR (25) NOT NULL,
type TEXT CHECK (type IN ('Cardio', 'Strength')),
purchase_date TEXT NOT NULL,
last_maintainance_date TEXT NOT NULL,
next_maintainance_date TEXT NOT NULL, 
location_id TEXT NOT NULL,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
CHECK (length(name) > 1)
);

CREATE TABLE classes
(
class_id TEXT PRIMARY KEY NOT NULL,
name VARCHAR (25) NOT NULL,
description TEXT NOT NULL,
capacity INTEGER NOT NULL,
duration INTEGER NOT NULL,
location_id TEXT NOT NULL,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
CHECK (length(name) > 1)
CHECK (length(capacity) <=100)
CHECK (length(duration) <=90)
);

CREATE TABLE class_schedule
(
schedule_id TEXT PRIMARY KEY NOT NULL,
class_id TEXT NOT NULL,
staff_id TEXT NOT NULL,
start_time TEXT NOT NULL,
end_time TEXT NOT NULL,
FOREIGN KEY (class_id) REFERENCES class(class_id)
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE memberships
(
member_id TEXT PRIMARY KEY NOT NULL,
type TEXT NOT NULL,
start_date TEXT NOT NULL,
end_date TEXT NOT NULL,
status TEXT CHECK (type IN ('Active', 'Inactive')),
FOREIGN KEY (member_id) REFERENCES members(member_id)
);


CREATE TABLE attendance
(
attendance_id TEXT PRIMARY KEY NOT NULL,
member_id TEXT NOT NULL,
location_id TEXT NOT NULL,
check_in_time TEXT NOT NULL,
check_out_time TEXT NOT NULL,
FOREIGN KEY (member_id) REFERENCES members(member_id),
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE class_attendance
(
class_attendance_id TEXT PRIMARY KEY NOT NULL,
schedule_id TEXT NOT NULL,
member_id TEXT NOT NULL,
attendance_status TEXT CHECK (attendance_status IN ('Registered', 'Attended', 'Unattended'))
);

CREATE TABLE payments
(
payment_id TEXT PRIMARY KEY NOT NULL,
member_id TEXT NOT NULL,
location_id TEXT NOT NULL,
amount INTEGER NOT NULL,
payment_date TEXT NOT NULL,
payment_method TEXT CHECK (payment_method IN ('Credit Card', 'Bank Transfer', 'PayPal')),
payment_type TEXT CHECK (payment_type IN ('Monthly membership fee', 'Day pass')),
CHECK (length(amount) <=60),
FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE personal_training_sessions
(
session_id TEXT PRIMARY KEY NOT NULL,
member_id TEXT NOT NULL,
staff_id TEXT NOT NULL,
session_date TEXT NOT NULL,
start_time TEXT NOT NULL,
end_time TEXT NOT NULL,
notes TEXT NOT NULL,
CHECK (length(notes) <=100),
FOREIGN KEY (member_id) REFERENCES members(member_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE member_health_metrics
(
metric_id TEXT PRIMARY KEY NOT NULL,
member_id TEXT NOT NULL,
measurement_date TEXT NOT NULL,
weight INTEGER NOT NULL,
body_fat_percentage INTEGER NOT NULL,
muscle_mass INTEGER NOT NULL,
bmi INTEGER NOT NULL,
CHECK (length(weight) <=150),
CHECK (length(body_fat_percentage) <=100),
CHECK (length(muscle_mass) <=100),
CHECK (length(bmi) <=40),
FOREIGN KEY (member_id) REFERENCES members(member_id)
);


CREATE TABLE equipment_maintenance_log
(
log_id TEXT PRIMARY KEY NOT NULL,
equipment_id TEXT NOT NULL,
maintainance_date TEXT NOT NULL,
description TEXT NOT NULL,
staff_id TEXT NOT NULL,
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);


INSERT INTO locations (location_id,name,address,phone_number,email,opening_hours) VALUES
(1,'Downtown Fitness','123 Main St, London','020 555 1234','downtown@fittrackpro.com','06:00-22:00'),
(2,'Suburban Wellness','45 Oak Ln, Manchester','0161 555 5678','suburban@fittrackpro.com','05:00-23:00');

INSERT INTO staff (staff_id,first_name,last_name,email,phone_number,position,hire_date,location_id) VALUES
(1,'James','Bond','james.bond@fittrackpro.com','07007 007007','Manager','2022-01-01','1');


-- staff_id,first_name,last_name,email,phone_number,position,hire_date,locations_id
-- 1,James,Bond,james.bond@fittrackpro.com,"07007 007007",Manager,2022-01-01,1