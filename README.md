# Loan Performance & Credit Risk Analysis

## Project Overview

This project presents an end-to-end analysis of loan performance and credit risk using Microsoft Excel, MySQL, Python, Power BI, and Machine Learning. The objective was to analyze borrower characteristics, evaluate portfolio performance, identify key risk factors associated with loan default, and develop predictive models capable of classifying performing and non-performing loans.

The project combines data cleaning, exploratory data analysis, business intelligence reporting, and machine learning to transform raw lending data into actionable business insights. An interactive Power BI dashboard was developed to support data-driven decision-making by providing a comprehensive view of portfolio performance, borrower profiles, delinquency trends, and portfolio risk.

To address the highly imbalanced nature of the dataset, both standard and balanced classification models were evaluated. After comparing model performance, the Balanced Logistic Regression model was selected as the preferred predictive model because it provided the best balance between identifying non-performing loans and maintaining overall predictive performance.

---

# Business Problem

Financial institutions face the ongoing challenge of balancing loan growth with effective credit risk management. While extending more loans can increase revenue, it also exposes lenders to the risk of borrower default, which can result in significant financial losses.

Traditional methods of assessing loan applications often rely on historical credit information and manual underwriting processes. However, with increasing loan volumes and the availability of large datasets, there is a growing need for data-driven approaches that can improve lending decisions, identify high-risk borrowers early, and enhance portfolio monitoring.

This project addresses these challenges by analyzing historical loan data to:

* Identify characteristics of performing and non-performing loans.
* Determine the borrower attributes most associated with default.
* Assess overall portfolio health.
* Identify high-risk borrower segments.
* Build predictive models capable of classifying loan performance.

---

# Project Objectives

* Clean and preprocess the raw loan dataset.
* Perform exploratory data analysis (EDA).
* Analyze borrower income, debt-to-income ratio, loan purposes, and credit history.
* Evaluate portfolio health using delinquency and default indicators.
* Build an interactive Power BI dashboard.
* Develop multiple machine learning models.
* Compare standard and balanced classification models.
* Identify the most influential variables affecting loan performance.
* Provide actionable business recommendations.

---

# Dataset Overview

The project uses a historical loan dataset containing borrower, loan, and credit information.

### Dataset Categories

* Borrower Information
* Loan Information
* Credit Profile
* Loan Performance

### Data Preparation

The dataset was prepared by:

* Removing duplicate records
* Handling missing values
* Consolidating borrower information
* Standardizing formats
* Creating derived variables
* Encoding categorical variables
* Addressing class imbalance for machine learning

The cleaned dataset served as the foundation for Excel, SQL, Python, Power BI, and Machine Learning analyses.

---

# Tools & Technologies

| Tool            | Purpose                                   |
| --------------- | ----------------------------------------- |
| Microsoft Excel | Data cleaning and preprocessing           |
| MySQL           | Exploratory data analysis                 |
| Python          | EDA, visualization, machine learning      |
| Pandas          | Data manipulation                         |
| NumPy           | Numerical computing                       |
| Matplotlib      | Data visualization                        |
| Scikit-learn    | Machine learning                          |
| Power BI        | Interactive dashboards                    |
| Git & GitHub    | Version control and project documentation |

### Machine Learning Models

* Linear Regression
* Standard Logistic Regression
* Balanced Logistic Regression
* Standard Random Forest
* Balanced Random Forest

Balanced Logistic Regression was selected as the final predictive model, while Balanced Random Forest was used to determine feature importance.

---

# Project Workflow

```
Raw Dataset
      ↓
Excel Data Cleaning
      ↓
SQL Exploratory Analysis
      ↓
Python EDA & Visualization
      ↓
Machine Learning
      ↓
Power BI Dashboard
      ↓
Business Recommendations
```

---

# Dashboard Overview

The Power BI dashboard consists of six interactive pages.

## Page 1 — Executive Summary

Provides an overview of:

* Total Loans
* Total Loan Amount
* Average Interest Rate
* Average Debt-to-Income Ratio
* Portfolio Health
* Default Rate

**Dashboard Screenshot**

![Executive Summary](images/executive_summary.png)

---

## Page 2 — Loan Portfolio Overview

Analyzes:

* Loan Amounts
* Loan Grades
* Loan Purposes
* Interest Rates
* Repayment Terms

**Dashboard Screenshot**

![Loan Portfolio Overview](images/loan_portfolio_overview.png)

---

## Page 3 — Borrower & Income Analysis

Analyzes:

* Income Groups
* Homeownership
* Employment Length
* Annual Income
* Debt-to-Income Ratio
* Credit Utilization

