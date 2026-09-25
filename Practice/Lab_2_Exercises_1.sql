-- IT2140 Lab 02, Exercises 1 - practice, not submitted
-- Needs: ../Datasets/Data_Set.sql

-- a. Employee ID, name, and the department ID(s) they are working in.
SELECT e.eid, e.ename, w.did
FROM emp e
INNER JOIN works w ON e.eid = w.eid;

-- b. Department names and the IDs of employees assigned to each.
SELECT d.did AS Department_Name, w.eid AS Employee_ID
FROM dept d
INNER JOIN works w ON d.did = w.did;

-- c. Names of employees along with the names of the departments they work in.
SELECT e.ename, d.did AS Department_Name
FROM emp e
INNER JOIN works w ON e.eid = w.eid
INNER JOIN dept d ON w.did = d.did;

-- d. Employee names and salaries for those who work in departments with a
--    budget greater than 1,000,000.
SELECT DISTINCT e.ename, e.salary
FROM emp e
INNER JOIN works w ON e.eid = w.eid
INNER JOIN dept d ON w.did = d.did
WHERE d.budget > 1000000;

-- e. Names of departments where employees spend more than 40% of their time.
SELECT DISTINCT d.did AS Department_Name
FROM dept d
INNER JOIN works w ON d.did = w.did
WHERE w.pct_time > 40;
