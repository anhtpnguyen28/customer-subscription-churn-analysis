-- Business Question:
-- What is the monthly churn rate?

-- Churn Definition:
-- A customer is considered churned if churn_status = 'Yes'

-- Metrics:
-- Monthly churn rate = churned customers / total customers

WITH base AS (
    SELECT
        DATE_TRUNC('month', signup_date) AS signup_month,
        user_id,
        churn
    FROM customer_subscriptions
)

SELECT
    signup_month,
    COUNT(DISTINCT user_id) AS total_users,
    COUNT(DISTINCT CASE WHEN churn = 'Yes' THEN user_id END) AS churned_users,
    COUNT(DISTINCT CASE WHEN churn = 'Yes' THEN user_id END) * 1.0 
        / COUNT(DISTINCT user_id) AS churn_rate
FROM base
GROUP BY signup_month
ORDER BY signup_month;
