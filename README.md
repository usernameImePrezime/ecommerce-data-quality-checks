# Data Quality Framework: E-Commerce Transactions

This project establishes a data quality pipeline for the Online Retail dataset. We focus on ensuring financial accuracy and reliable customer analytics.

## Data Quality Matrix

| Check | Dimension | Severity | Goal |
| :--- | :--- | :--- | :--- |
| Missing Customer ID | Completeness | **Critical** | Protect CLV metrics |
| Negative Quantities | Validity | **Critical** | Prevent revenue deflation |
| Duplicate Invoices | Uniqueness | Warning | Avoid volume inflation |
| Non-Product Codes | Validity | Warning | Clean product catalog |
| Future Dates | Timeliness | **Critical** | Ensure ETL health |

## Technical Implementation
Detailed SQL queries for each check are located in the `/sql` directory.

## Future Scalability
To move these checks into production at JetBrains, I would integrate them into a **dbt** (data build tool) workflow to ensure data is validated automatically before reaching any BI dashboards.
