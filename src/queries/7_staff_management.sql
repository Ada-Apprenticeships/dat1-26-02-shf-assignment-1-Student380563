.open fittrackpro.db
.mode column

-- 7.1 

SELECT staff_id, first_name, last_name, position AS role
FROM staff
ORDER BY role;

-- 7.2 

