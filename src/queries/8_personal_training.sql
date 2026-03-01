.open fittrackpro.db
.mode column

-- 8.1 

SELECT pt.session_id,
  m.first_name || ' ' || m.last_name AS "member_name", 
  -- concatenating first and last name together
    pt.session_date,
    pt.start_time, 
    pt.end_time

FROM personal_training_sessions AS pt
JOIN members m ON pt.member_id = m.member_id
JOIN staff s ON pt.staff_id = s.staff_id
WHERE s.first_name || ' ' || s.last_name = 'Ivy Irwin'; 
--selecting the relevant staff member using contatenation