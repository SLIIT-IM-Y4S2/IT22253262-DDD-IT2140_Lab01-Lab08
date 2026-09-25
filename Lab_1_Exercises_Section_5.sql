-- IT2140 Lab Sheet 01 - Section 5 (HAVING clause)
-- Asan M A M | IT22253262
-- Needs: Datasets/Data_Set.sql


-- a. Department IDs where the number of employees is less than 3.
SELECT did
FROM works
GROUP BY did
HAVING COUNT(eid) < 3;


-- b. Each manager and the number of departments they manage, only those
--    managing more than 1, sorted by that count ascending.
SELECT e.ename      AS Manager_Name,
       COUNT(d.did) AS Number_of_Departments
FROM emp e
INNER JOIN dept d ON e.eid = d.managerId
GROUP BY e.ename
HAVING COUNT(d.did) > 1
ORDER BY Number_of_Departments ASC;


-- c. Each age group and its average salary, only where the average is
--    greater than 40,000.
SELECT age,
       AVG(salary) AS Average_Salary
FROM emp
GROUP BY age
HAVING AVG(salary) > 40000;


-- d. Number of work assignments per employee, only those with more than 2.
SELECT eid,
       COUNT(*) AS Number_of_Assignments
FROM works
GROUP BY eid
HAVING COUNT(*) > 2;


-- e. Departments with a total budget greater than 1,000,000.
SELECT did,
       SUM(budget) AS Total_Budget
FROM dept
GROUP BY did
HAVING SUM(budget) > 1000000;
