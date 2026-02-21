/** DATA QUALITY CHECK SUITE: ONLINE RETAIL DATASET
Objective: Ensure reliability for Revenue and Customer Lifetime Value (CLV) **/

-- CHECK #1: Completeness of Identity (Dimension: Completeness)
-- Every transaction must be mapped to a CustomerID for cohort analysis.
SELECT 
    COUNT(*) AS total_records,
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS missing_ids,
    (SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS pct_missing
FROM transactions;


-- CHECK #2: Logical Integrity of Transactions (Dimension: Validity)
-- Quantities <= 0 must be flagged as Cancellations ('C' prefix). 
-- This catches data entry errors that deflate revenue.
SELECT * FROM transactions 
WHERE Quantity <= 0 AND InvoiceNo NOT LIKE 'C%';


-- CHECK #3: Transaction Granularity (Dimension: Uniqueness)
-- Ensures the same product isn't double-logged in a single invoice at the same time.
SELECT InvoiceNo, StockCode, InvoiceDate, COUNT(*)
FROM transactions
GROUP BY InvoiceNo, StockCode, InvoiceDate
HAVING COUNT(*) > 1;


-- CHECK #4: Product Catalog Compliance (Dimension: Validity)
-- Filters out administrative noise (Postage, Manual Adjustments, Bank Charges).
-- Identifies codes that do not follow the standard 5-digit protocol.
SELECT DISTINCT StockCode, Description
FROM transactions 
WHERE StockCode NOT REGEXP '^[0-9]{5}[A-Z]?$';


-- CHECK #5: Temporal Accuracy (Dimension: Timeliness)
-- Ensures no invoices are dated in the future relative to the data load.
SELECT * FROM transactions 
WHERE InvoiceDate > CURRENT_TIMESTAMP;
