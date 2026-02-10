-- Business Question:
-- How long do customers from different signup cohorts stay subscribed?

-- Cohort Definition:
-- Cohort is defined by signup month

-- Retention Proxy:
-- Tenure in months before churn

WITH cohort_base AS (
    SELECT
        user_id,
        DATE_TRUNC('month', signup_date) AS cohort_month,
        tenure_months
    FROM customer_subscriptions
    WHERE churn = 'Yes'
)

SELECT
    cohort_month,
    COUNT(DISTINCT user_id) AS churned_users,
    AVG(tenure_months) AS avg_tenure_months,
    MIN(tenure_months) AS min_tenure,
    MAX(tenure_months) AS max_tenure
FROM cohort_base
GROUP BY cohort_month
ORDER BY cohort_month;

