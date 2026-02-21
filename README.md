# E-Commerce Data Quality Framework

This repository provides a robust Data Quality (DQ) suite for the Online Retail e-commerce dataset. The framework is designed to ensure that downstream analytics—specifically Financial Reporting and Customer Lifetime Value (CLV) models—are built on accurate, unique, and complete data.

## 📊 Data Quality Strategy Matrix

| Check ID | Dimension | Severity | Verification Goal |
| :--- | :--- | :--- | :--- |
| **DQ-01** | Completeness | **Critical** | Validate that all transactions are linked to a `CustomerID`. |
| **DQ-02** | Validity | **Critical** | Identify negative quantities not explicitly flagged as cancellations ('C'). |
| **DQ-03** | Uniqueness | Warning | Prevent double-counting of items within the same invoice/timestamp. |
| **DQ-04** | Validity | Warning | Isolate non-product administrative codes (e.g., POST, M, BANK CHARGES). |
| **DQ-05** | Timeliness | **Critical** | Ensure no invoices are dated in the future relative to ingestion. |

## 🛠 Project Structure
- `/sql`: Contains the implementation logic for each quality check.
- `README.md`: Project overview and strategic alignment.

## 🚀 Production Roadmap & Scalability
In a production environment at **JetBrains**, I would transition these manual SQL checks into an automated pipeline:
1. **Data Contracts:** Implement schema validation at the ingestion layer using tools like **Great Expectations** to catch "Critical" errors before they reach the warehouse.
2. **Automated Testing:** Integrate these checks into a **dbt (data build tool)** workflow to run as part of the daily ELT process.
3. **Monitoring:** Export DQ metrics to a **Datalore** dashboard to monitor data health trends and alert the Data Office of systemic issues.
