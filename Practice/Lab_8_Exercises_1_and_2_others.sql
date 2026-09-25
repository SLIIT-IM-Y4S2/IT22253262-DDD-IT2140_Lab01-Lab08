-- IT2140 Lab 08, Exercises 1 a-b and 2 a-b - practice, not submitted
-- Needs: ../Datasets/Data_Set.sql

-- ------------------------- EXERCISES 1 (single-row) ------------------------

-- a. Employees whose salary is greater than the salary of 'Lakmal'.
SELECT *
FROM emp
WHERE salary > (SELECT salary FROM emp WHERE ename = 'Lakmal');

-- b. eid, ename, salary of employees whose salary equals the minimum salary
--    in the company.
SELECT eid, ename, salary
FROM emp
WHERE salary = (SELECT MIN(salary) FROM emp);

-- ------------------------- EXERCISES 2 (multiple-row) ----------------------

-- a. Employees who work in any department whose budget >= 1,000,000.
SELECT *
FROM emp
WHERE eid IN (SELECT w.eid
              FROM works w
              WHERE w.did IN (SELECT did FROM dept WHERE budget >= 1000000));

-- b. Employees who are not working in the 'Academic' or 'Admin' departments.
SELECT *
FROM emp
WHERE eid NOT IN (SELECT w.eid
                  FROM works w
                  WHERE w.did IN ('Academic', 'Admin'));
