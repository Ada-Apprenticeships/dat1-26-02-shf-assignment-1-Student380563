.open fittrackpro.db
.mode column

-- 4.1 

SELECT c.class_id AS "class_id", c.name AS "class_name", s.first_name || ' ' || s.last_name AS "instructor_name" --using concatenation to join first name and last name together
FROM staff s
JOIN class_schedule cs ON s.staff_id = cs.staff_id
JOIN classes c ON cs.class_id = c.class_id;

-- 4.2 

SELECT cs.class_id, c.name, cs.start_time, cs.end_time, c.capacity - (SELECT COUNT(attendance_status) -- using count to get numbers of attendees (registered or not) and subtracting it from capacity
FROM class_attendance ca 
WHERE ca.schedule_id = cs.schedule_id) AS available_spots
FROM class_schedule AS cs
JOIN classes c ON cs.class_id = c.class_id -- joining the class table to the class schedule table
WHERE cs.start_time LIKE '2025-02-01%';


-- 4.3 


INSERT INTO class_attendance (class_attendance_id, schedule_id, member_id, attendance_status) VALUES
('11', '1', '11', 'Registered');

-- 4.4 
DELETE FROM class_attendance WHERE rowid = 3;

-- 4.5 

SELECT c.class_id, c.name, COUNT(*) AS registration_count
FROM class_attendance AS ca
JOIN class_schedule cs ON ca.schedule_id = cs.schedule_id    -- join on schedule_id from class_attendance
JOIN classes c ON cs.class_id = c.class_id                   -- getting class_id join from class_schedule table
WHERE ca.attendance_status = 'Registered' -- looking for the status 'Registered'
GROUP BY c.class_id, c.name -- grouping by class id and name
ORDER BY registration_count DESC;
-- 4.6 

SELECT AVG(member_count) AS average_classes_per_member
FROM (
    SELECT member_id, COUNT(*) AS member_count
    FROM class_attendance
    GROUP BY member_id
);