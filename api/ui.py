import tkinter as tk
from datetime import datetime
from tkinter import ttk, messagebox
from tkcalendar import DateEntry

from config import CITIES
from weather_api import get_weather_data
from csv_exporter import export_to_csv


class WeatherApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Thu thập dữ liệu thời tiết")
        self.root.geometry("420x430")

        self.city_var = tk.StringVar()

        self.create_main_ui()

    def create_main_ui(self):
        tk.Label(self.root, text="Chọn tỉnh/thành phố").pack(pady=5)

        self.city_combo = ttk.Combobox(
            self.root,
            textvariable=self.city_var,
            values=list(CITIES.keys()),
            state="readonly",
            width=30
        )
        self.city_combo.pack()

        self.city_combo.current(0)

        tk.Label(self.root, text="Ngày bắt đầu").pack(pady=5)

        self.start_calendar = DateEntry(
            self.root,
            width=20,
            date_pattern="yyyy-mm-dd"
        )
        self.start_calendar.pack()

        tk.Label(self.root, text="Ngày kết thúc").pack(pady=5)

        self.end_calendar = DateEntry(
            self.root,
            width=20,
            date_pattern="yyyy-mm-dd"
        )
        self.end_calendar.pack()

        tk.Button(
            self.root,
            text="Đồng ý",
            command=self.open_select_data,
            bg="green",
            fg="white",
            width=15
        ).pack(pady=20)

    def show_main_window(self):
        self.select_window.destroy()
        self.root.deiconify()

    def open_select_data(self):
        self.root.withdraw()

        self.select_window = tk.Toplevel(self.root)
        self.select_window.title("Chọn dữ liệu")
        self.select_window.geometry("340x360")

        self.select_window.protocol(
            "WM_DELETE_WINDOW",
            self.show_main_window
        )

        self.var_rain = tk.BooleanVar(value=True)
        self.var_temp = tk.BooleanVar(value=True)
        self.var_humidity = tk.BooleanVar(value=True)
        self.var_pressure = tk.BooleanVar(value=True)
        self.var_wind = tk.BooleanVar(value=True)
        self.var_river = tk.BooleanVar(value=True)

        tk.Label(
            self.select_window,
            text="Chọn dữ liệu cần xuất CSV",
            font=("Arial", 11, "bold")
        ).pack(pady=10)

        tk.Checkbutton(
            self.select_window,
            text="Rainfall (mm)",
            variable=self.var_rain
        ).pack(anchor="w", padx=40)

        tk.Checkbutton(
            self.select_window,
            text="Temperature (°C)",
            variable=self.var_temp
        ).pack(anchor="w", padx=40)

        tk.Checkbutton(
            self.select_window,
            text="Humidity (%)",
            variable=self.var_humidity
        ).pack(anchor="w", padx=40)

        tk.Checkbutton(
            self.select_window,
            text="Pressure (hPa)",
            variable=self.var_pressure
        ).pack(anchor="w", padx=40)

        tk.Checkbutton(
            self.select_window,
            text="Wind Speed (km/h)",
            variable=self.var_wind
        ).pack(anchor="w", padx=40)

        tk.Checkbutton(
            self.select_window,
            text="River Discharge (m³/s)",
            variable=self.var_river
        ).pack(anchor="w", padx=40)

        tk.Button(
            self.select_window,
            text="Lấy dữ liệu",
            command=self.load_weather_data,
            bg="blue",
            fg="white",
            width=15
        ).pack(pady=15)

    def load_weather_data(self):
        city = self.city_var.get()

        latitude, longitude = CITIES[city]

        location_name = city
        start_date = self.start_calendar.get()
        end_date = self.end_calendar.get()

        if datetime.strptime(start_date, "%Y-%m-%d") > datetime.strptime(end_date, "%Y-%m-%d"):
            messagebox.showerror("Lỗi", "Ngày bắt đầu không được lớn hơn ngày kết thúc")
            return

        selected = []

        if self.var_rain.get():
            selected.append("precipitation_sum")

        if self.var_temp.get():
            selected.append("temperature_2m_mean")

        if self.var_humidity.get():
            selected.append("relative_humidity_2m_mean")

        if self.var_pressure.get():
            selected.append("surface_pressure_mean")

        if self.var_wind.get():
            selected.append("wind_speed_10m_max")

        if self.var_river.get():
            selected.append("river_discharge")

        if len(selected) == 0:
            messagebox.showerror("Lỗi", "Phải chọn ít nhất 1 loại dữ liệu")
            return

        try:
            df = get_weather_data(
                city=location_name,
                latitude=latitude,
                longitude=longitude,
                start_date=start_date,
                end_date=end_date,
                selected=selected
            )

            self.select_window.destroy()
            self.show_table(df, location_name)

        except Exception as e:
            messagebox.showerror("Lỗi", str(e))

    def show_table(self, df, city):
        table_window = tk.Toplevel(self.root)
        table_window.title("Dữ liệu thời tiết")
        table_window.geometry("1200x600")

        table_window.protocol(
            "WM_DELETE_WINDOW",
            lambda: self.close_table_window(table_window)
        )

        frame = tk.Frame(table_window)
        frame.pack(fill="both", expand=True)

        tree = ttk.Treeview(frame)

        tree["columns"] = list(df.columns)
        tree["show"] = "headings"

        for col in df.columns:
            tree.heading(col, text=col)
            tree.column(col, width=150)

        for _, row in df.iterrows():
            tree.insert("", "end", values=list(row))

        scrollbar_y = ttk.Scrollbar(
            frame,
            orient="vertical",
            command=tree.yview
        )

        scrollbar_x = ttk.Scrollbar(
            table_window,
            orient="horizontal",
            command=tree.xview
        )

        tree.configure(
            yscrollcommand=scrollbar_y.set,
            xscrollcommand=scrollbar_x.set
        )

        tree.pack(side="left", fill="both", expand=True)
        scrollbar_y.pack(side="right", fill="y")
        scrollbar_x.pack(fill="x")

        tk.Button(
            table_window,
            text="Xuất CSV",
            command=lambda: self.save_csv(df, city, table_window),
            bg="green",
            fg="white",
            width=15
        ).pack(pady=10)

    def close_table_window(self, table_window):
        table_window.destroy()
        self.root.deiconify()

    def save_csv(self, df, city, table_window):
        filename = export_to_csv(df, city)
        messagebox.showinfo("Thành công", f"Đã xuất {filename}")
        
        table_window.destroy()
        self.root.deiconify()
