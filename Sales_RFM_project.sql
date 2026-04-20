CREATE DATABASE sales;

USE sales;

-- STEP-1 : Combine all tables

CREATE TABLE sales2025 AS
SELECT * FROM sales202501;

SELECT *
FROM sales2025;

INSERT INTO sales2025
SELECT * FROM sales202512;

-- Changing OrderDate datatype

CREATE TABLE sales_2025
SELECT *,
STR_TO_DATE(OrderDate,'%m/%d/%Y') AS Order_Date
FROM sales2025;

ALTER TABLE sales_2025
DROP COLUMN OrderDate;

-- Check duplicates

WITH check_dups AS
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY OrderID) AS nums
FROM sales_2025
)
SELECT *
FROM check_dups
WHERE nums > 1;

-- STEP-2 : Create the RFM(Recency,Frequency,Monetary) Columns in a view

-- Recency means : Days between last_order_date
-- Frequency means : No.Of orders per customer
-- Monetary means : Revenue per customer

SELECT * 
FROM sales2025;

CREATE VIEW rfm_metrics2 AS
WITH date_curr AS
(
SELECT DATE('2026-04-15') AS analysis_date
),
rfm AS
(
SELECT CustomerID,
MAX(Order_Date) AS last_order_date,
DATEDIFF((SELECT analysis_date FROM date_curr),MAX(Order_Date)) AS recency,
COUNT(*) AS frequency,
SUM(OrderValue) AS monetary
FROM sales_2025
GROUP BY CustomerID
)
SELECT rfm.*,
	ROW_NUMBER() OVER(ORDER BY recency ASC) AS r_rank,
    ROW_NUMBER() OVER(ORDER BY frequency DESC) AS f_rank,
    ROW_NUMBER() OVER(ORDER BY monetary DESC) AS m_rank
FROM rfm;

-- STEP-3 : Create rfm scores by NTILE(n)

SELECT *
FROM rfm_metrics2;

CREATE VIEW rfm_score2 AS
WITH scores AS
(
SELECT *,
NTILE(10) OVER(ORDER BY r_rank DESC) AS r_score,
NTILE(10) OVER(ORDER BY f_rank DESC) AS f_score,
NTILE(10) OVER(ORDER BY m_rank DESC) AS m_score
FROM rfm_metrics2
)
SELECT *
FROM scores;

-- STEP-4 : creating a total score column

SELECT *
FROM rfm_score2;

CREATE VIEW rfm_total2 AS
WITH tot_score AS
(
SELECT CustomerID,
recency,
frequency,
monetary,
r_score,
f_score,
m_score,
(r_score + f_score + m_score) AS total_score
FROM rfm_score2
)
SELECT *
FROM tot_score;

-- STEP-5 : Create a table for BI by rfm segments

SELECT *
FROM rfm_total2;

CREATE TABLE final_rfm
WITH segment AS
(
SELECT *,
CASE
	WHEN total_score >= 28 THEN 'Family'
    WHEN total_score >= 24 THEN 'Loyal VIPs'
    WHEN total_score >= 20 THEN 'Loyals'
    WHEN total_score >= 16 THEN 'Good Customers'
    WHEN total_score >= 12 THEN 'Active'
    WHEN total_score >= 8 THEN 'Need Attention'
    ELSE 'Lost/In-Active'
END AS rfm_segment
FROM rfm_total2
)
SELECT *
FROM segment;

SELECT *
FROM final_rfm;