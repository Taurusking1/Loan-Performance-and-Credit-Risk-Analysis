-- INCOME DISTRIBUTION (MEAN AND MEDIAN) --

WITH ordered AS (
    SELECT
        consolidated_annual_income,
        ROW_NUMBER() OVER (ORDER BY consolidated_annual_income) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM clean_loanset
)
SELECT
    (SELECT ROUND(AVG(consolidated_annual_income),2)
     FROM clean_loanset) AS Mean_Income,
ROUND(AVG(consolidated_annual_income),2) AS Median_Income
FROM ordered
WHERE rn IN (
    FLOOR((total_rows + 1)/2),
    FLOOR((total_rows + 2)/2)
);


-- INCOME SEGMENTATION --
SELECT
CASE
    WHEN consolidated_annual_income < 50000 THEN 'Low Income'
    WHEN consolidated_annual_income BETWEEN 50000 AND 99999 THEN 'Lower Middle'
    WHEN consolidated_annual_income BETWEEN 100000 AND 199999 THEN 'Upper Middle'
    ELSE 'High Income'
END AS Income_Group,
COUNT(*) AS Borrowers
FROM clean_loanset
GROUP BY Income_Group
ORDER BY
FIELD(
Income_Group,
'Low Income',
'Lower Middle',
'Upper Middle',
'High Income'
);


-- DEFAULT RATE BY INCOME GROUP --
SELECT
  CASE
    WHEN consolidated_annual_income < 50000 THEN 'Low Income'
    WHEN consolidated_annual_income BETWEEN 50000 AND 99999 THEN 'Lower Middle'
    WHEN consolidated_annual_income BETWEEN 100000 AND 199999 THEN 'Upper Middle'
    ELSE 'High Income'
  END AS Income_Group,
COUNT(*) AS Total_Loans,
SUM(
  CASE
     WHEN loan_status='Charged Off'
     THEN 1
     ELSE 0
  END
) AS Defaults,
ROUND(
100*
SUM(
  CASE
      WHEN loan_status='Charged Off'
      THEN 1
	  ELSE 0
  END
)/COUNT(*),2
) AS Default_Rate
FROM clean_loanset
GROUP BY Income_Group;


-- AVERAGE LOAN AMOUNT BY INCOME GROUP --
SELECT
  CASE
    WHEN consolidated_annual_income < 50000 THEN 'Low Income'
    WHEN consolidated_annual_income BETWEEN 50000 AND 99999 THEN 'Lower Middle'
    WHEN consolidated_annual_income BETWEEN 100000 AND 199999 THEN 'Upper Middle'
    ELSE 'High Income'
  END AS Income_Group,
COUNT(*) AS Borrowers,
ROUND(AVG(loan_amount),2) AS Avg_Loan,
MIN(loan_amount) AS Min_Loan,
MAX(loan_amount) AS Max_Loan
FROM clean_loanset
GROUP BY Income_Group;


-- AVERAGE INTEREST RATE BY INCOME GROUP --
SELECT
  CASE
    WHEN consolidated_annual_income < 50000 THEN 'Low Income'
    WHEN consolidated_annual_income BETWEEN 50000 AND 99999 THEN 'Lower Middle'
    WHEN consolidated_annual_income BETWEEN 100000 AND 199999 THEN 'Upper Middle'
    ELSE 'High Income'
  END AS Income_Group,
ROUND(AVG(interest_rate),2) AS Avg_Interest_Rate
FROM clean_loanset
GROUP BY Income_Group;


-- LOAN STATUS BY INCOME GROUP --
SELECT
  CASE
    WHEN consolidated_annual_income < 50000 THEN 'Low Income'
    WHEN consolidated_annual_income BETWEEN 50000 AND 99999 THEN 'Lower Middle'
    WHEN consolidated_annual_income BETWEEN 100000 AND 199999 THEN 'Upper Middle'
    ELSE 'High Income'
  END AS Income_Group,
loan_status,
COUNT(*) AS Loans
FROM clean_loanset
GROUP BY Income_Group, loan_status
ORDER BY Income_Group;

