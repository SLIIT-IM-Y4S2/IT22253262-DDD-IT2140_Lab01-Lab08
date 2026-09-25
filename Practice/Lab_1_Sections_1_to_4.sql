-- IT2140 Lab 01, Sections 1-4 - practice, not submitted
-- Needs: ../Datasets/Data_Set.sql

-- --------------------------- SECTION 1: SELECT / WHERE ---------------------

-- a. Retrieve all information of all employees.
SELECT * FROM emp;

-- b. Names and salaries of employees who earn more than 50,000.
SELECT ename, salary FROM emp WHERE salary > 50000;

-- c. Employees whose names start with the letter 'A'.
SELECT * FROM emp WHERE ename LIKE 'A%';

-- d. Names and ages of employees younger than 30.
SELECT ename, age FROM emp WHERE age < 30;

-- e. Employees whose salary is between 20,000 and 60,000.
SELECT * FROM emp WHERE salary BETWEEN 20000 AND 60000;

-- f. Employee names whose names contain the letter 'a'.
SELECT ename FROM emp WHERE ename LIKE '%a%';

-- g. Employee ID and name of those who are either aged 24 or 28.
SELECT eid, ename FROM emp WHERE age IN (24, 28);

-- h. Employees whose age is not between 25 and 35.
SELECT * FROM emp WHERE age NOT BETWEEN 25 AND 35;

-- i. All employees whose salary is not null.
SELECT * FROM emp WHERE salary IS NOT NULL;

-- --------------------------- SECTION 2: ORDER BY ---------------------------

-- j. All employees sorted by their name.
SELECT * FROM emp ORDER BY ename;

-- a. All employees sorted in descending order of salary.
SELECT * FROM emp ORDER BY salary DESC;

-- b. Employee details ordered ascending by age and descending by salary.
SELECT * FROM emp ORDER BY age ASC, salary DESC;

-- c. All departments sorted by budget in descending order.
SELECT * FROM dept ORDER BY budget DESC;

-- d. All work assignments ordered by pct_time.
SELECT * FROM works ORDER BY pct_time;

-- --------------------------- SECTION 3: Aggregates -------------------------

-- a. How many employees are in the organization?
SELECT COUNT(*) AS Number_of_Employees FROM emp;

-- b. Total salary paid to all employees.
SELECT SUM(salary) AS Total_Salary FROM emp;

-- c. Highest and lowest salary among all employees.
SELECT MAX(salary) AS Highest_Salary, MIN(salary) AS Lowest_Salary FROM emp;

-- d. Average salary of employees.
SELECT AVG(salary) AS Average_Salary FROM emp;

-- e. How many employees are aged below 30?
SELECT COUNT(*) AS Employees_Below_30 FROM emp WHERE age < 30;

-- f. Total number of departments.
SELECT COUNT(*) AS Number_of_Departments FROM dept;

-- g. Maximum and minimum department budget.
SELECT MAX(budget) AS Max_Budget, MIN(budget) AS Min_Budget FROM dept;

-- h. Total percentage of work assigned across all employees.
SELECT SUM(pct_time) AS Total_Percentage_Assigned FROM works;

-- i. Average work time (pct_time) per employee.
SELECT AVG(pct_time) AS Average_Work_Time FROM works;

-- --------------------------- SECTION 4: GROUP BY ---------------------------

-- a. Total salary paid to employees of each age group.
SELECT age, SUM(salary) AS Total_Salary FROM emp GROUP BY age;

-- b. Number of employees working in each department, count renamed.
SELECT did, COUNT(eid) AS [Number of Employees] FROM works GROUP BY did;

-- c. How many employees earn a salary greater than 50,000?
SELECT COUNT(*) AS Employees_Earning_Above_50000 FROM emp WHERE salary > 50000;

-- d. Employees earning more than 50,000, sorted by salary ascending.
SELECT * FROM emp WHERE salary > 50000 ORDER BY salary ASC;
