-- PORTFOLIO DELIQUENCY SUMMARY --
SELECT
    DelinquencyCategory,
    COUNT(*) AS loan_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM clean_loanset), 2) AS pct_portfolio,
    SUM(loan_amount) AS exposure,
    ROUND(AVG(default_flag), 2) AS actual_default_rate_pct,
    ROUND(AVG(consolidated_debt_to_income), 2) AS avg_dti,
    ROUND(AVG(interest_rate), 2) AS avg_rate,
    portfolio_health_status
FROM
(
    SELECT
        loan_amount,
        consolidated_debt_to_income,
        interest_rate,
		CASE
            WHEN loan_status = 'Charged Off' THEN 100
            ELSE 0
        END AS default_flag,

        CASE
            WHEN loan_status = 'Current' THEN 'Current'
            WHEN loan_status = 'Fully Paid' THEN 'Closed'
            WHEN loan_status = 'In Grace Period' THEN 'Early Delinquent'
            WHEN loan_status IN ('Late (16-30 days)', 'Late (31-120 days)') THEN 'Delinquent'
            WHEN loan_status = 'Charged Off' THEN 'Defaulted'
        END AS DelinquencyCategory,

        CASE
            WHEN loan_status = 'Current' THEN 'Healthy'
            WHEN loan_status = 'Fully Paid' THEN 'Completed'
            WHEN loan_status = 'In Grace Period' THEN 'Monitor'
            WHEN loan_status IN ('Late (16-30 days)', 'Late (31-120 days)') THEN 'Action Required'
            WHEN loan_status = 'Charged Off' THEN 'Loss Recorded'
        END AS portfolio_health_status
FROM clean_loanset
) AS d
GROUP BY
    DelinquencyCategory,
    portfolio_health_status
ORDER BY
FIELD(
    DelinquencyCategory,
    'Current',
    'Closed',
    'Early Delinquent',
    'Delinquent',
    'Defaulted'
);


-- DELIQUENCY HISTORY BY LOAN STATUS --
SELECT
    loan_status,
    COUNT(*) AS Total_Loans,
    ROUND(COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM clean_loanset), 2) AS Portfolio_Percentage
FROM clean_loanset
GROUP BY loan_status
ORDER BY Total_Loans DESC;


-- AVERAGE HISTORICAL DELINQUENCY --
SELECT
    loan_status,
    COUNT(*) AS Total_Loans,
    ROUND(AVG(delinq_2y),2) AS Avg_Delinquencies_Last_2Yrs
FROM clean_loanset
GROUP BY loan_status;


-- MONTHS SINCE LAST DELINQUENCY --
SELECT
    loan_status,
    ROUND(
        AVG(
            CASE
                WHEN months_since_last_delinq <> 999
                THEN months_since_last_delinq
            END
        ),2
    ) AS Avg_Months_Since_Last_Delinquency
FROM clean_loanset
GROUP BY loan_status;


-- HISTORICAL FAILED PAYMENTS --
SELECT
    loan_status,
    ROUND(AVG(num_historical_failed_to_pay),2) AS Avg_Failed_Payments
FROM clean_loanset
GROUP BY loan_status;


-- CURRENT DELINQUENT ACCOUNTS --
SELECT
    loan_status,
    SUM(current_accounts_delinq) AS Total_Current_Delinquent_Accounts,
    ROUND(AVG(current_accounts_delinq),2) AS Avg_Current_Delinquent_Accounts
FROM clean_loanset
GROUP BY loan_status;


-- DELINQUENCY BY INCOME GROUP --
SELECT
    CASE
        WHEN consolidated_annual_income < 50000 THEN 'Low Income'
        WHEN consolidated_annual_income BETWEEN 50000 AND 99999 THEN 'Lower Middle'
        WHEN consolidated_annual_income BETWEEN 100000 AND 199999 THEN 'Upper Middle'
        ELSE 'High Income'
    END AS Income_Group,
    ROUND(AVG(delinq_2y),2) AS Avg_Delinquency,
    COUNT(*) AS Borrowers
FROM clean_loanset
GROUP BY Income_Group;


-- DELINQIENCY BY INTEREST RATE --
SELECT
    CASE
        WHEN interest_rate < 10 THEN 'Low Rate'
        WHEN interest_rate BETWEEN 10 AND 15 THEN 'Medium Rate'
        ELSE 'High Rate'
    END AS Interest_Group,
ROUND(AVG(delinq_2y),2) AS Avg_Delinquency,
COUNT(*) AS Borrowers
FROM clean_loanset
GROUP BY Interest_Group;


-- CHARGED OFF LOAN INVESTIGATION --
SELECT
    id,
    loan_amount,
    interest_rate,
    consolidated_annual_income,
    delinq_2y,
    months_since_last_delinq,
    num_historical_failed_to_pay,
    current_accounts_delinq,
    tax_liens,
    public_record_bankrupt
FROM clean_loanset
WHERE loan_status = 'Charged Off';


-- DELINQUENCY BY HOME OWNERSHIP --
SELECT
homeownership,
ROUND(AVG(delinq_2y),2) AS Avg_Delinquency,
COUNT(*) AS Borrowers
FROM clean_loanset
GROUP BY homeownership
ORDER BY Avg_Delinquency DESC;


-- AVERAGE DEBT TO INCOME BY LOAN STATUS --
SELECT
    loan_status,
    COUNT(*) AS Total_Loans,
    ROUND(AVG(consolidated_debt_to_income),2) AS Avg_Debt_To_Income_Ratio
FROM clean_loanset
GROUP BY loan_status
ORDER BY Avg_Debt_To_Income_Ratio DESC;


-- PREVIOUS DELINQUENCY ANALYSIS --
SELECT
    loan_status,
    COUNT(*) AS Total_Loans,
    ROUND(AVG(delinq_2y),2) AS Avg_Previous_Delinquencies,
    MAX(delinq_2y) AS Highest_Previous_Delinquency,
    SUM(CASE
            WHEN delinq_2y > 0 THEN 1
            ELSE 0
        END) AS Borrowers_With_Previous_Delinquency,
    ROUND(
        100 * SUM(CASE
                      WHEN delinq_2y > 0 THEN 1
                      ELSE 0
                  END) / COUNT(*),
        2
    ) AS Percent_With_Previous_Delinquency
FROM clean_loanset
GROUP BY loan_status
ORDER BY Avg_Previous_Delinquencies DESC;


-- PORTFOLIO HEALTH ANALYSIS --
SELECT
    CASE
        WHEN loan_status = 'Current'
            THEN 'Current'
        WHEN loan_status = 'Fully Paid'
            THEN 'Closed'
        WHEN loan_status = 'In Grace Period'
            THEN 'Early Delinquent'
        WHEN loan_status IN ('Late (16-30 days)',
                             'Late (31-120 days)')
            THEN 'Delinquent'
        WHEN loan_status = 'Charged Off'
            THEN 'Defaulted'
    END AS Portfolio_Health,
    COUNT(*) AS Loan_Count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM clean_loanset),
        2
    ) AS Portfolio_Percentage,
    SUM(loan_amount) AS Total_Exposure,
    ROUND(AVG(interest_rate),2) AS Avg_Interest_Rate,
    ROUND(AVG(consolidated_debt_to_income),2) AS Avg_DTI
FROM clean_loanset
GROUP BY Portfolio_Health
ORDER BY
FIELD(
    Portfolio_Health,
    'Current',
    'Closed',
    'Early Delinquent',
    'Delinquent',
    'Defaulted'
);