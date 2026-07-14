import pandas as pd
from db_connection import conn, cursor
import os

#lấy đường dẫn của file hiện tại
cur_dir = os.path.dirname(os.path.abspath(__file__))

#tạo đường dẫn đến file csv
csv_path = os.path.join(cur_dir, "..", "data", "cleaned", "label_cleaned.csv")

# chuyển đường dẫn thành đường dẫn tuyệt đối
csv_path = os.path.abspath(csv_path)

df = pd.read_csv(csv_path)

insert_label_data = """
    INSERT INTO label_data(
        location_id,
        date,
        flood
    )
    VALUES
    (
        ?, ?, ?
    )
    """

# Xóa sạch dữ liệu cũ
cursor.execute("DELETE FROM label_data")

for _, row in df.iterrows():
    cursor.execute(insert_label_data,
                    int(row["location_id"]),
                    row["date"],
                    int(row["flood"]))

conn.commit()

print("Label_data inserted")