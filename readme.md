# AI-Driven Flood Prediction System

An AI-based flood forecasting system designed to predict flood risk for **Hue** and **Quang Nam, Vietnam** over the next **3 days (D+1, D+2, D+3)**.

The system combines meteorological and hydrological data, performs feature engineering, trains machine learning models, and generates short-term flood risk forecasts.

## Project Workflow

```text
Data Collection
      ↓
Data Cleaning
      ↓
Exploratory Data Analysis (EDA)
      ↓
Feature Engineering
      ↓
Model Training & Evaluation
      ↓
Best Model Selection
      ↓
D+1 / D+2 / D+3 Prediction
      ↓
Flood Risk & Warning Output
```

## Data Sources

* Open-Meteo Weather API
* Open-Meteo Flood API
* EM-DAT Flood Event Data
* SQL Server database

The dataset covers **Hue and Quang Nam** and contains weather, rainfall, and river discharge information.

## Key Features

The final models use 11 input features:

* `location_id`
* `rainfall`
* `temperature`
* `humidity`
* `pressure`
* `wind_speed`
* `river_discharge`
* `month`
* `rainfall_3d`
* `rainfall_7d`
* `discharge_change_1d`

## Models

Two machine learning algorithms were evaluated:

* Random Forest
* XGBoost

Model selection prioritizes:

```text
Recall → Precision → F1-score → PR-AUC
```

Recall is prioritized to reduce **False Negatives**, because missing an actual flood event is particularly important in an early-warning system.

The final selected models are:

| Forecast | Selected Model | Recall | PR-AUC |
| -------- | -------------- | -----: | -----: |
| D+1      | XGBoost        | 0.8796 | 0.8730 |
| D+2      | XGBoost        | 0.8231 | 0.7556 |
| D+3      | XGBoost        | 0.7506 | 0.5699 |

## Prediction Output

The system generates forecasts for both **Hue** and **Quang Nam** for:

* D+1
* D+2
* D+3

Each forecast includes:

* Flood Probability
* Flood Risk Score
* Confidence Score
* Alert Level
* River Trend
* Main Risk Factors
* Safety Recommendation

## Saved Models

```text
models/
├── flood_model_d1.pkl
├── flood_model_d2.pkl
├── flood_model_d3.pkl
└── model_features.pkl
```

## Technologies

* Python
* Pandas / NumPy
* Scikit-learn
* XGBoost
* Matplotlib / Seaborn
* Jupyter Notebook
* SQL Server
* Open-Meteo API

## How to Run

Install the required dependencies:

```bash
pip install pandas numpy scikit-learn xgboost matplotlib seaborn requests joblib
```

Run the notebooks in the project workflow order:

```text
Data Cleaning
    ↓
EDA
    ↓
Model Training
    ↓
Prediction
```

The prediction notebook loads the trained D+1, D+2, and D+3 models and generates **6 forecasts: 2 locations × 3 forecast horizons**.

## Project Goal

The goal of this project is to build a practical AI-assisted flood early-warning workflow that transforms weather and river data into short-term, interpretable flood-risk information for decision support.
