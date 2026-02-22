.open fittrackpro.db
.mode column

-- 6.1 
INSERT INTO attendance (attendance_id, member_id, location_id, check_in_time) VALUES
('4', '7', '1', '2025-02-14 16:30:00');

-- 6.2 

SELECT 
    strftime('%Y-%m-%d', check_in_time) AS visit_date,
    strftime('%H:%M:%S', check_in_time) AS check_in_time,
    strftime('%H:%M:%S', check_out_time) AS check_out_time --using strftime to seperate date and time
FROM attendance
WHERE member_id = '5';

-- 6.3 

SELECT 
    strftime('%Y-%m-%d', check_in_time) AS date,
    COUNT(*) AS visit_count
FROM attendance
GROUP BY date
ORDER BY date;

-- 6.4 


