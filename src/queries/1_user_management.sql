.open fittrackpro.db
.mode column

-- 1.1

SELECT member_id, first_name, last_name, email, join_date FROM members;


-- 1.2

UPDATE members
SET phone_number = '07000 100005', email = 'emily.jones.updated@email.com'
WHERE member_id = '5';

-- 1.3

SELECT COUNT(*) AS member_count 
FROM members;


-- 1.4

SELECT m.member_id, m.first_name, m.last_name, COUNT (c.attendance_status) AS registration_count
FROM class_attendance c 
JOIN members m ON c.member_id = m.member_id
WHERE c.attendance_status = 'Registered'
GROUP BY m.member_id, m.first_name, m.last_name
ORDER BY registration_count DESC
LIMIT 1; -- LIMIT only shows one result

-- 1.5


SELECT m.member_id, m.first_name, m.last_name, COUNT (c.attendance_status) AS registration_count
FROM class_attendance c 
JOIN members m ON c.member_id = m.member_id
WHERE c.attendance_status = 'Registered'
GROUP BY m.member_id, m.first_name, m.last_name
ORDER BY registration_count ASC
LIMIT 1; 

-- 1.6


SELECT COUNT(*) AS Count
FROM (
    SELECT member_id 
    FROM class_attendance
    WHERE attendance_status = 'Attended'
    GROUP BY member_id 
    HAVING COUNT(*) > 1 -- only show members who attended more than once
);

-- using a nested query 