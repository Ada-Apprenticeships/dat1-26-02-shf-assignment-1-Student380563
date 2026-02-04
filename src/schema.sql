.open fittrackpro.db
.mode box

DROP TABLE IF EXISTS location;
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

CREATE TABLE location
(
location_id TEXT PRIMARY KEY NOT NULL,
name VARCHAR (20) NOT NULL,
address TEXT NOT NULL,
phone_number INTEGER NOT NULL,
email TEXT NOT NULL,
opening_hours TEXT NOT NULL,
UNIQUE (phone_number),
CHECK (length(phone_number) <=13)
CHECK (length(name) > 1)
);

CREATE TABLE members
(
member_id TEXT PRIMARY KEY NOT NULL,
first_name VARCHAR (10) NOT NULL,
last_name VARCHAR (10) NOT NULL,
email TEXT NOT NULL,
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
);

INSERT INTO location (location_id,name,address,phone_number,email,opening_hours) VALUES
(1,'Downtown Fitness','123 Main St, London','020 555 1234','downtown@fittrackpro.com','06:00-22:00'),
(2,'Suburban Wellness','45 Oak Ln, Manchester','0161 555 5678','suburban@fittrackpro.com','05:00-23:00');