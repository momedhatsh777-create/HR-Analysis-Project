
--Database Setup

CREATE DATABASE hr_analysis_emp ;

USE hr_analysis_emp;


-- Data Exploration
--------------------


-- Total number of employees

SELECT COUNT(*) AS TotalEmployees
FROM hr_data;



--  Preview the employee data

SELECT TOP 20 *
FROM hr_data;



--  Number of employees in each department

SELECT
    Department,
    COUNT(*) AS TotalEmployees
FROM hr_data
GROUP BY Department
ORDER BY TotalEmployees DESC;



--  Number of employees in each job role

SELECT
    JobRole,
    COUNT(*) AS TotalEmployees
FROM hr_data
GROUP BY JobRole
ORDER BY TotalEmployees DESC;


-- Employee distribution by gender

SELECT
    Gender,
    COUNT(*) AS TotalEmployees
FROM hr_data
GROUP BY Gender;


-- Employee distribution by marital status

SELECT
    MaritalStatus,
    COUNT(*) AS TotalEmployees
FROM hr_data
GROUP BY MaritalStatus
ORDER BY TotalEmployees DESC;


-- Employee distribution by education level

SELECT
    Education,
    COUNT(*) AS TotalEmployees
FROM hr_data
GROUP BY Education
ORDER BY Education;



-- Employee distribution by business travel frequency

SELECT
    BusinessTravel,
    COUNT(*) AS TotalEmployees
FROM hr_data
GROUP BY BusinessTravel
ORDER BY TotalEmployees DESC;



-- Employee distribution by business travel frequency

SELECT
    BusinessTravel,
    COUNT(*) AS TotalEmployees
FROM hr_data
GROUP BY BusinessTravel
ORDER BY TotalEmployees DESC;


--Data Quality Checks
------------------------

-- Check for missing monthly income values

SELECT COUNT(*) AS MissingMonthlyIncome
FROM hr_data
WHERE MonthlyIncome IS NULL;



-- Check for missing department values

SELECT COUNT(*) AS MissingDepartment
FROM hr_data
WHERE Department IS NULL;



-- Check for missing job role values

SELECT COUNT(*) AS MissingJobRole
FROM hr_data
WHERE JobRole IS NULL;



-- Check for duplicate employee numbers

SELECT
    EmployeeNumber,
    COUNT(*) AS DuplicateCount
FROM hr_data
GROUP BY EmployeeNumber
HAVING COUNT(*) > 1
ORDER BY DuplicateCount DESC;



-- Validate overtime categories

SELECT DISTINCT OverTime
FROM hr_data;


-- Validate Attrition values

SELECT DISTINCT Attrition
FROM hr_data;





-- Basic HR Analysis
--------------------


--  Highest monthly income

SELECT
    MAX(MonthlyIncome) AS HighestMonthlyIncome
FROM hr_data;


-- Lowest monthly income

SELECT
    MIN(MonthlyIncome) AS LowestMonthlyIncome
FROM hr_data;



-- Average monthly income

SELECT
    AVG(CAST(MonthlyIncome AS DECIMAL(18,2))) AS AverageMonthlyIncome
FROM hr_data;



--Number of employees leaving their jobs within each department 
select Department, count(*) as attrition_count
from hr_data
where Attrition = '1'
group by Department
order by attrition_count desc;


-- Number of employees currently working and number of employees who have left their jobs

SELECT Attrition, COUNT(*) AS TotalEmployees
FROM hr_data
GROUP BY Attrition;


-- Did the employees who left the company work overtime or not
-- This is to determine whether overtime had an impact on work performance by the time the employee left the company

select overtime,
count (*) as attrition_count
from hr_data
where Attrition = 1
group by OverTime
order by attrition_count desc ;


--What is the average salary for those who left the company
--And what is the average salary for those who stayed

select attrition ,
AVG(cast(monthlyincome as int )) as avg_salary
from hr_data
group by attrition ;



-- Average employee age

SELECT
    AVG(CAST(Age AS DECIMAL(10,2))) AS AverageAge
FROM hr_data;


-- Employees working overtime 

SELECT OverTime,
COUNT(*) AS TotalEmployees
FROM hr_data
GROUP BY OverTime;


