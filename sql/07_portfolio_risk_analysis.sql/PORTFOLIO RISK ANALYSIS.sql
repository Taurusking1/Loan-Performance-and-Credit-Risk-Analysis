
-- PORTFOLIO OVERVIEW (EXECUTIVE KPI)
SELECT
    COUNT(*) AS Total_Loans,
    SUM(loan_amount) AS Total_Portfolio_Value,
    ROUND(AVG(loan_amount),2) AS Average_Loan_Amount,
    ROUND(AVG(interest_rate),2) AS Average_Interest_Rate,
    ROUND(AVG(consolidated_debt_to_income),2) AS Average_DTI,
    SUM(CASE
            WHEN loan_status='Charged Off'
            THEN 1
            ELSE 0
        END) AS Charged_Off_Loans,
    ROUND(
        100*
        SUM(CASE
                WHEN loan_status='Charged Off'
                THEN 1
                ELSE 0
            END)
        /COUNT(*),
        2
    ) AS Default_Rate
FROM clean_loanset;


-- PORTFOLIO EXPOSURE BY LOAN STATUS --
SELECT
    loan_status,
    COUNT(*) AS Total_Loans,
    SUM(loan_amount) AS Total_Exposure,
    ROUND(AVG(loan_amount),2) AS Avg_Loan_Amount
FROM clean_loanset
GROUP BY loan_status
ORDER BY Total_Exposure DESC;


-- EXPOSURE BY LOAN GRADE --
SELECT
    grade,
    COUNT(*) AS Loans,
    SUM(loan_amount) AS Exposure,
    ROUND(AVG(interest_rate),2) AS Avg_Interest_Rate
FROM clean_loanset
GROUP BY grade
ORDER BY grade;


-- RISK BY INCOME GROUP --
SELECT
  CASE
    WHEN consolidated_annual_income < 50000 THEN 'Low Income'
    WHEN consolidated_annual_income BETWEEN 50000 AND 99999 THEN 'Lower Middle'
    WHEN consolidated_annual_income BETWEEN 100000 AND 199999 THEN 'Upper Middle'
    ELSE 'High Income'
  END AS Income_Group,
COUNT(*) AS Loans,
SUM(loan_amount) AS Exposure,
ROUND(AVG(interest_rate),2) AS Avg_Rate
FROM clean_loanset
GROUP BY Income_Group;


-- AVAERAGE DTI BY LOAN STATUS --
SELECT
loan_status,
ROUND(AVG(consolidated_debt_to_income),2) AS Avg_DTI
FROM clean_loanset
GROUP BY loan_status;


-- HIGH RISK BORROWERS --
SELECT
id,
loan_amount,
interest_rate,
consolidated_debt_to_income,
delinq_2y,
num_historical_failed_to_pay,
loan_status
FROM clean_loanset
WHERE interest_rate >=18 AND consolidated_debt_to_income >=30;


-- HOME OWNERSHIP RISK --
SELECT
homeownership,
COUNT(*) AS Loans,
ROUND(AVG(interest_rate),2) AS Avg_Rate,
ROUND(AVG(consolidated_debt_to_income),2) AS Avg_DTI
FROM clean_loanset
GROUP BY homeownership;


-- RISK BY LOAN PURPOSE --
SELECT
    loan_purpose,
    COUNT(*) AS Loans,
    SUM(loan_amount) AS Total_Exposure,
    ROUND(AVG(interest_rate),2) AS Avg_Rate,
    ROUND(AVG(consolidated_debt_to_income),2) AS Avg_DTI
FROM clean_loanset
GROUP BY loan_purpose
ORDER BY Total_Exposure DESC;


-- OUTSTANDING PORFOLIO BALANCE --
SELECT
    ROUND(SUM(balance),2) AS Outstanding_Balance,
    ROUND(SUM(paid_principal),2) AS Principal_Repaid,
    ROUND(SUM(paid_interest),2) AS Interest_Repaid,
    ROUND(SUM(paid_total),2) AS Total_Collected
FROM clean_loanset;


-- CREDIT UTILIZATION RISK --
SELECT
    CASE
        WHEN total_credit_utilized /
             total_credit_limit <= 0.30
        THEN 'Low Utilization'
        WHEN total_credit_utilized /
             total_credit_limit <= 0.70
        THEN 'Moderate Utilization'
        ELSE 'High Utilization'
    END AS Credit_Utilization_Group,
    COUNT(*) AS Borrowers,
    ROUND(AVG(loan_amount),2) AS Avg_Loan,
    ROUND(AVG(interest_rate),2) AS Avg_Rate
FROM clean_loanset
WHERE total_credit_limit > 0
GROUP BY Credit_Utilization_Group
ORDER BY Borrowers DESC;


-- INCOME GROUP RISK --
SELECT
    CASE
        WHEN consolidated_annual_income < 50000
            THEN 'Low Income'
        WHEN consolidated_annual_income BETWEEN 50000 AND 99999
            THEN 'Lower Middle'
        WHEN consolidated_annual_income BETWEEN 100000 AND 149999
            THEN 'Upper Middle'
        ELSE 'High Income'
    END AS Income_Group,
    COUNT(*) AS Borrowers,
    SUM(loan_amount) AS Exposure,
    ROUND(AVG(interest_rate),2) AS Avg_Rate,
    ROUND(AVG(consolidated_debt_to_income),2) AS Avg_DTI
FROM clean_loanset
GROUP BY Income_Group
ORDER BY Exposure DESC;


-- PORTFOLIO CONCENTRATION BY STATE --
SELECT
    state,
    COUNT(*) AS Loans,
    SUM(loan_amount) AS Exposure
FROM clean_loanset
GROUP BY state
ORDER BY Exposure DESC
LIMIT 10;