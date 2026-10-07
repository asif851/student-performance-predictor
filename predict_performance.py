import pandas as pd
from sqlalchemy import create_engine
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score

# 1. Connect to MySQL
engine = create_engine(
    "mysql+pymysql://root:1234@127.0.0.1:3306/student_performance"
)

# 2. Load data from MySQL
df = pd.read_sql("SELECT * FROM students", engine)
print(df.head())

# 3. Train the model
X = df[["hours_studied", "attendance"]]
y = df["passed"]
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.3, random_state=42, stratify=y
)
model = LogisticRegression().fit(X_train, y_train)
print("Accuracy:", accuracy_score(y_test, model.predict(X_test)))

# 4. Save predictions back to MySQL
df["predicted_pass"] = model.predict(X)
df[["id", "predicted_pass"]].to_sql(
    "student_predictions", engine, if_exists="replace", index=False
)
print("Predictions saved to MySQL")
