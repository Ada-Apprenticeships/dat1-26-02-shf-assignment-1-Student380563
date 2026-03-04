.open fittrackpro.db
.mode column

-- 3.1 
-- Find equipment due for maintenance in the next 30 days

SELECT equipment_id, name, next_maintenance_date
FROM equipment 
WHERE next_maintenance_date >= '2025-01-01' AND next_maintenance_date <= date('2025-01-01', '+30 days'); 
-- selecting the equiptment which are due in the next 30 days

-- 3.2
-- Count equipment types in stock

SELECT type, COUNT(*) as count 
-- selecting the type column and using the count wildcard to count all instances
FROM equipment
GROUP BY type; 

-- 3.3 
-- Calculate average age of equipment by type (in days)

SELECT type,
    julianday(MAX(purchase_date)) - julianday(MIN(purchase_date)) / 2 AS days_between 
    --using julianday to get the difference between the 1st and last purchase date
FROM equipment
GROUP BY type;