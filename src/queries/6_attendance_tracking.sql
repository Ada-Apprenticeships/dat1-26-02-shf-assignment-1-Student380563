.open fittrackpro.db
.mode column

-- 6.1 
-- Record a member's gym visit

INSERT INTO attendance (attendance_id, member_id, location_id, check_in_time) VALUES
('4', '7', '1', '2025-02-14 16:30:00');

-- 6.2 
-- Retrieve a member's attendance history

SELECT 
    strftime('%Y-%m-%d', check_in_time) AS visit_date,
    strftime('%H:%M:%S', check_in_time) AS check_in_time, 
    strftime('%H:%M:%S', check_out_time) AS check_out_time 
    --using strftime to seperate date and time
FROM attendance
WHERE member_id = '5';

-- 6.3 
-- Find the busiest day of the week based on gym visits

SELECT 
    strftime('%Y-%m-%d', check_in_time) AS day_of_week, 
    -- extracting the date only
    COUNT(*) AS visit_count 
    --then counting each visit per day
FROM attendance
GROUP BY day_of_week
ORDER BY day_of_week;

-- 6.4 
-- Calculate the average daily attendance for each location

SELECT l.name AS location_name, AVG(count) AS avg_daily_attendance 
-- selecting location name from location table
FROM (
    SELECT a.location_id, a.check_in_time, COUNT(*) AS count
    FROM attendance AS a
    GROUP BY a.check_in_time -- to calculate average
) AS a 
-- reusing the code from 4.6 to calculate avg attendance
JOIN locations l on a.location_id = l.location_id 
-- joining together the location table to get name of location
GROUP BY location_name; 

