-- Business Question:
-- How does user engagement (usage) relate to churn?

-- Churn Definition:
-- A user is considered churned if churn = 'Yes'

-- Metrics:
-- Average weekly usage by churn status
-- Churn rate by usage level


-- Analysis 1:
-- Compare average usage between churned and retained users

SELECT
    churn,
    COUNT(DISTINCT user_id) AS total_users,
    AVG(avg_weekly_usage_hours) AS avg_weekly_usage
FROM customer_subscriptions
GROUP BY churn;

-- --------------------------------------------

-- Analysis 2:
-- Analyze churn rate by usage level

WITH usage_bucket AS (
    SELECT
        user_id,
        churn,
        CASE
            WHEN avg_weekly_usage_hours < 5 THEN 'Low Usage'
            WHEN avg_weekly_usage_hours BETWEEN 5 AND 10 THEN 'Medium Usage'
            ELSE 'High Usage'
        END AS usage_level
    FROM customer_subscriptions
)

SELECT
    usage_level,
    COUNT(DISTINCT user_id) AS total_users,
    COUNT(DISTINCT CASE WHEN churn = 'Yes' THEN user_id END) AS churned_users,
    COUNT(DISTINCT CASE WHEN churn = 'Yes' THEN user_id END) * 1.0
        / COUNT(DISTINCT user_id) AS churn_rate
FROM usage_bucket
GROUP BY usage_level
ORDER BY churn_rate DESC;

