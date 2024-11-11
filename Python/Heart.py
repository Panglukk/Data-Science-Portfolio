# 1. Data Import
import pandas as pd
import numpy as py
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import classification_report, confusion_matrix, accuracy_score

from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, confusion_matrix
from sklearn.preprocessing import OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
data = pd.read_csv('heart.csv')

# 2. Exploratory Data Analysis; EDA & Data Cleaning 
data.isna().sum()
data.head()
data.dtypes
data.describe()

# 3. Data Analysis
# 3.1 เลือก Features และ Target
X = data.drop('HeartDisease', axis=1)  # Feature variables
y = data['HeartDisease']  # Target variable

# 3.2 ขั้นตอนการเตรียมข้อมูลสำหรับ Features ที่เป็น Categorical
categorical_features = ['Sex', 'ChestPainType', 'RestingECG', 'ExerciseAngina', 'ST_Slope']
numeric_features = ['Age', 'RestingBP', 'Cholesterol', 'FastingBS', 'MaxHR', 'Oldpeak']

# 3.3 การแปลง Categorical Data ให้เป็น One-Hot Encoding
preprocessor = ColumnTransformer(
    transformers=[
        ('num', 'passthrough', numeric_features),  # ไม่ทำการแปลง numeric data
        ('cat', OneHotEncoder(), categorical_features)  # OneHot Encoding สำหรับ categorical data
    ])

# 3.4 สร้างโมเดล Logistic Regression
model = Pipeline(steps=[
    ('preprocessor', preprocessor),
    ('classifier', LogisticRegression())
])

# 3.5 แบ่งข้อมูลเป็น Train และ Test (80% Train, 20% Test)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 3.6 ฝึกโมเดล
model.fit(X_train, y_train)

# 3.7 ทำนายผล
y_pred = model.predict(X_test)

# 3.8 ประเมินผล
accuracy = accuracy_score(y_test, y_pred)
conf_matrix = confusion_matrix(y_test, y_pred)

# 3.9 แสดงผลลัพธ์
print(f'Accuracy: {accuracy:.4f}')
print(f'Confusion Matrix:\n{conf_matrix}')

# 4. Data Visualization
# 4.1 Histogram: ช่วงอายุที่พบโรคหัวใจบ่อย ๆ
plt.figure(figsize=(10, 6))
sns.histplot(data['Age'], bins=10, kde=True)
plt.title('Age Distribution')
plt.xlabel('Age')
plt.ylabel('Frequency')
plt.show()

# 4.2 Box Plot: ค่า Outlier และช่วงข้อมูลที่เกี่ยวข้องกับโรคหัวใจ
plt.figure(figsize=(10, 6))
sns.boxplot(x='HeartDisease', y='Age', data=data)
plt.title('Age Distribution by Heart Disease')
plt.xlabel('Heart Disease')
plt.ylabel('Age')
plt.show()

# 4.3 Count Plot: ใช้ดูความถี่ของข้อมูลที่เป็นหมวดหมู่ แสดงคนที่เป็นโรคหัวใจกับคนที่ไม่เป็นโรค
plt.figure(figsize=(8, 6))
sns.countplot(x='HeartDisease', data=data)
plt.title('Heart Disease Count')
plt.xlabel('Heart Disease')
plt.ylabel('Count')
plt.show()

# 4.4 Scatter Plot: ตรวจสอบความสัมพันธ์ คนอายุมากอาจมีคอเลสเตอรอลสูงขึ้นหรือไม่?
plt.figure(figsize=(10, 6))
sns.scatterplot(x='Age', y='Cholesterol', hue='HeartDisease', data=data)
plt.title('Age vs Cholesterol by Heart Disease')
plt.xlabel('Age')
plt.ylabel('Cholesterol')
plt.show()

# 4.5 Bar Plot ตัวแปรที่มีส่งผลต่อการเกิดโรคหัวใจมากที่สุด ตามลำดับ
# แปลงข้อมูล Categorical เป็น One-Hot Encoding
data = pd.get_dummies(data, drop_first=True)  # drop_first=True ช่วยลดการเกิด multicollinearity

# แยกตัวแปรต้นและตัวแปรตาม
X = data.drop('HeartDisease', axis=1)
y = data['HeartDisease']

# สร้างโมเดล Random Forest
model = RandomForestClassifier(random_state=0)
model.fit(X, y)

# ดึงค่าความสำคัญของแต่ละตัวแปร
feature_importance = model.feature_importances_

# สร้าง DataFrame สำหรับจัดเรียงค่าความสำคัญ
importance_df = pd.DataFrame({
    'Feature': X.columns,
    'Importance': feature_importance
}).sort_values(by='Importance', ascending=False)

# Visualization
plt.figure(figsize=(10, 8))
sns.barplot(x='Importance', y='Feature', data=importance_df, palette='viridis')
plt.title('Feature Importance for Heart Disease Prediction')
plt.xlabel('Importance')
plt.ylabel('Feature')
plt.show()
