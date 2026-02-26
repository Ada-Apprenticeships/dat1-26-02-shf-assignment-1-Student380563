.open fittrackpro.db
.mode column

-- 8.1 

SELECT pt.session_id,
  m.first_name || ' ' || m.last_name AS "member_name", 
    pt.session_date,
    pt.start_time, 
    pt.end_time

FROM personal_training_sessions AS pt
JOIN members m ON pt.member_id = m.member_id
WHERE staff_id = '2';