**Dashboard Screenshot**

![Borrower Analysis](images/borrower_income_analysis.png)

---

## Page 4 — Delinquency & Credit Risk

Examines:

* Previous Delinquencies
* Credit Inquiries
* Public Records
* Credit Risk Indicators

**Dashboard Screenshot**

![Delinquency Analysis](images/delinquency_credit_risk_analysis.png)

---

## Page 5 — Portfolio Risk Analysis

Analyzes:

* Portfolio Exposure
* Default Rates
* Portfolio Health
* Risk Concentration

**Dashboard Screenshot**

![Portfolio Risk](images/portfolio_risk_analysis.png)

---

## Page 6 — Machine Learning Insights

Summarizes:

* Model Comparison
* Balanced Logistic Regression Results
* Confusion Matrix
* Feature Importance

**Dashboard Screenshot**

![Machine Learning](images/machine_learning_insights.png)

---

# Machine Learning Models

The following models were developed:

| Model                        | Purpose                |
| ---------------------------- | ---------------------- |
| Linear Regression            | Baseline regression    |
| Standard Logistic Regression | Initial classifier     |
| Balanced Logistic Regression | Final predictive model |
| Standard Random Forest       | Comparison model       |
| Balanced Random Forest       | Feature importance     |

### Evaluation Metrics

* Accuracy
* Precision
* Recall
* F1 Score
* ROC AUC
* Confusion Matrix

Balanced Logistic Regression was selected because it handled the imbalanced dataset more effectively by identifying substantially more non-performing loans than the standard models.

Balanced Random Forest was used to determine feature importance and identify the variables with the greatest influence on loan performance.

---

# Key Findings

* Approximately **98%** of loans were performing, resulting in a highly imbalanced dataset.
* Borrower income alone was not sufficient to explain loan performance.
* Debt-to-income ratio, interest rate, loan amount, credit utilization, and previous delinquencies were among the strongest predictors of loan performance.
* Standard classification models achieved high accuracy but failed to detect non-performing loans effectively.
* Balanced Logistic Regression provided the best balance between overall performance and minority-class detection.
* Random Forest feature importance highlighted the variables with the greatest impact on predictions.
* The Power BI dashboard provides an interactive view of portfolio performance and credit risk.

---

# Business Recommendations

* Adopt risk-based lending practices.
* Incorporate predictive analytics into credit assessment.
* Strengthen monitoring of high-risk borrowers.
* Focus on key risk indicators identified by the feature importance analysis.
* Continue using interactive Power BI dashboards for portfolio monitoring.
* Improve future predictive models using additional borrower and economic data.

---

# Project Structure

```text
loan-performance-risk-analysis/
│
├── data/
├── excel/
├── sql/
├── python/
├── powerbi/
├── presentation/
├── images/
├── README.md
└── requirements.txt
```

---

# How to Run the Project

1. Clone the repository.

```bash
git clone https://github.com/Taurusking1/loan-performance-risk-analysis.git
```

2. Install the required Python libraries.

```bash
pip install pandas numpy matplotlib scikit-learn openpyxl jupyter
```

3. Open the notebooks in the `python/` folder.

4. Execute the SQL scripts in the `sql/` folder.

5. Open the Power BI dashboard:

```
powerbi/Loan_Performance_Dashboard.pbix
```

6. Review the documentation in the `excel/` and `presentation/` folders.

---

# Future Improvements

Future enhancements may include:

* Expanding the dataset.
* Incorporating behavioural and macroeconomic variables.
* Evaluating advanced machine learning models such as XGBoost, LightGBM, and CatBoost.
* Applying SHAP or LIME for improved model explainability.
* Deploying the predictive model as a web application or API.
* Automating dashboard refresh using a live database connection.
* Implementing automated risk alerts.
* Adding forecasting and scenario analysis to the dashboard.

---

# Author

## Ekene Martin Atuegbu

**Data Analyst | Business Intelligence Analyst | Machine Learning Enthusiast**

This project demonstrates practical skills in data cleaning, SQL, Python, Power BI, business intelligence, and machine learning through an end-to-end credit risk analysis workflow.

## Technical Skills

* Microsoft Excel
* MySQL
* Python
* Pandas
* NumPy
* Matplotlib
* Scikit-learn
* Power BI
* Git & GitHub

## Contact

* **GitHub:** https://github.com/Taurusking1
* **LinkedIn:** https://www.linkedin.com/in/ekene-atuegbu-a9478b3bb/
* **Email:** [kenair1@hotmail.com](mailto:kenair1@hotmail.com)
