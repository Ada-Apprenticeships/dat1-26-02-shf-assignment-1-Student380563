.open fittrackpro.db
.mode column

-- 7.1 

SELECT staff_id, first_name, last_name, position AS role
FROM staff
ORDER BY role;

-- 7.2 
SELECT s.staff_id AS trainer_id, 
    s.first_name || ' ' || s.last_name AS "trainer_name", 
    s.staff_id, COUNT(*) as session_count
FROM staff AS s
JOIN personal_training_sessions pts on s.staff_id= pts.staff_id
WHERE pts.session_date >= date('2025-01-20') 
AND pts.session_date <= date('2025-01-20', '+30 days')
GROUP BY trainer_id, trainer_name
HAVING COUNT(*) >= 1
ORDER BY session_count;

