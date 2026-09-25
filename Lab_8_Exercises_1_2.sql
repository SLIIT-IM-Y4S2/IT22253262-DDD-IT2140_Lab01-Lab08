-- IT2140 Lab Sheet 08 - Exercises 1 c,d,e and Exercises 2 c,d,e (subqueries)
-- Asan M A M | IT22253262
-- Needs: Datasets/Data_Set.sql


-- EXERCISES 1 - single-row subqueries

-- c. Departments whose budget is greater than the average salary.
SELECT did,
       budget
FROM dept
WHERE budget > (SELECT AVG(salary) FROM emp);


-- d. Employees whose salary is not equal to the average salary.
SELECT *
FROM emp
WHERE salary <> (SELECT AVG(salary) FROM emp);


-- e. Employees earning less than the manager of department 'ITSD'.
SELECT *
FROM emp
WHERE salary < (SELECT salary
                FROM emp
                WHERE eid = (SELECT managerId
                             FROM dept
                             WHERE did = 'ITSD'));


-- EXERCISES 2 - multiple-row subqueries

-- c. Employees whose salary is greater than ALL salaries in 'Admin'.
--    No rows: Admin holds Krishan and Prasad on 95,000, the joint highest
--    salary in the company.
SELECT *
FROM emp
WHERE salary > ALL (SELECT e.salary
                    FROM emp e
                    INNER JOIN works w ON e.eid = w.eid
                    WHERE w.did = 'Admin');


-- d. Employees whose salary is greater than ANY salary in 'Finance'.
SELECT *
FROM emp
WHERE salary > ANY (SELECT e.salary
                    FROM emp e
                    INNER JOIN works w ON e.eid = w.eid
                    WHERE w.did = 'Finance');


-- e. Departments where ALL assigned employees earn 30,000 or more.
--    EXISTS is needed: ALL is true over an empty set, so without it the
--    departments with no employees (SESD, Marketing) would qualify too.
SELECT d.did
FROM dept d
WHERE EXISTS (SELECT 1
              FROM works w
              WHERE w.did = d.did)
  AND 30000 <= ALL (SELECT e.salary
                    FROM emp e
                    INNER JOIN works w ON e.eid = w.eid
                    WHERE w.did = d.did);
