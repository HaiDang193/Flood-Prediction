import pyodbc

conn = pyodbc.connect(
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=MSI\\SQLEXPRESS;"
    "DATABASE=flood;"
    "Trusted_Connection=yes;"
)

cursor = conn.cursor()

print("Database connected successfully")