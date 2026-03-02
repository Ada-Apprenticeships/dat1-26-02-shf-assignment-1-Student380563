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
DROP TABLE IF EXISTS equipment_maintenance_log;

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
date_of_birth TEXT NOT NULL DEFAULT (datetime('now')) ,
join_date TEXT NOT NULL DEFAULT (datetime('now')),
emergency_contact_name VARCHAR (20) NOT NULL,
emergency_contact_phone INTEGER NOT NULL,
UNIQUE (phone_number),
CHECK (length(phone_number) <=13)
CHECK (length(emergency_contact_phone) <=13)
CHECK (length(first_name) > 1)
CHECK (length(last_name) > 1)
CHECK (length(emergency_contact_name) > 1)
CHECK (length(email) > 1)
CHECK (join_date LIKE '____-__-__')
CHECK (date_of_birth LIKE '____-__-__') 
);

CREATE TABLE staff
(
staff_id TEXT PRIMARY KEY NOT NULL,
first_name VARCHAR (13) NOT NULL,
last_name VARCHAR (13) NOT NULL,
email TEXT NOT NULL,
phone_number INTEGER NOT NULL,
position TEXT CHECK (position IN ('Trainer', 'Manager', 'Receptionist','Maintenance')), 
hire_date TEXT NOT NULL DEFAULT (datetime('now')) , 
location_id TEXT NOT NULL,
FOREIGN KEY (location_id) REFERENCES locations(location_id) 
UNIQUE (phone_number),
CHECK (length(phone_number) <=13)
CHECK (length(first_name) > 1)
CHECK (length(last_name) > 1)
CHECK (length(email) > 1)
CHECK (hire_date LIKE '____-__-__')
CHECK (email LIKE '%@%')
);

CREATE TABLE equipment
(
equipment_id TEXT PRIMARY KEY NOT NULL,
name VARCHAR (25) NOT NULL,
type TEXT CHECK (type IN ('Cardio', 'Strength')),
purchase_date TEXT NOT NULL DEFAULT (datetime('now')),
last_maintenance_date TEXT NOT NULL,
next_maintenance_date TEXT NOT NULL, 
location_id TEXT NOT NULL,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
CHECK (length(name) > 1)
CHECK (purchase_date LIKE '____-__-__')
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
start_time TEXT NOT NULL DEFAULT (datetime('now')),
end_time TEXT NOT NULL DEFAULT (datetime('now')),
FOREIGN KEY (class_id) REFERENCES classes(class_id)
FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE
CHECK (start_time LIKE '____-__-__ __:__:__')
CHECK (end_time LIKE '____-__-__ __:__:__')
);

CREATE TABLE memberships
(
membership_id TEXT PRIMARY KEY NOT NULL,
member_id TEXT NOT NULL,
type TEXT NOT NULL,
start_date TEXT NOT NULL DEFAULT (datetime('now')),
end_date TEXT NOT NULL DEFAULT (datetime('now')) ,
status TEXT CHECK (status IN ('Active', 'Inactive')),
FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
CHECK (start_date LIKE '____-__-__')
CHECK (end_date LIKE '____-__-__')
);


CREATE TABLE attendance
(
attendance_id TEXT PRIMARY KEY NOT NULL,
member_id TEXT NOT NULL,
location_id TEXT NOT NULL,
check_in_time TEXT NOT NULL DEFAULT (datetime('now')),
check_out_time TEXT NOT NULL DEFAULT (datetime('now')),
FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
FOREIGN KEY (location_id) REFERENCES locations(location_id) 
CHECK (check_in_time LIKE '____-__-__ __:__:__')
CHECK (check_out_time LIKE '____-__-__ __:__:__')
);

CREATE TABLE class_attendance
(
class_attendance_id TEXT PRIMARY KEY NOT NULL,
schedule_id TEXT NOT NULL,
member_id TEXT NOT NULL,
attendance_status TEXT CHECK (attendance_status IN ('Registered', 'Attended', 'Unattended')),
FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);

CREATE TABLE payments
(
payment_id TEXT PRIMARY KEY NOT NULL,
member_id TEXT NOT NULL,
amount REAL NOT NULL,
payment_date TEXT NOT NULL,
payment_method TEXT CHECK (payment_method IN ('Credit Card', 'Bank Transfer', 'PayPal', 'Cash')),
payment_type TEXT CHECK (payment_type IN ('Monthly membership fee', 'Day pass')),
CHECK (length(amount) <=60),
CHECK (payment_date LIKE '____-__-__ __:__:__')
FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);

CREATE TABLE personal_training_sessions
(
session_id TEXT PRIMARY KEY NOT NULL,
member_id TEXT NOT NULL,
staff_id TEXT NOT NULL,
session_date TEXT NOT NULL CHECK (session_date LIKE '____-__-__'),
start_time TEXT NOT NULL,
end_time TEXT NOT NULL,
notes TEXT NOT NULL,
CHECK (length(notes) <=100),
FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE member_health_metrics
(
metric_id TEXT PRIMARY KEY NOT NULL,
member_id TEXT NOT NULL,
measurement_date TEXT NOT NULL CHECK (measurement_date LIKE '____-__-__'),
weight INTEGER NOT NULL,
body_fat_percentage INTEGER NOT NULL,
muscle_mass INTEGER NOT NULL,
bmi INTEGER NOT NULL,
CHECK (length(weight) <=150),
CHECK (length(body_fat_percentage) <=100),
CHECK (length(muscle_mass) <=100),
CHECK (length(bmi) <=40),
FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);


CREATE TABLE equipment_maintenance_log
(
log_id TEXT PRIMARY KEY NOT NULL,
equipment_id TEXT NOT NULL,
maintenance_date TEXT NOT NULL,
description TEXT NOT NULL,
staff_id TEXT NOT NULL,
FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE
);


