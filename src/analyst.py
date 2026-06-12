import os
import pandas as pd
import pyodbc
import matplotlib.pyplot as plt
import seaborn as sns
from db_connection import conn, cursor



df = pd.read_sql("SELECT * FROM ", conn)
conn.close()

output_folder = "charts"
os.makedirs(output_folder, exist_ok=True)

numeric_cols = [
    "Rainfall",
    "Temperature",
    "Humidity",
    "Pressure",
    "WindSpeed",
    "RiverLevel"
]

df[numeric_cols] = df[numeric_cols].apply(pd.to_numeric, errors="coerce")

# 1. Histogram
plt.figure(figsize=(8, 5))
plt.hist(df["Rainfall"].dropna(), bins=10)
plt.title("Histogram of Rainfall")
plt.xlabel("Rainfall")
plt.ylabel("Frequency")
plt.savefig(f"{output_folder}/histogram_rainfall.png")
plt.close()

# 2. Boxplot chuẩn hóa để dễ so sánh
df_scaled = df[numeric_cols].copy()

for col in numeric_cols:
    df_scaled[col] = (df_scaled[col] - df_scaled[col].mean()) / df_scaled[col].std()

plt.figure(figsize=(10, 6))
df_scaled.boxplot()
plt.title("Standardized Boxplot of Weather Variables")
plt.ylabel("Standardized value")
plt.xticks(rotation=30)
plt.tight_layout()
plt.savefig(f"{output_folder}/boxplot_weather_standardized.png")
plt.close()

# 3. Heatmap
corr = df[numeric_cols].corr()

plt.figure(figsize=(9, 6))
sns.heatmap(corr, annot=True, cmap="coolwarm")
plt.title("Correlation Heatmap")
plt.savefig(f"{output_folder}/heatmap_correlation.png")
plt.close()

# 4. Correlation Analysis với Rainfall
rainfall_corr = corr["Rainfall"].drop("Rainfall")

plt.figure(figsize=(8, 5))
rainfall_corr.plot(kind="bar")
plt.title("Correlation with Rainfall")
plt.xlabel("Variable")
plt.ylabel("Correlation")
plt.xticks(rotation=30)
plt.savefig(f"{output_folder}/correlation_with_rainfall.png")
plt.close()

print("Đã xuất 4 biểu đồ vào thư mục charts")
print(corr)
