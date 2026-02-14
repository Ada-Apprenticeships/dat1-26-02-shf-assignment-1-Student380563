.open fittrackpro.db
.mode box

-- 2.1 

INSERT INTO payments (payment_id, member_id, amount, payment_date, payment_method, payment_type) VALUES
('8', '11', '50.00', DATETIME('now'), 'Credit Card', 'Monthly membership fee');

-- 2.2 

SELECT strftime('%Y,%m', payment_date) AS month, -- using stftime to select the individual months
SUM (amount) as total_revenue -- adding up the total month revenue per month
FROM payments
WHERE payment_date >= '2024-11-01' AND payment_date < '2025-02-28'  -- specifying the months
GROUP BY month

-- 2.3 

SELECT payment_id, amount, payment_date, payment_method
FROM payments
WHERE payment_type = 'Day pass'