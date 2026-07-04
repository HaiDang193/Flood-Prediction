import requests
import pandas as pd


def _get_error_message(response, fallback):
    try:
        data = response.json()
    except ValueError:
        data = {}

    reason = data.get("reason")
    if reason:
        return f"{fallback}: {reason}"

    return f"{fallback} (HTTP {response.status_code})"


def get_weather_data(city, latitude, longitude, start_date, end_date, selected):
    weather_selected = []
    flood_selected = []

    for item in selected:
        if item == "river_discharge":
            flood_selected.append(item)
        else:
            weather_selected.append(item)

    final_df = None

    if len(weather_selected) > 0:
        url = "https://archive-api.open-meteo.com/v1/archive"

        params = {
            "latitude": latitude,
            "longitude": longitude,
            "start_date": start_date,
            "end_date": end_date,
            "daily": ",".join(weather_selected),
            "timezone": "Asia/Bangkok"
        }

        response = requests.get(url, params=params, timeout=30)

        if response.status_code != 200:
            raise Exception(_get_error_message(response, "Không lấy được dữ liệu thời tiết"))

        data = response.json()
        if "daily" not in data:
            raise Exception("Không có dữ liệu thời tiết trong khoảng ngày đã chọn")

        df_weather = pd.DataFrame(data["daily"])

        final_df = df_weather

    if len(flood_selected) > 0:
        url = "https://flood-api.open-meteo.com/v1/flood"

        params = {
            "latitude": latitude,
            "longitude": longitude,
            "start_date": start_date,
            "end_date": end_date,
            "daily": ",".join(flood_selected)
        }

        response = requests.get(url, params=params, timeout=30)

        if response.status_code != 200:
            raise Exception(_get_error_message(response, "Không lấy được dữ liệu river discharge"))

        data = response.json()
        if "daily" not in data:
            raise Exception("Không có dữ liệu river discharge trong khoảng ngày đã chọn")

        df_flood = pd.DataFrame(data["daily"])

        if final_df is None:
            final_df = df_flood
        else:
            final_df = pd.merge(final_df, df_flood, on="time", how="outer")

    final_df.insert(0, "Location", city)

    return final_df
