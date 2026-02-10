-- Business Question:
-- What is the monthly churn rate?

-- Churn Definition:
-- A customer is considered churned if churn_status = 'Yes'

-- Metrics:
-- Monthly churn rate = churned customers / total customers

WITH base AS (
  SELECT
    DATE_TRUNC('month', signup_date) AS month,
    user_id,
    churn
  FROM customers
),
agg AS (
  SELECT
    month,
    COUNT(DISTINCT user_id) AS total_customers,
    COUNT(DISTINCT CASE WHEN churn = 'Yes' THEN customer_id END) AS churned_customers
  FROM base
  GROUP BY month
)
SELECT
  month,
  churned_customers,
  total_customers,
  churned_customers * 1.0 / total_customers AS churn_rate
FROM agg
ORDER BY month;
