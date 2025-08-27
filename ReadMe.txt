# Predictive Healthcare Insights: Patient Readmission Analysis

## 🚀 Project Overview
This project predicts patient readmissions and provides actionable insights for hospital management. It includes an **end-to-end workflow**:
Python → Azure Blob Storage → MySQL → Power BI Dashboard.

---

## 🎯 Objectives
- Predict patients likely to be readmitted
- Analyze trends in hospital stay, costs, and demographics
- Create interactive dashboards for data-driven decision making
- Store and retrieve data efficiently using cloud and database solutions

---

## 🗂️ Data Sources
- **Hospital Admissions CSV**: Synthetic dataset generated in Python
- **MySQL Database**: Centralized storage for analysis
- **Azure Blob Storage**: Cloud storage for secure dataset
- **Power BI Dashboard**: Interactive visualizations

---

## 🐍 Python Workflow
1. Data generation & cleaning
2. Feature selection: `age`, `length_of_stay`, `num_lab_tests`, `total_cost`, `prev_admissions`
3. Train-test split (`test_size=0.2`, `random_state=42`, `stratify=y`)
4. ML Pipeline:
   - Imputer (`SimpleImputer`)
   - Scaling (`StandardScaler`)
   - RandomForestClassifier
5. Predictions & feature importance analysis
6. Save predictions CSV for Power BI dashboard

---

## 📊 Machine Learning Evaluation
- **ROC-AUC Score**: Measures model’s ability to distinguish readmission
- **Confusion Matrix**: True/False positives and negatives
- **Classification Report**: Precision, Recall, F1-score

---

## 💻 SQL Analysis
- Average Length of Stay per Patient
- Readmission Rate
- Cost Analysis
- Gender-wise Readmission Rate
- Monthly Admissions Trend

---

## ☁️ Azure Blob Storage
- Upload CSV datasets for cloud access
- Enables integration with Power BI for live dashboards

---

## 📈 Power BI Dashboard
Visualizations include:
- KPI Cards: Total Patients, Readmissions, Avg Stay, Readmission Rate
- Pie/Donut Charts: Readmission vs No Readmission, Gender Distribution
- Bar Chart: Readmission by Gender, Top 5 Costly Diagnoses
- Line Chart: Monthly Admission Trends
- Table: Patient-level Predictions (Actual vs Predicted)

---

## 🔧 Tools & Technologies
- **Python**: Pandas, NumPy, Scikit-learn, Matplotlib
- **SQL**: MySQL Workbench
- **Cloud**: Azure Blob Storage
- **BI**: Power BI

---

## 📂 Repository Structure


Thank You/Let’s Connect:
LinkedIn: http://www.linkedin.com/in/
Git hub: https://github.com/Tanu272004
Website: https://tanmayportfolio52.wordpress.com/
Blob : https://predictive-healthcare-insights.hashnode.dev/predictive-healthcare-insights

