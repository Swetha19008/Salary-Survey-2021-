create database final_project;
use final_project;

select * from salary;

SELECT COUNT(*) AS total_rows
FROM salary;

DESCRIBE salary;


#--- (a.) AVERAGE SALARY BY INDUSTRY & GENDER:
SELECT 
    Industry,
    Gender,
    ROUND(AVG(`Total Salary`)) AS Average_Salary
FROM salary
GROUP BY Industry, Gender;


#--- (b.) TOTAL SALARY COMPENSATION by JOB TITLE:
SELECT `Job Title`,
    SUM(
        COALESCE(CAST(`Annual Salary` AS DECIMAL(12)), 0) +
        COALESCE(CAST(`Additional Monetary Compensation` AS DECIMAL(12)), 0)
    ) AS Total_Compensation
FROM salary
GROUP BY `Job Title`
ORDER BY Total_Compensation DESC;


#--- (c.) SALARY DISTRIBUTION by EDUCATION LEVEL :
SELECT
    `Highest Level of Education Completed` AS Education_Level,
    AVG(CAST(
        REPLACE(
            REPLACE(
                REPLACE(`Total Salary`, ',', ''), '$', ''), '£', ''
        ) AS DECIMAL(12)
    )) AS Avg_Salary,
    MIN(CAST(
        REPLACE(
            REPLACE(
                REPLACE(`Total Salary`, ',', ''), '$', ''), '£', ''
        ) AS DECIMAL(12)
    )) AS Min_Salary,
    MAX(CAST(
        REPLACE(
            REPLACE(
                REPLACE(`Total Salary`, ',', ''), '$', ''), '£', ''
        ) AS DECIMAL(12)
    )) AS Max_Salary
FROM salary
WHERE `Highest Level of Education Completed` IS NOT NULL
  AND `Total Salary` IS NOT NULL
GROUP BY `Highest Level of Education Completed`
ORDER BY Avg_Salary DESC;


#--- (d.) NUMBER of EMPLOYESS by INDUSTRY & YEARS of EXPERIENCE :
SELECT
    `Industry`,
    `Years of Professional Experience Overall`,
    COUNT(*) AS Number_of_Employees
FROM salary
WHERE
    `Industry` IS NOT NULL
    AND `Years of Professional Experience Overall` IS NOT NULL
GROUP BY
    `Industry`,
    `Years of Professional Experience Overall`
ORDER BY
    `Industry`,
    `Years of Professional Experience Overall`;


#--- (e.) MEDIAN SALARY by AGE RANGE & GENDER :
SELECT
  `Age Range`,
  Gender,
  SUBSTRING_INDEX(
    SUBSTRING_INDEX(
      GROUP_CONCAT(`Total Salary` ORDER BY `Total Salary`),
      ',',
      CEIL(COUNT(*)/2)
    ),
    ',',
    -1
  ) AS Median_Salary
FROM salary
WHERE
  `Total Salary` IS NOT NULL
  AND `Age Range` IS NOT NULL
  AND Gender IS NOT NULL
GROUP BY `Age Range`, Gender;

DESCRIBE salary;


#--- (f.) JOB TITLES with THE HIGHEST SALARY in EACH COUNTRY  :
SELECT 
    `Country`,
    `Job Title`,
    MAX(`Total Salary`) AS Highest_Salary
FROM salary
GROUP BY `Country`, `Job Title`
ORDER BY `Country`, Highest_Salary DESC;


#--- (g.) AVERAGE SALARY by CITY & INDUSTRY :
SELECT 
    `City`,
    `Industry`,
    ROUND(AVG(`Total Salary`), 0) AS Avg_Salary
FROM salary
WHERE `Total Salary` IS NOT NULL
GROUP BY `City`, `Industry`
ORDER BY `Industry`, Avg_Salary DESC;


#--- (h.) PERCENTAGE of EMPLOYEES with ADDITIONAL MONETARY COMPENSATION by GENDER  :
SELECT 
    `Gender`,
    ROUND(
        100.0 * 
        SUM(CASE 
                WHEN `Additional Monetary Compensation` IS NOT NULL 
                     AND `Additional Monetary Compensation` > 0 
                THEN 1 ELSE 0 
            END) 
        / COUNT(*),
    2) AS Percentage_With_Additional_Comp
FROM salary
GROUP BY `Gender`;


#--- (i.) TOTAL COMPENSATION by JOB TITLE & YEARS of EXPERIENCE  :
SELECT 
    `Job Title`,
    `Years of Professional Experience Overall`,
    SUM(`Total Salary`) AS Total_Compensation
FROM salary
WHERE `Total Salary` IS NOT NULL
GROUP BY 
    `Job Title`,
    `Years of Professional Experience Overall`
ORDER BY 
    `Job Title`,
    Total_Compensation DESC;
    

#--- (j.) AVERAGE SALARY by INDUSTRY, GENDER & EDUCATION LEVEL :
SELECT 
    `Industry`,
    `Gender`,
    `Highest Level of Education Completed`,
    ROUND(AVG(`Total Salary`), 0) AS Avg_Salary
FROM salary
WHERE `Total Salary` IS NOT NULL
GROUP BY 
    `Industry`,
    `Gender`,
    `Highest Level of Education Completed`
ORDER BY 
    `Industry`,
    Avg_Salary DESC;

















    










       
