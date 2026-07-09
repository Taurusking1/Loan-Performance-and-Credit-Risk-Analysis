-- TOTAL LOANS --
SELECT COUNT(*)
FROM clean_loanset;


-- TOTAL LOAN AMOUNT --
SELECT
SUM(loan_amount)
FROM clean_loanset;


-- AVERAGE LOAN AMOUNT --
SELECT
AVG(loan_amount)
FROM clean_loanset;


-- LOAN STATUS DISTRIBUTION --
SELECT
loan_status,
COUNT(*)
FROM clean_loanset
GROUP BY loan_status;


-- INTEREST RATE STATISTICS --
SELECT
MIN(interest_rate),
AVG(interest_rate),
MAX(interest_rate)
FROM clean_loanset;


-- GRADE DISTRIBUTION --
SELECT
grade,
COUNT(*)
FROM clean_loanset
GROUP BY grade;