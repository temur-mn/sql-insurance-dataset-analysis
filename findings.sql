/*============================================================================
  File:     instawdb.sql

  Summary:  Creates the AdventureWorks sample database. Run this on
  any version of SQL Server (2008R2 or later) to get AdventureWorks for your
  current version. 

  Date:     October 26, 2017
  Updated:  November 14, 2025
============================================================================*/

/*
 * Columns and Datatypes:
 * age -
 * sex - 
 * bmi - 
 * children -
 * smoker -
 * region -
 * charges -
 */

---> Check for missing values
SELECT
    COUNT(*) AS total_rows,
    COUNT(age) AS age_non_null,
    COUNT(sex) AS sex_non_null,
    COUNT(bmi) AS bmi_non_null,
    COUNT(children) AS children_non_null,
    COUNT(smoker) AS smoker_non_null,
    COUNT(region) AS region_non_null,
    COUNT(charges) AS charges_non_null
FROM insurance;

/*
 * Results:
 * 
 * No missing values were detected
 *
 */

---> Check general distributions across each column

---> Patient Age Group Analysis
SELECT 
	MAX(age) as max_age,
	MIN(age) as min_age,
	AVG(age) as avg_age,
 	1.0 * (MAX(age) - MIN(age)) / 4 AS binwidth --- 4 is and optimal so far (11.5 will be approximated ~ 10)
FROM insurance;

SELECT
    CASE
        WHEN age <= 30 THEN '18-30'
        WHEN age <= 40 THEN '31-40'
        WHEN age <= 50 THEN '41-50'
        WHEN age <= 60 THEN '51-60'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS number_of_patients,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER()) AS percentage_of_total
FROM insurance
GROUP BY age_group;

/*
 * Results:
 * 
 * The young adult group is dominating over the population in the dataset
 * with highest ration ~33% in the datataset thus influencing smaller groups
 * like '60+' (~7%).
 *
 */

---> Patient Charges Analysis
SELECT 
	MAX(charges) as max_insurance_amount,
	MIN(charges) as min_insurance_amount,
	AVG(charges) as avg_insurance_amount,
 	1.0 * (MAX(achargesge) - MIN(charges)) / 4 AS binwidth --- 4 is and optimal so far (11.5 will be approximated ~ 10)
FROM insurance;

SELECT
    CASE
        WHEN charges <= 10000 THEN '1,000-10,000'
        WHEN charges <= 20000 THEN '10,001-20,000'
        WHEN charges <= 30000 THEN '20,001-30,000'
        WHEN charges <= 40000 THEN '30,001-40,000'
        WHEN charges <= 50000 THEN '40,001-50,000'
        WHEN charges <= 60000 THEN '50,001-60,000'
        ELSE '60,000+'
    END AS amount_bin,
    COUNT(*) AS number_of_patients,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER()) AS percentage_of_total,
    ROUND(AVG(charges)) AS average_per_group
FROM insurance
GROUP BY amount_bin;

/*
 * Results:
 *  amount_bin    count  p%
 * 1,000-10,000	   712	53.0
 * 10,001-20,000   353	26.0
 * 20,001-30,000   111	8.0
 * 30,001-40,000   83	6.0
 * 40,001-50,000   72	5.0
 * 50,001-60,000   4	<1
 * 60,000+	       3	<1
 * 
 */

---> 

