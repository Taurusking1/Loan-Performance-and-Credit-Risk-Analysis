-- WHICH STATE RECEIVE TEH HIGHEST LOAN --
SELECT
    state,
    COUNT(*) AS Number_of_Loans,
    SUM(loan_amount) AS Total_Loan_Amount,
    ROUND(AVG(loan_amount),2) AS Average_Loan
FROM clean_loanset
GROUP BY state
ORDER BY Total_Loan_Amount DESC
LIMIT 10;


-- WHICH LOAN PURPOSE RECEIVES THE HIGHEST FUNDING --
SELECT
    loan_purpose,
    COUNT(*) AS Loans,
    SUM(loan_amount) AS Total_Funding,
    ROUND(AVG(loan_amount),2) AS Average_Loan
FROM clean_loanset
GROUP BY loan_purpose
ORDER BY Total_Funding DESC;


-- AVERAGE INTEREST RATE BY LOAN PURPOSE --
SELECT
    loan_purpose,
    ROUND(AVG(interest_rate),2) AS Average_Interest_Rate
FROM clean_loanset
GROUP BY loan_purpose
ORDER BY Average_Interest_Rate DESC;


-- HOME OWNERSHIP VS LOAN AMOUNT --
SELECT
    homeownership,
    COUNT(*) AS Borrowers,
    ROUND(AVG(loan_amount),2) AS Average_Loan,
    SUM(loan_amount) AS Total_Exposure
FROM clean_loanset
GROUP BY homeownership
ORDER BY Total_Exposure DESC;


-- DEFAULT RATE BY LOAN PURPOSE --
SELECT
    loan_purpose,
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
        )/COUNT(*),
        2
    ) AS Default_Rate
FROM clean_loanset
GROUP BY loan_purpose
ORDER BY Default_Rate DESC;


-- EMPLOYMENT LENGTH ANALYSIS --
SELECT
    emp_length,
    COUNT(*) AS Borrowers,
    ROUND(AVG(loan_amount),2) AS Average_Loan,
    ROUND(AVG(interest_rate),2) AS Average_Rate
FROM clean_loanset
GROUP BY emp_length
ORDER BY Borrowers DESC;


-- INCOME VERIFICATION ANALYSIS --
SELECT
    consolidated_verified_income,
    COUNT(*) AS Borrowers,
    ROUND(AVG(loan_amount),2) AS Average_Loan,
    ROUND(AVG(interest_rate),2) AS Average_Rate
FROM clean_loanset
GROUP BY consolidated_verified_income
ORDER BY Borrowers DESC;


-- CREDIT GRADE ANALYSIS --
SELECT
    grade,
    COUNT(*) AS Loans,
    ROUND(AVG(loan_amount),2) AS Average_Loan,
    ROUND(AVG(interest_rate),2) AS Average_Rate,
    ROUND(AVG(consolidated_debt_to_income),2) AS Average_DTI
FROM clean_loanset
GROUP BY grade
ORDER BY grade;


-- HIGH RISK BORROWER SEGMENT --
SELECT
    grade,
    loan_purpose,
    COUNT(*) AS Loans,
    ROUND(AVG(delinq_2y),2) AS Avg_Delinquency,
    ROUND(AVG(consolidated_debt_to_income),2) AS Avg_DTI,
    ROUND(AVG(interest_rate),2) AS Avg_Rate
FROM clean_loanset
GROUP BY grade, loan_purpose
ORDER BY Avg_Delinquency DESC,
         Avg_DTI DESC
LIMIT 10;


-- LOWEST RISK BORROWER SEGMENTS --
SELECT
    grade,
    loan_purpose,
    COUNT(*) AS Loans,
    ROUND(AVG(delinq_2y),2) AS Avg_Delinquency,
    ROUND(AVG(consolidated_debt_to_income),2) AS Avg_DTI,
    ROUND(AVG(interest_rate),2) AS Avg_Rate
FROM clean_loanset
GROUP BY grade, loan_purpose
ORDER BY Avg_Delinquency ASC,
         Avg_DTI ASC
LIMIT 10;


-- TOP BORROWING STATES BY AVAERAGE LOAN --
SELECT
    state,
    ROUND(AVG(loan_amount),2) AS Average_Loan,
    COUNT(*) AS Loans
FROM clean_loanset
GROUP BY state
HAVING COUNT(*) >= 20
ORDER BY Average_Loan DESC;


-- BORROWER PROFILE BY INCOME GROUP --
SELECT
     CASE
        WHEN consolidated_annual_income < 50000 THEN 'Low Income'
        WHEN consolidated_annual_income BETWEEN 50000 AND 99999 THEN 'Lower Middle'
        WHEN consolidated_annual_income BETWEEN 100000 AND 149999 THEN 'Upper Middle'
        ELSE 'High Income'
     END AS Income_Group,
    COUNT(*) AS Borrowers,
    ROUND(AVG(loan_amount),2) AS Avg_Loan,
    ROUND(AVG(interest_rate),2) AS Avg_Rate,
    ROUND(AVG(consolidated_debt_to_income),2) AS Avg_DTI
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


-- TOP 10 LARGEST INDIVIDUAL LOAN --
SELECT
    id,
    state,
    loan_amount,
    interest_rate,
    grade,
    loan_status
FROM clean_loanset
ORDER BY loan_amount DESC
LIMIT 10;


-- PORTFOLIO DISTRIBUTION BY LOAN TERM --
SELECT
    term,
    COUNT(*) AS Loans,
    SUM(loan_amount) AS Portfolio_Value,
    ROUND(AVG(interest_rate),2) AS Average_Rate
FROM clean_loanset
GROUP BY term;