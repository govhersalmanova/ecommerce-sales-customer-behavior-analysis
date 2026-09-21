# Data dictionary and metric notes

Source: `../ecommerce_sales_data.csv`, described by the original project as synthetic data for education and portfolio use. The generation script, seed, and an explicit reuse license are not supplied.

Grain: one row per order; 3,000 unique Order_ID values. Coverage: 2025-01-01 to 2025-12-31. Currency: Azerbaijani manat (AZN).

| Field | Meaning / interpretation |
| --- | --- |
| Order_ID | Unique synthetic order identifier |
| Order_Date | Order date in YYYY-MM-DD format |
| Customer_ID | Synthetic customer identifier used to aggregate observed purchases |
| Age_Group | Customer age band as supplied |
| Gender | Customer gender label as supplied |
| City | Order city |
| Category | Product category |
| Product | Product label |
| Quantity | Number of units in the order |
| Unit_Price_AZN | Unit price in AZN |
| Discount_Pct | Discount percentage, expressed on a 0–100 scale |
| Payment_Method | Card, Cash on Delivery, or Digital Wallet |
| Delivery_Days | Delivery duration in days |
| Rating | Order-level customer rating, presented on a five-point scale |
| Returned | Yes / No return flag |
| Gross_Revenue_AZN | Supplied gross revenue amount |
| Net_Revenue_AZN | Supplied net revenue after discount/return treatment; returned rows have zero net revenue |
| Cost_AZN | Supplied modeled cost, with no detailed accounting policy provided |
| Profit_AZN | Supplied profit amount; returned orders can carry negative profit |

## Metric definitions

- Total net revenue and profit sum the supplied corresponding fields.
- Average order value divides total net revenue by all orders, including returned orders.
- Return rate divides rows marked Yes by all rows. Category rates use category-specific denominators.
- Average rating is the arithmetic mean across orders, not a customer-weighted score.
- Customer revenue aggregates the observed period only and must not be called lifetime value.

## Validation and interpretation

The audited file has no missing cells or duplicate Order_ID values. SQL and Python summaries should agree when they use the same grain and filters. SQLite REAL uses floating-point arithmetic; round final displayed monetary totals to two decimals.

The synthetic cost rules and data generator should be documented before extending this into an accounting or forecasting example. Demographic fields are present but are not needed for the portfolio's core analysis. No causal or real-market conclusions follow from this simulated dataset.
