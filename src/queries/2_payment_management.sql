.open fittrackpro.db
.mode column

-- 2.1 
-- Record a payment for a membership

INSERT INTO payments (payment_id, member_id, amount, payment_date, payment_method, payment_type) VALUES
('8', '11', '50.00', DATETIME('now'), 'Credit Card', 'Monthly membership fee');

-- 2.2 
-- Calculate total revenue from membership fees for specified period

SELECT strftime('%Y,%m', payment_date) AS month, 
-- using stftime to select the individual months
SUM (amount) AS total_revenue 
-- adding up the total month revenue per month
FROM payments
WHERE payment_date >= '2024-11-01' AND payment_date < '2025-02-28'  -- specifying the months
GROUP BY month;

-- 2.3
-- Find all day pass purchases 

SELECT payment_id, amount, payment_date, payment_method
FROM payments
WHERE payment_type = 'Day pass';