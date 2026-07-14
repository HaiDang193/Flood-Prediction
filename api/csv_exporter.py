import os

def export_to_csv(df, city):
    safe_city = city.replace(" ", "_").replace(",", "")
    filename = f"{safe_city}_weather.csv"
    
    # Lấy đường dẫn thư mục của file này
    current_dir = os.path.dirname(os.path.abspath(__file__))

    
    # Đi lên 1 cấp, rồi vào data/raw
    save_dir = os.path.join(current_dir, "..", "data", "data_raw")
    save_dir = os.path.abspath(save_dir)
    
    # Tạo thư mục nếu chưa tồn tại
    os.makedirs(save_dir, exist_ok=True)
    
    filepath = os.path.join(save_dir, filename)
    
    #đè vào file nếu đã tồn tại hoặc không tồn tại
    df.to_csv(filepath, index=False, encoding="utf-8-sig")

    return os.path.abspath(filepath)