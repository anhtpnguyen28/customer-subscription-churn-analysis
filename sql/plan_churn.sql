-- Business Question:
-- How does churn rate vary by subscription plan?

-- Churn Definition:
-- A user is considered churned if churn = 'Yes'

-- Metrics:
-- Churn rate by plan
-- Average tenure by plan

WITH base AS (
    SELECT
        plan_type,
        user_id,
        churn,
        tenure_months
    FROM customer_subscriptions
)

SELECT
    plan_type,
    COUNT(DISTINCT user_id) AS total_users,
    COUNT(DISTINCT CASE WHEN churn = 'Yes' THEN user_id END) AS churned_users,
    COUNT(DISTINCT CASE WHEN churn = 'Yes' THEN user_id END) * 1.0 
        / COUNT(DISTINCT user_id) AS churn_rate,
    AVG(tenure_months) AS avg_tenure_months
FROM base
GROUP BY plan_type
ORDER BY churn_rate DESC;

