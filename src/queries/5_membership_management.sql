.open fittrackpro.db
.mode column

-- 5.1 
SELECT m.member_id, m.first_name, m.last_name, mb.type AS membership_type, mb.start_date AS join_date
FROM members AS m
JOIN memberships mb on m.member_id = mb.member_id;

-- 5.2 


SELECT
    m.type, AVG((julianday(check_out_time) - julianday(check_in_time)) * 24 * 60) AS avg_visit_duration_minutes 
    -- converting to hours and then minutes
FROM attendance AS a
JOIN memberships m on a.member_id = m.member_id
GROUP BY type;

-- 5.3 

SELECT m.member_id, m.first_name, m.last_name, m.email, mb.end_date
FROM members AS m
JOIN memberships mb ON m.member_id = mb.member_id
WHERE end_date LIKE '2025%'; 
-- using LIKE to get end dates only in 2025