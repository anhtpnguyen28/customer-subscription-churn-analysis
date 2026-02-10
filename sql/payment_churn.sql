-- Business Question:
-- Do payment failures increase the likelihood of customer churn?

-- Churn Definition:
-- A user is considered churned if churn = 'Yes'

-- Metrics:
-- Churn rate by payment failure level
-- Average payment failures by churn status


-- Analysis 1: Average payment failures by churn status
SELECT
    churn,
    COUNT(DISTINCT user_id) AS total_users,
    AVG(payment_failures) AS avg_payment_failures
FROM customer_subscriptions
GROUP BY churn;


-- Analysis 2: Churn rate by payment failure level
WITH payment_bucket AS (
    SELECT
        user_id,
        churn,
        CASE
            WHEN payment_failures = 0 THEN 'No Failures'
            WHEN payment_failures BETWEEN 1 AND 2 THEN '1–2 Failures'
            ELSE '3+ Failures'
        END AS payment_issue_level
    FROM customer_subscriptions
)

SELECT
    payment_issue_level,
    COUNT(DISTINCT user_id) AS total_users,
    COUNT(DISTINCT CASE WHEN churn = 'Yes' THEN user_id END) AS churned_users,
    COUNT(DISTINCT CASE WHEN churn = 'Yes' THEN user_id END) * 1.0
        / COUNT(DISTINCT user_id) AS churn_rate
FROM payment_bucket
GROUP BY payment_issue_level
ORDER BY churn_rate DESC;
