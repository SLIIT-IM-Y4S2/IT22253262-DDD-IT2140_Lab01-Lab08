-- IT2140 Lab Sheet 02 - Exercises 2 (table joining)
-- Asan M A M | IT22253262
-- Needs: Datasets/Data_Set.sql
--
-- dept has no separate name column - did holds the name ('Admin', 'Finance'),
-- so (a) and (b) differ only in whether dept is joined.


-- a. Number of employees in each department, by department ID.
SELECT w.did        AS Department_ID,
       COUNT(w.eid) AS [Number of Employees]
FROM works w
GROUP BY w.did;


-- b. Number of employees in each department, by department name.
SELECT d.did        AS Department_Name,
       COUNT(w.eid) AS [Number of Employees]
FROM dept d
INNER JOIN works w ON d.did = w.did
GROUP BY d.did;


-- c. Departments with more than 2 employees assigned, IDs only.
SELECT w.did AS Department_ID
FROM works w
GROUP BY w.did
HAVING COUNT(w.eid) > 2;


-- d. Same, showing the department name and employee count, sorted by count
--    ascending.
SELECT d.did        AS Department_Name,
       COUNT(w.eid) AS Number_of_Employees
FROM dept d
INNER JOIN works w ON d.did = w.did
GROUP BY d.did
HAVING COUNT(w.eid) > 2
ORDER BY Number_of_Employees ASC;
