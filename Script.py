import pandas as pd
import numpy as np

# generate dummy healthcare admissions data
np.random.seed(42)
n = 1000

df = pd.DataFrame({
    "patient_id": np.arange(1, n+1),
    "age": np.random.randint(20, 90, size=n),
    "length_of_stay": np.random.randint(1, 15, size=n),
    "num_lab_tests": np.random.randint(5, 50, size=n),
    "total_cost": np.random.randint(2000, 50000, size=n),
    "prev_admissions": np.random.randint(0, 5, size=n),
    "target": np.random.choice([0,1], size=n, p=[0.7,0.3])  # 30% readmissions
})

df.to_csv("hospital_admissions.csv", index=False)
print("Dummy dataset saved as hospital_admissions.csv")
print(df.head())
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.impute import SimpleImputer
from sklearn.pipeline import Pipeline
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import roc_auc_score, confusion_matrix, classification_report

# Load dataset
df = pd.read_csv("hospital_admissions.csv")

# Features & target
X = df[['age', 'length_of_stay', 'num_lab_tests', 'total_cost', 'prev_admissions']]
y = df['target']

# Train-test split
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42, stratify=y
)

# Pipeline (impute + scale + model)
pipeline = Pipeline([
    ('imputer', SimpleImputer(strategy='median')),
    ('scaler', StandardScaler()),
    ('model', RandomForestClassifier(n_estimators=200, random_state=42, class_weight="balanced"))
])

pipeline.fit(X_train, y_train)

# Predictions
y_pred = pipeline.predict(X_test)
y_proba = pipeline.predict_proba(X_test)[:,1]

# Evaluation
print("\n📊 Model Performance:")
print("ROC AUC:", roc_auc_score(y_test, y_proba))
print("Confusion Matrix:\n", confusion_matrix(y_test, y_pred))
print("Classification Report:\n", classification_report(y_test, y_pred))

import matplotlib.pyplot as plt

model = pipeline.named_steps['model']
importances = model.feature_importances_
features = X.columns

plt.figure(figsize=(7,5))
plt.barh(features, importances, color="skyblue")
plt.xlabel("Importance Score")
plt.title("Feature Importance for Readmission Prediction")
plt.show()


# ============================================
# Save predictions for Power BI dashboard
# ============================================

results = X_test.copy()
results['Actual'] = y_test.values
results['Predicted'] = y_pred
results['Readmission_Probability'] = y_proba

results.to_csv("readmission_predictions.csv", index=False)
print("✅ Predictions saved to readmission_predictions.csv")
print(results.head())