-- Average total working years

SELECT
    AVG(CAST(TotalWorkingYears AS DECIMAL(10,2))) AS AverageWorkingYears
FROM hr_data;


-- Average years of experience by job 
SELECT JobRole,
AVG(TotalWorkingYears) AS AvgExperience
FROM hr_data
GROUP BY JobRole
ORDER BY AvgExperience DESC;


-- Average years at company

SELECT
    AVG(CAST(YearsAtCompany AS DECIMAL(10,2))) AS AverageYearsAtCompany
FROM hr_data;


-- Best jobs in terms of job satisfaction 

SELECT JobRole,
AVG(JobSatisfaction) AS AvgSatisfaction
FROM hr_data
GROUP BY JobRole
ORDER BY AvgSatisfaction DESC;




-- Most Common Educational Specializations 


SELECT EducationField,
COUNT(*) AS TotalEmployees
FROM hr_data
GROUP BY EducationField
ORDER BY TotalEmployees DESC;


--Department Analysis
-------------------------

-- Employee count by department

SELECT
    Department,
    COUNT(*) AS TotalEmployees
FROM hr_data
GROUP BY Department
ORDER BY TotalEmployees DESC;


-- Average tenure at the company by department 

SELECT Department,
AVG(YearsAtCompany) AS AvgYearsAtCompany
FROM hr_data
GROUP BY Department
ORDER BY AvgYearsAtCompany DESC;


--Average age in each department

select Department,
avg (age) as avg_age
from hr_data
group by Department
ORDER BY avg_age DESC;


-- The departments where you are most likely to be assigned work 

select JobRole ,
count (*) as attrition_count
from hr_data
where Attrition = 1
group by JobRole
order by attrition_count desc ;




--Average salary by department

SELECT
    Department,
    AVG(CAST(MonthlyIncome AS DECIMAL(18,2))) AS AverageSalary
FROM hr_data
GROUP BY Department
ORDER BY AverageSalary DESC;




-- Average age by department

SELECT
    Department,
    AVG(CAST(Age AS DECIMAL(10,2))) AS AverageAge
FROM hr_data
GROUP BY Department
ORDER BY AverageAge DESC;










--Attrition Rate
-----------------

--  Attrition rate by department

