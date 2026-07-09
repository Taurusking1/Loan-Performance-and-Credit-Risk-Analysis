-- CHECK DUPLICATES ---

SELECT id,
COUNT(*)
FROM clean_loanset
GROUP BY id
HAVING COUNT(*) > 1;


-- CHECK MISSING VALUES --
SELECT
SUM(emp_title IS NULL) AS Missing_EmpTitle,
SUM(emp_length IS NULL) AS Missing_EmpLength
FROM clean_loanset;


-- VERIFY PLACEHOLDERS --
SELECT
COUNT(*)
FROM clean_loanset
WHERE months_since_last_delinq = 999;


SELECT
COUNT(*)
FROM clean_loanset
WHERE months_since_90d_late = 999;


-- CHECK LOAN STATUS --
SELECT
loan_status,
COUNT(*)
FROM clean_loanset
GROUP BY loan_status;