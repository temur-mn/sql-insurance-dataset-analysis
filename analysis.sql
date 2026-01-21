-- =========================================================
-- Insurance Cost Analysis
-- Purpose: Identify key drivers of insurance charges
-- Dataset: insurance.csv (kaggle.com/datasets/willianoliveiragibin/healthcare-insurance)
-- Author: Temur Mamanazarov
-- =========================================================

WITH base AS (
    SELECT
        age,
        sex,
        bmi,
        children,
        smoker,
        region,
        charges
    FROM insurance
),
age_binned AS (
    SELECT
        *,
        CASE
            WHEN age < 30 THEN 'Under 30'
            WHEN age < 60 THEN '30-59'
            ELSE '60+'
        END AS age_group
    FROM base
),
metrics AS (
    SELECT
        age_group,
        sex,
        COUNT(*) AS population,
        ROUND(AVG(charges), 0) AS avg_charges,
        ROUND(
            SUM(CASE WHEN smoker = 'yes' THEN 1 ELSE 0 END)
            / COUNT(*),
            3
        ) AS smoker_fraction
    FROM age_binned
    GROUP BY age_group, sex
)
SELECT *
FROM metrics
ORDER BY avg_charges DESC;