SELECT
    Department,
    COUNT(*) AS TotalEmployees,

    SUM(
        CASE
            WHEN Attrition = 1 THEN 1
            ELSE 0
        END
    ) AS EmployeesLeft,

    CAST(
        SUM(
            CASE
                WHEN Attrition = 1 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(10,2)
    ) AS AttritionRate

FROM hr_data
GROUP BY Department
ORDER BY AttritionRate DESC;






-- Job Role Analysis
--------------------

-- Employee count by job role

SELECT
    JobRole,
    COUNT(*) AS TotalEmployees
FROM hr_data
GROUP BY JobRole
ORDER BY TotalEmployees DESC;


-- Average salary by job role

SELECT
    JobRole,
    AVG(CAST(MonthlyIncome AS DECIMAL(18,2))) AS AverageSalary
FROM hr_data
GROUP BY JobRole
ORDER BY AverageSalary DESC;


-- Highest salary by job role

SELECT
    JobRole,
    MAX(MonthlyIncome) AS HighestSalary
FROM hr_data
GROUP BY JobRole
ORDER BY HighestSalary DESC;


-- Average job satisfaction by job role

SELECT
    JobRole,
    AVG(CAST(JobSatisfaction AS DECIMAL(10,2))) AS AverageSatisfaction
FROM hr_data
GROUP BY JobRole
ORDER BY AverageSatisfaction DESC;


-- Attrition count by job role

SELECT
    JobRole,
    COUNT(*) AS EmployeesLeft
FROM hr_data
WHERE Attrition = 1
GROUP BY JobRole
ORDER BY EmployeesLeft DESC;


-- Attrition rate by job role

SELECT
    JobRole,
    COUNT(*) AS TotalEmployees,

    SUM(
        CASE
            WHEN Attrition = 1 THEN 1
            ELSE 0
        END
    ) AS EmployeesLeft,

    CAST(
        SUM(
            CASE
                WHEN Attrition = 1 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(10,2)
    ) AS AttritionRate

FROM hr_data
GROUP BY JobRole
ORDER BY AttritionRate DESC;


--Overtime Analysis
-------------------

-- Employees by overtime status

SELECT
    OverTime,
    COUNT(*) AS TotalEmployees
FROM hr_data
GROUP BY OverTime;


--Attrition rate among overtime employees

SELECT
    OverTime,
    COUNT(*) AS TotalEmployees,

    SUM(
        CASE
            WHEN Attrition = 1 THEN 1
            ELSE 0
        END
    ) AS EmployeesLeft,

    CAST(
        SUM(
            CASE
                WHEN Attrition = 1 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(10,2)
    ) AS AttritionRate

FROM hr_data
GROUP BY OverTime
ORDER BY AttritionRate DESC;

SELECT 
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'hr_data'
  AND COLUMN_NAME IN ('Attrition', 'OverTime');













--CASE WHEN Analysis
---------------------


-- Employee salary segmentation

SELECT
    EmployeeNumber,
    JobRole,
    MonthlyIncome,

    CASE
        WHEN MonthlyIncome < 3000 THEN 'Low Salary'
        WHEN MonthlyIncome BETWEEN 3000 AND 7000 THEN 'Medium Salary'
        WHEN MonthlyIncome > 7000 THEN 'High Salary'
        ELSE 'Unknown'
    END AS SalaryCategory

FROM hr_data;



-- Employee age segmentation

SELECT
    EmployeeNumber,
    Age,

    CASE
        WHEN Age < 30 THEN 'Young'
        WHEN Age BETWEEN 30 AND 45 THEN 'Mid Career'
        ELSE 'Senior'
    END AS AgeGroup

FROM hr_data;



-- Employee experience segmentation

SELECT
    EmployeeNumber,
    TotalWorkingYears,

    CASE
        WHEN TotalWorkingYears < 5 THEN 'Junior'
        WHEN TotalWorkingYears BETWEEN 5 AND 10 THEN 'Intermediate'
        ELSE 'Senior'
    END AS ExperienceLevel

FROM hr_data;



-- Identify potentially high-risk employees

SELECT
    EmployeeNumber,
    Department,
    JobRole,
    Age,
    MonthlyIncome,
    OverTime,
    JobSatisfaction,
    YearsAtCompany,

    CASE
        WHEN OverTime = 1
             AND JobSatisfaction <= 2
             AND YearsAtCompany <= 3
        THEN 'High Risk'

        WHEN OverTime = 1
             OR JobSatisfaction <= 2
        THEN 'Medium Risk'

        ELSE 'Low Risk'
    END AS EmployeeRisk

FROM hr_data;


--Advanced KPI Analysis
------------------------

-- Overall company attrition rate

SELECT
    COUNT(*) AS TotalEmployees,

    SUM(
        CASE
            WHEN Attrition = 1 THEN 1
            ELSE 0
        END
    ) AS EmployeesLeft,

    CAST(
        SUM(
            CASE
                WHEN Attrition = 1 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(10,2)
    ) AS OverallAttritionRate

FROM hr_data;


--  Average salary by attrition status

SELECT
    Attrition,
    COUNT(*) AS Employees,
    AVG(CAST(MonthlyIncome AS DECIMAL(18,2))) AS AverageSalary
FROM hr_data
GROUP BY Attrition;

-- Average satisfaction by attrition status

SELECT
    Attrition,
    AVG(CAST(JobSatisfaction AS DECIMAL(10,2))) AS AverageJobSatisfaction,
    AVG(CAST(EnvironmentSatisfaction AS DECIMAL(10,2))) AS AverageEnvironmentSatisfaction
FROM hr_data
GROUP BY Attrition;


-- Average experience by attrition status

SELECT
    Attrition,
    AVG(CAST(TotalWorkingYears AS DECIMAL(10,2))) AS AverageExperience,
    AVG(CAST(YearsAtCompany AS DECIMAL(10,2))) AS AverageYearsAtCompany
FROM hr_data
GROUP BY Attrition;


--Subqueries
--------------

--  Employees earning above company average salary

SELECT
    EmployeeNumber,
    JobRole,
    Department,
    MonthlyIncome
FROM hr_data
WHERE MonthlyIncome >
(
    SELECT AVG(MonthlyIncome)
    FROM hr_data
)
ORDER BY MonthlyIncome DESC;


--  Employees earning above their department average salary

SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome
FROM hr_data AS e
WHERE MonthlyIncome >
(
    SELECT AVG(MonthlyIncome)
    FROM hr_data AS d
    WHERE d.Department = e.Department
)
ORDER BY Department, MonthlyIncome DESC;


--  Employees with the maximum salary in their job role

SELECT
    EmployeeNumber,
    JobRole,
    MonthlyIncome
FROM hr_data AS e
WHERE MonthlyIncome =
(
    SELECT MAX(MonthlyIncome)
    FROM hr_data AS x
    WHERE x.JobRole = e.JobRole
)
ORDER BY MonthlyIncome DESC;


-- Employees earning below their job role average

SELECT
    EmployeeNumber,
    JobRole,
    MonthlyIncome
FROM hr_data AS e
WHERE MonthlyIncome <
(
    SELECT AVG(MonthlyIncome)
    FROM hr_data AS x
    WHERE x.JobRole = e.JobRole
)
ORDER BY JobRole, MonthlyIncome;



 
--Window Functions
-------------------

--  Rank employees by salary

SELECT
    EmployeeNumber,
    JobRole,
    Department,
    MonthlyIncome,

    RANK() OVER (
        ORDER BY MonthlyIncome DESC
    ) AS SalaryRank

FROM hr_data;


-- Rank employees by salary within each department

SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome,

    RANK() OVER (
        PARTITION BY Department
        ORDER BY MonthlyIncome DESC
    ) AS DepartmentSalaryRank

FROM hr_data;


-- Unique employee ranking within department

SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome,

    ROW_NUMBER() OVER (
        PARTITION BY Department
        ORDER BY MonthlyIncome DESC
    ) AS EmployeeRowNumber

FROM hr_data;


-- Dense salary ranking

SELECT
    EmployeeNumber,
    JobRole,
    MonthlyIncome,

    DENSE_RANK() OVER (
        ORDER BY MonthlyIncome DESC
    ) AS SalaryDenseRank

FROM hr_data;


-- Divide employees into four salary groups

SELECT
    EmployeeNumber,
    MonthlyIncome,

    NTILE(4) OVER (
        ORDER BY MonthlyIncome DESC
    ) AS SalaryQuartile

FROM hr_data;


-- Compare employee salary with department average

SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome,

    AVG(MonthlyIncome) OVER (
        PARTITION BY Department
    ) AS DepartmentAverageSalary

FROM hr_data;


--  Employee salary contribution within department

SELECT
    EmployeeNumber,
    Department,
    MonthlyIncome,

    CAST(
        MonthlyIncome * 100.0
        /
        SUM(MonthlyIncome) OVER (
            PARTITION BY Department
        )
        AS DECIMAL(10,2)
    ) AS SalaryContributionPercent

FROM hr_data;



-- LAG / LEAD
---------------

-- Compare employee salary with previous employee

SELECT
    EmployeeNumber,
    Department,
    MonthlyIncome,

    LAG(MonthlyIncome) OVER (
        PARTITION BY Department
        ORDER BY MonthlyIncome
    ) AS PreviousSalary

FROM hr_data;


-- Salary difference from previous employee

SELECT
    EmployeeNumber,
    Department,
    MonthlyIncome,

    MonthlyIncome
    -
    LAG(MonthlyIncome) OVER (
        PARTITION BY Department
        ORDER BY MonthlyIncome
    ) AS SalaryDifference

FROM hr_data;


--  Compare current employee salary with next employee

SELECT
    EmployeeNumber,
    Department,
    MonthlyIncome,

    LEAD(MonthlyIncome) OVER (
        PARTITION BY Department
        ORDER BY MonthlyIncome
    ) AS NextSalary

FROM hr_data;


--Salary Analysis
-------------------


-- Salary statistics by department

SELECT
    Department,
    MIN(MonthlyIncome) AS MinimumSalary,
    MAX(MonthlyIncome) AS MaximumSalary,
    AVG(MonthlyIncome) AS AverageSalary
FROM hr_data
GROUP BY Department
ORDER BY AverageSalary DESC;


-- Salary gap within each job role

SELECT
    JobRole,
    MAX(MonthlyIncome) - MIN(MonthlyIncome) AS SalaryGap
FROM hr_data
GROUP BY JobRole
ORDER BY SalaryGap DESC;


-- Top 10 highest paid employees

SELECT TOP 10
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome
FROM hr_data
ORDER BY MonthlyIncome DESC;


--  Employees by performance rating

SELECT
    PerformanceRating,
    COUNT(*) AS TotalEmployees
FROM hr_data
GROUP BY PerformanceRating
ORDER BY PerformanceRating DESC;


-- Average salary by performance rating

SELECT
    PerformanceRating,
    COUNT(*) AS TotalEmployees,
    AVG(MonthlyIncome) AS AverageSalary
FROM hr_data
GROUP BY PerformanceRating
ORDER BY PerformanceRating DESC;


-- Average salary by education field

SELECT
    EducationField,
    AVG(MonthlyIncome) AS AverageSalary,
    COUNT(*) AS TotalEmployees
FROM hr_data
GROUP BY EducationField
ORDER BY AverageSalary DESC;



-- Join department employee count with department salary

WITH EmployeeCount AS
(
    SELECT
        Department,
        COUNT(*) AS TotalEmployees
    FROM hr_data
    GROUP BY Department
),
SalaryStats AS
(
    SELECT
        Department,
        AVG(MonthlyIncome) AS AverageSalary
    FROM hr_data
    GROUP BY Department
)

SELECT
    e.Department,
    e.TotalEmployees,
    s.AverageSalary
FROM EmployeeCount e
INNER JOIN SalaryStats s
    ON e.Department = s.Department
ORDER BY e.TotalEmployees DESC;




-- SELF JOIN
-------------

-- Find employees working in the same department

SELECT TOP 50
    e1.EmployeeNumber AS Employee1,
    e2.EmployeeNumber AS Employee2,
    e1.Department
FROM hr_data e1
INNER JOIN hr_data e2
    ON e1.Department = e2.Department
    AND e1.EmployeeNumber < e2.EmployeeNumber
ORDER BY e1.Department;










/* =========================================================
   VIEWS
   ========================================================= */

-- View 1: Employee Summary
CREATE VIEW vw_EmployeeSummary AS
SELECT
    EmployeeNumber,
    Age,
    Gender,
    Department,
    JobRole,
    MonthlyIncome,
    TotalWorkingYears,
    YearsAtCompany,
    JobSatisfaction,
    EnvironmentSatisfaction,
    OverTime,
    Attrition
FROM hr_data;
GO


-- View 2: Department Analysis
CREATE VIEW vw_DepartmentAnalysis AS
SELECT
    Department,
    COUNT(*) AS TotalEmployees,

    SUM(
        CASE
            WHEN Attrition = 1 THEN 1
            ELSE 0
        END
    ) AS EmployeesLeft,

    CAST(
        SUM(
            CASE
                WHEN Attrition = 1 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(10,2)
    ) AS AttritionRate,

    CAST(
        AVG(MonthlyIncome)
        AS DECIMAL(18,2)
    ) AS AverageSalary,

    CAST(
        AVG(Age)
        AS DECIMAL(10,2)
    ) AS AverageAge

FROM hr_data
GROUP BY Department;
GO


-- View 3: Job Role Analysis
CREATE VIEW vw_JobRoleAnalysis AS
SELECT
    JobRole,
    COUNT(*) AS TotalEmployees,

    SUM(
        CASE
            WHEN Attrition = 1 THEN 1
            ELSE 0
        END
    ) AS EmployeesLeft,

    CAST(
        SUM(
            CASE
                WHEN Attrition = 1 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*)
        AS DECIMAL(10,2)
    ) AS AttritionRate,

    CAST(
        AVG(MonthlyIncome)
        AS DECIMAL(18,2)
    ) AS AverageSalary,

    CAST(
        AVG(JobSatisfaction)
        AS DECIMAL(10,2)
    ) AS AverageJobSatisfaction

FROM hr_data
GROUP BY JobRole;
GO


-- View 4: Attrition Analysis
CREATE VIEW vw_AttritionAnalysis AS
SELECT
    Attrition,
    COUNT(*) AS TotalEmployees,

    CAST(
        AVG(MonthlyIncome)
        AS DECIMAL(18,2)
    ) AS AverageSalary,

    CAST(
        AVG(Age)
        AS DECIMAL(10,2)
    ) AS AverageAge,

    CAST(
        AVG(TotalWorkingYears)
        AS DECIMAL(10,2)
    ) AS AverageExperience,

    CAST(
        AVG(YearsAtCompany)
        AS DECIMAL(10,2)
    ) AS AverageYearsAtCompany,

    CAST(
        AVG(JobSatisfaction)
        AS DECIMAL(10,2)
    ) AS AverageJobSatisfaction

FROM hr_data
GROUP BY Attrition;
GO



SELECT * FROM vw_EmployeeSummary;

SELECT * 
FROM vw_DepartmentAnalysis
ORDER BY AttritionRate DESC;

SELECT *
FROM vw_JobRoleAnalysis
ORDER BY AttritionRate DESC;

SELECT *
FROM vw_AttritionAnalysis;













/* =========================================================
   STORED PROCEDURES
   ========================================================= */

-- Procedure 1: Overall HR Report
CREATE PROCEDURE sp_HR_Overview
AS
BEGIN

    SELECT
        COUNT(*) AS TotalEmployees,

        SUM(
            CASE
                WHEN Attrition = 1 THEN 1
                ELSE 0
            END
        ) AS EmployeesLeft,

        CAST(
            SUM(
                CASE
                    WHEN Attrition = 1 THEN 1
                    ELSE 0
                END
            ) * 100.0 / COUNT(*)
            AS DECIMAL(10,2)
        ) AS AttritionRate,

        CAST(AVG(MonthlyIncome) AS DECIMAL(18,2))
            AS AverageSalary,

        CAST(AVG(Age) AS DECIMAL(10,2))
            AS AverageAge,

        CAST(AVG(TotalWorkingYears) AS DECIMAL(10,2))
            AS AverageExperience

    FROM hr_data;

END;
GO


-- Procedure 2: Department Report
CREATE PROCEDURE sp_DepartmentReport
    @Department VARCHAR(100)
AS
BEGIN

    SELECT
        Department,
        COUNT(*) AS TotalEmployees,

        SUM(
            CASE
                WHEN Attrition = 1 THEN 1
                ELSE 0
            END
        ) AS EmployeesLeft,

        CAST(
            SUM(
                CASE
                    WHEN Attrition = 1 THEN 1
                    ELSE 0
                END
            ) * 100.0 / COUNT(*)
            AS DECIMAL(10,2)
        ) AS AttritionRate,

        CAST(AVG(MonthlyIncome) AS DECIMAL(18,2))
            AS AverageSalary,

        CAST(AVG(Age) AS DECIMAL(10,2))
            AS AverageAge

    FROM hr_data

    WHERE Department = @Department

    GROUP BY Department;

END;
GO


-- Procedure 3: Job Role Report
CREATE PROCEDURE sp_JobRoleReport
    @JobRole VARCHAR(100)
AS
BEGIN

    SELECT
        JobRole,
        COUNT(*) AS TotalEmployees,

        SUM(
            CASE
                WHEN Attrition = 1 THEN 1
                ELSE 0
            END
        ) AS EmployeesLeft,

        CAST(
            SUM(
                CASE
                    WHEN Attrition = 1 THEN 1
                    ELSE 0
                END
            ) * 100.0 / COUNT(*)
            AS DECIMAL(10,2)
        ) AS AttritionRate,

        CAST(AVG(MonthlyIncome) AS DECIMAL(18,2))
            AS AverageSalary,

        CAST(AVG(JobSatisfaction) AS DECIMAL(10,2))
            AS AverageSatisfaction

    FROM hr_data

    WHERE JobRole = @JobRole

    GROUP BY JobRole;

END;
GO


-- Procedure 4: Overtime Report
CREATE PROCEDURE sp_OvertimeReport
    @OverTime BIT
AS
BEGIN

    SELECT
        OverTime,
        COUNT(*) AS TotalEmployees,

        SUM(
            CASE
                WHEN Attrition = 1 THEN 1
                ELSE 0
            END
        ) AS EmployeesLeft,

        CAST(
            SUM(
                CASE
                    WHEN Attrition = 1 THEN 1
                    ELSE 0
                END
            ) * 100.0 / COUNT(*)
            AS DECIMAL(10,2)
        ) AS AttritionRate

    FROM hr_data

    WHERE OverTime = @OverTime

    GROUP BY OverTime;

END;
GO




EXEC sp_HR_Overview;

EXEC sp_DepartmentReport
    @Department = 'Sales';

EXEC sp_JobRoleReport
    @JobRole = 'Sales Executive';

EXEC sp_OvertimeReport
    @OverTime = 1;



    /* =========================================================
   USER DEFINED FUNCTIONS
   ========================================================= */

-- Function 1: Age Group
CREATE FUNCTION fn_AgeGroup
(
    @Age INT
)
RETURNS VARCHAR(20)
AS
BEGIN

    DECLARE @Result VARCHAR(20);

    SET @Result =
        CASE
            WHEN @Age < 30 THEN 'Young'
            WHEN @Age BETWEEN 30 AND 45 THEN 'Mid Career'
            ELSE 'Senior'
        END;

    RETURN @Result;

END;
GO


-- Function 2: Salary Category
CREATE FUNCTION fn_SalaryCategory
(
    @MonthlyIncome DECIMAL(18,2)
)
RETURNS VARCHAR(20)
AS
BEGIN

    DECLARE @Result VARCHAR(20);

    SET @Result =
        CASE
            WHEN @MonthlyIncome < 3000 THEN 'Low Salary'
            WHEN @MonthlyIncome BETWEEN 3000 AND 7000 THEN 'Medium Salary'
            WHEN @MonthlyIncome > 7000 THEN 'High Salary'
            ELSE 'Unknown'
        END;

    RETURN @Result;

END;
GO


-- Function 3: Employee Risk
CREATE FUNCTION fn_EmployeeRisk
(
    @OverTime BIT,
    @JobSatisfaction INT,
    @YearsAtCompany INT
)
RETURNS VARCHAR(20)
AS
BEGIN

    DECLARE @Result VARCHAR(20);

    SET @Result =
        CASE
            WHEN @OverTime = 1
                 AND @JobSatisfaction <= 2
                 AND @YearsAtCompany <= 3
                THEN 'High Risk'

            WHEN @OverTime = 1
                 OR @JobSatisfaction <= 2
                THEN 'Medium Risk'

            ELSE 'Low Risk'
        END;

    RETURN @Result;

END;
GO




SELECT
    EmployeeNumber,
    Age,
    dbo.fn_AgeGroup(Age) AS AgeGroup
FROM hr_data; 



SELECT
    EmployeeNumber,
    MonthlyIncome,
    dbo.fn_SalaryCategory(MonthlyIncome) AS SalaryCategory
FROM hr_data;





SELECT
    EmployeeNumber,
    OverTime,
    JobSatisfaction,
    YearsAtCompany,
    dbo.fn_EmployeeRisk(
        OverTime,
        JobSatisfaction,
        YearsAtCompany
    ) AS EmployeeRisk
FROM hr_data;




/* =========================================================
   TRANSACTION
   ========================================================= */

BEGIN TRANSACTION;

BEGIN TRY

    SELECT
        COUNT(*) AS EmployeesBefore
    FROM hr_data;

    -- Example of a temporary update
    UPDATE hr_data
    SET MonthlyIncome = MonthlyIncome
    WHERE EmployeeNumber = 1;

    SELECT
        EmployeeNumber,
        MonthlyIncome
    FROM hr_data
    WHERE EmployeeNumber = 1;

    -- Rollback to protect original data
    ROLLBACK TRANSACTION;

    PRINT 'Transaction rolled back successfully.';

END TRY

BEGIN CATCH

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    PRINT 'Transaction failed.';
    PRINT ERROR_MESSAGE();

END CATCH;