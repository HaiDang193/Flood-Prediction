[1mdiff --git a/AI-Driven Flood Monitoring and Prediction System.docx b/AI-Driven Flood Monitoring and Prediction System.docx[m
[1mnew file mode 100644[m
[1mindex 0000000..4538331[m
[1m--- /dev/null[m
[1m+++ b/AI-Driven Flood Monitoring and Prediction System.docx[m	
[36m@@ -0,0 +1,405 @@[m
[32m+[m[32mFlood Monitoring and Prediction System for Short-Term Flood Risk Forecasting[m
[32m+[m[32mNguyen Hai Dang, Nguyen Tan Dat, Dinh Thanh Tung[m
[32m+[m[32mFPT University, Hoa Lac High-Tech Park, Hanoi, Vietnam[m
[32m+[m
[32m+[m[32mAbstract[m
[32m+[m[32mFlooding is one of the most frequent and destructive natural hazards, causing severe damage to human life, transportation systems, infrastructure, agriculture, and local economic activities. Timely flood risk forecasting is therefore essential for disaster preparedness and early warning. This paper presents an AI-driven flood monitoring and prediction system for short-term flood risk forecasting. The proposed system integrates meteorological and hydrological data, including rainfall, temperature, humidity, pressure, wind speed, and river discharge, collected from public weather and flood data services. The data are cleaned, stored, transformed, and enriched using feature engineering methods such as cumulative rainfall over three and seven days, river discharge variation, monthly indicators, and seasonal information.[m
[32m+[m[32mThe system is designed as an end-to-end product-oriented prototype, including data collection, preprocessing, SQL-based storage, feature engineering, flood label construction, machine learning model training, and decision-support output generation. To support short-term forecasting, the proposed framework predicts flood risk for three forecast horizons: D+1, D+2, and D+3. Random Forest and XGBoost classifiers are trained and compared using evaluation metrics such as Accuracy, Precision, Recall, F1-score, ROC-AUC, and PR-AUC. The system outputs Flood Risk Score, Alert Level, River Trend, Confidence Score, main risk factors, and safety recommendations. Experimental results are currently reported using placeholders because final model evaluation must be recalculated after training separate models for D+1, D+2, and D+3 with a valid test set containing both flood and non-flood events. The proposed system demonstrates the feasibility of combining public data sources, machine learning, and decision-support rules to support practical flood early warning.[m
[32m+[m[32mKeywords --  Flood prediction, flood monitoring, machine learning, hydrological forecasting, early warning system, flood risk assessment, Random Forest, XGBoost, river discharge, rainfall.[m
[32m+[m
[32m+[m[32mI. Introduction[m
[32m+[m[32mFlooding is a serious natural hazard that frequently affects communities, infrastructure, transportation, and economic activities. Flood events can be triggered by heavy rainfall, rapid river discharge increase, poor drainage capacity, tropical storms, and other hydrometeorological factors. In flood-prone areas, early warning is important because it allows local residents, authorities, and emergency response teams to prepare before flood conditions become dangerous.[m
[32m+[m[32mTraditional flood warning systems often rely on hydrological models, physical simulations, river gauge thresholds, and expert-defined rules. Although these methods are important, they may require dense monitoring networks, detailed terrain information, and complex calibration. In many areas, especially regions with limited local sensors, it is difficult to build a fully physical flood forecasting system. At the same time, public meteorological and hydrological data services are becoming increasingly available. This creates an opportunity to build data-driven flood monitoring systems that combine public APIs, machine learning models, and decision-support outputs.[m
[32m+[m[32mMachine learning has been widely used in flood prediction because it can learn nonlinear relationships between environmental variables and flood occurrence. Rainfall, cumulative rainfall, river discharge, seasonal patterns, and river discharge variation can all contribute to flood risk. However, a practical flood warning product should not only output a binary result such as "flood" or "non-flood." It should also provide user-friendly information such as risk score, warning level, river trend, confidence, and safety recommendation.[m
[32m+[m[32mThis paper presents an AI-driven flood monitoring and prediction system for short-term flood risk forecasting. The system collects meteorological and hydrological data from public APIs, stores cleaned data in a structured database, performs feature engineering, constructs flood labels from disaster event records, trains machine learning models, and produces interpretable warning outputs. The system is designed to forecast flood risk for three future horizons: D+1, D+2, and D+3.[m
[32m+[m[32mThe main contributions of this work are as follows:[m
[32m+[m[32m An end-to-end flood monitoring pipeline is developed to collect, clean, store, and process meteorological and hydrological data.[m
[32m+[m[32m Rainfall accumulation, river discharge variation, seasonal indicators, and location-based information are engineered to support short-term flood risk prediction.[m
[32m+[m[32m A multi-horizon forecasting design is proposed for D+1, D+2, and D+3 flood risk estimation.[m
[32m+[m[32m Random Forest and XGBoost models are trained and compared for flood risk classification.[m
[32m+[m[32m Model outputs are converted into product-oriented decision-support information, including Flood Risk Score, Alert Level, River Trend, Confidence Score, main risk factors, and safety recommendations.[m
[32m+[m
[32m+[m[32mII. Related Work[m
[32m+[m[32mFlood prediction has been widely studied using hydrological models, statistical methods, machine learning, deep learning, and hybrid approaches. Mosavi et al. reviewed machine learning models for flood prediction and discussed how data-driven approaches can support both short-term and long-term flood forecasting. Their work is directly related to this project because it supports the use of machine learning methods such as ensemble learning for flood prediction tasks. The review also highlights the importance of model comparison, optimization, and hybridization in improving prediction performance.[m
[32m+[m[32mNevo et al. presented an operational flood forecasting system using machine learning models. Their system includes data validation, stage forecasting, inundation modeling, and alert distribution. This work is highly relevant to the proposed project because it shows that flood forecasting should be treated as a complete operational pipeline rather than only a standalone model. The proposed system in this paper follows a similar product-oriented direction by connecting data ingestion, model prediction, warning level generation, and user-facing recommendations.[m
[32m+[m[32mNearing et al. investigated global prediction of extreme floods in ungauged watersheds using artificial intelligence. Their study demonstrates that AI-based flood forecasting can improve access to flood warnings, especially in areas where dense river gauge networks are not available. This is related to the current project because the proposed system uses publicly available meteorological and hydrological data to build a scalable prototype for flood-prone regions.[m
[32m+[m[32mCostache proposed flood susceptibility assessment using bivariate statistics and machine learning models. This study is related to the Flood Risk Score component of the proposed system because it focuses on estimating flood-prone conditions using environmental and spatial indicators. Although the current project does not yet include terrain or land-use variables, the flood risk assessment perspective supports future expansion toward more spatially detailed flood risk mapping.[m
[32m+[m[32mYi et al. compared machine learning and deep learning approaches for reservoir-based flood forecasting and warning. Their study is relevant because it emphasizes the importance of river discharge forecasting and the comparison between traditional machine learning models and deep learning models. In the proposed system, river discharge is one of the most important hydrological input variables, and future versions may extend the model using recurrent neural networks or temporal deep learning methods.[m
[32m+[m[32mOmar et al. proposed a mobile-based decision support design for flood early warning systems. Their work is related to this project because it emphasizes that a flood prediction system should support decision making and warning communication. The proposed system also follows this idea by converting model probability into alert levels and safety recommendations.[m
[32m+[m[32mOverall, previous studies show that flood prediction requires both accurate modeling and effective warning communication. Compared with many studies that focus only on model performance, the proposed project focuses on building a practical end-to-end prototype that integrates public data sources, machine learning models, risk scoring, alert generation, and safety recommendation.[m
[32m+[m
[32m+[m[32mIII. Proposed System[m
[32m+[m[32mA. System Overview[m
[32m+[m[32mThe proposed system is designed as a product-oriented AI flood monitoring and prediction prototype. It includes four main stages: data acquisition, data processing, model training, and decision-support output generation.[m
[32m+[m[32m[Insert Fig. 1 here][m
[32m+[m[32mFig. 1. Overall architecture of the AI-driven flood monitoring and prediction system.[m
[32m+[m[32mThe system architecture can be described as follows:[m
[32m+[m[32m Data Collection Layer: collects weather and river discharge data from public APIs.[m
[32m+[m[32m Raw Data Storage Layer: stores downloaded data as CSV files for traceability.[m
[32m+[m[32m Database Layer: stores cleaned weather, river, and location data in SQL Server.[m
[32m+[m[32m Feature Engineering Layer: generates rainfall accumulation, river discharge change, seasonal, and temporal features.[m
[32m+[m[32m Label Construction Layer: generates flood labels from historical flood disaster records.[m
[32m+[m[32m Modeling Layer: trains Random Forest and XGBoost models for D+1, D+2, and D+3 forecasting.[m
[32m+[m[32m Decision-Support Layer: converts prediction probability into Flood Risk Score, Alert Level, River Trend, Confidence Score, main risk factors, and safety recommendations.[m
[32m+[m[32m User Interface Layer: presents warning information to users through a dashboard or application interface.[m
[32m+[m[32mB. Dataset Description[m
[32m+[m[32mThe dataset used in the current prototype contains daily meteorological and hydrological records for Hue and Quang Nam. The data cover the period from 2001-01-01 to 2026-06-29. Each record represents one location on one date.[m
[32m+[m[32mTable I[m
[32m+[m[32mDataset Description[m
[32m+[m[32mAttribute[m
[32m+[m[32mDescription[m
[32m+[m[32mStudy locations[m
[32m+[m[32mHue, Quang Nam[m
[32m+[m[32mTime range[m
[32m+[m[32m2001-01-01 to 2026-06-29[m
[32m+[m[32mNumber of records[m
[32m+[m[32m18,622[m
[32m+[m[32mWeather variables[m
[32m+[m[32mRainfall, temperature, humidity, pressure, wind speed[m
[32m+[m[32mHydrological variable[m
[32m+[m[32mRiver discharge[m
[32m+[m[32mLabel source[m
[32m+[m[32mHistorical flood disaster records[m
[32m+[m[32mTarget labels[m
[32m+[m[32mflood_d1, flood_d2, flood_d3[m
[32m+[m[32mForecast horizons[m
[32m+[m[32mD+1, D+2, D+3[m
[32m+[m[32mCurrent task type[m
[32m+[m[32mBinary classification for each forecast horizon[m
[32m+[m[32mC. Input Variables[m
[32m+[m[32mThe system uses both original variables and engineered variables. Original variables are collected directly from API data, while engineered variables are created during feature engineering.[m
[32m+[m[32mTable II[m
[32m+[m[32mInput Features Used for Flood Risk Prediction[m
[32m+[m[32mFeature[m
[32m+[m[32mType[m
[32m+[m[32mDescription[m
[32m+[m[32mrainfall[m
[32m+[m[32mMeteorological[m
[32m+[m[32mDaily precipitation[m
[32m+[m[32mtemperature[m
[32m+[m[32mMeteorological[m
[32m+[m[32mDaily air temperature[m
[32m+[m[32mhumidity[m
[32m+[m[32mMeteorological[m
[32m+[m[32mRelative humidity[m
[32m+[m[32mpressure[m
[32m+[m[32mMeteorological[m
[32m+[m[32mSurface pressure[m
[32m+[m[32mwind_speed[m
[32m+[m[32mMeteorological[m
[32m+[m[32mDaily wind speed[m
[32m+[m[32mriver_discharge[m
[32m+[m[32mHydrological[m
[32m+[m[32mRiver discharge value[m
[32m+[m[32mrainfall_3days[m
[32m+[m[32mEngineered[m
[32m+[m[32mThree-day cumulative rainfall[m
[32m+[m[32mrainfall_7days[m
[32m+[m[32mEngineered[m
[32m+[m[32mSeven-day cumulative rainfall[m
[32m+[m[32mriver_discharge_change[m
[32m+[m[32mEngineered[m
[32m+[m[32mDifference in river discharge compared with the previous day[m
[32m+[m[32mmonth[m
[32m+[m[32mTemporal[m
[32m+[m[32mMonth extracted from date[m
[32m+[m[32mseason[m
[32m+[m[32mTemporal[m
[32m+[m[32mRainy or dry season[m
[32m+[m[32mlocation[m
[32m+[m[32mSpatial categorical[m
[32m+[m[32mStudy location[m
[32m+[m[32mD. Decision-Support Outputs[m
[32m+[m[32mThe proposed product does not stop at binary prediction. Instead, the model output is converted into several warning and decision-support outputs.[m
[32m+[m[32mTable III[m
[32m+[m[32mDecision-Support Outputs of the System[m
[32m+[m[32mOutput[m
[32m+[m[32mDescription[m
[32m+[m[32mFlood Risk Score[m
[32m+[m[32mA probability-based score from 0 to 100[m
[32m+[m[32mAlert Level[m
[32m+[m[32mWarning level generated from the Flood Risk Score[m
[32m+[m[32mRiver Trend[m
[32m+[m[32mRising, falling, or stable river discharge trend[m
[32m+[m[32mConfidence Score[m
[32m+[m[32mClassification confidence based on predicted class probability[m
[32m+[m[32mMain Risk Factors[m
[32m+[m[32mMain conditions contributing to the warning, such as heavy rainfall or rising river discharge[m
[32m+[m[32mSafety Recommendation[m
[32m+[m[32mRule-based safety advice according to alert level[m
[32m+[m[32mD+1 Forecast[m
[32m+[m[32mFlood risk prediction for the next day[m
[32m+[m[32mD+2 Forecast[m
[32m+[m[32mFlood risk prediction for two days ahead[m
[32m+[m[32mD+3 Forecast[m
[32m+[m[32mFlood risk prediction for three days ahead[m
[32m+[m[32mThe current prototype does not estimate water depth or flood duration because these outputs require additional ground-truth inundation data. Therefore, water depth prediction and expected flood duration are considered future extensions.[m
[32m+[m
[32m+[m[32mIV. Methodology[m
[32m+[m[32mA. Data Collection[m
[32m+[m[32mThe system collects daily weather and river discharge data for selected locations. Each location is defined by its name, latitude, and longitude. Weather variables include rainfall, temperature, humidity, pressure, and wind speed. River discharge is used as the main hydrological indicator. The collected data are first exported as raw CSV files, then cleaned and inserted into SQL Server tables.[m
[32m+[m[32mThe database contains three main tables:[m
[32m+[m[32m locations: stores location ID, city, district, ward, latitude, and longitude.[m
[32m+[m[32m weather_data: stores daily meteorological variables.[m
[32m+[m[32m river_data: stores daily river discharge data.[m
[32m+[m[32mThis structure separates spatial information, weather observations, and hydrological data, making the system easier to manage and extend.[m
[32m+[m[32mB. Data Preprocessing[m
[32m+[m[32mRaw data are cleaned before being used for analysis and modeling. The preprocessing steps include:[m
[32m+[m[32m Merging raw CSV files from multiple locations.[m
[32m+[m[32m Standardizing column names.[m
[32m+[m[32m Converting the date column to datetime format.[m
[32m+[m[32m Checking missing values.[m
[32m+[m[32m Checking duplicate records.[m
[32m+[m[32m Converting numerical variables to proper numeric types.[m
[32m+[m[32m Saving the cleaned dataset as cleaned_weather.csv.[m
[32m+[m[32mAfter preprocessing, the dataset contains consistent daily records for each location. This cleaned dataset is then used for database insertion and feature engineering.[m
[32m+[m[32mC. Feature Engineering[m
[32m+[m[32mFeature engineering is performed to capture hydrological and meteorological conditions related to flood risk. The following features are generated:[m
[32m+[m[32m[ rainfall_3days_t = rainfall_t + rainfall_{t-1} + rainfall_{t-2} ][m
[32m+[m[32m[ rainfall_7days_t = {i=0}^{6} rainfall{t-i} ][m
[32m+[m[32m[ river_discharge_change_t = river_discharge_t - river_discharge_{t-1} ][m
[32m+[m[32mThe feature rainfall_3days represents short-term accumulated rainfall, while rainfall_7days represents antecedent rainfall conditions. The feature river_discharge_change indicates whether the river flow is increasing or decreasing. Month and season are also added because flood risk may vary across different periods of the year.[m
[32m+[m[32mD. Flood Label Construction[m
[32m+[m[32mFlood labels are constructed from historical disaster records. Only records with disaster type equal to Flood are used. For each flood disaster event, the start date and end date are converted into a daily date range. Each date within the event period is labeled as flood for the corresponding location. Dates not included in any flood event are labeled as non-flood.[m
[32m+[m[32mThe original label is defined as:[m
[32m+[m[32m[ flood_t =[m
[32m+[m[32m][m
[32m+[m[32mTo support short-term forecasting, three shifted labels are created:[m
[32m+[m[32m[ flood_d1_t = flood_{t+1} ][m
[32m+[m[32m[ flood_d2_t = flood_{t+2} ][m
[32m+[m[32m[ flood_d3_t = flood_{t+3} ][m
[32m+[m[32mThus, the model uses information available at date (t) to forecast flood risk at (t+1), (t+2), and (t+3).[m
[32m+[m[32mE. Multi-Horizon Forecasting Design[m
[32m+[m[32mThe system trains three separate binary classification models for each machine learning algorithm:[m
[32m+[m[32m D+1 model: predicts flood_d1[m
[32m+[m[32m D+2 model: predicts flood_d2[m
[32m+[m[32m D+3 model: predicts flood_d3[m
[32m+[m[32mFor each forecast horizon, the input feature set remains the same, but the target label changes. This design makes the forecasting task more consistent with real-world early warning because the system estimates future flood risk rather than same-day flood status.[m
[32m+[m[32mF. Machine Learning Models[m
[32m+[m[32mTwo machine learning models are implemented and compared:[m
[32m+[m[32m1) Random Forest[m
[32m+[m[32mRandom Forest is an ensemble learning method based on multiple decision trees. It is suitable for tabular data and can handle nonlinear relationships between rainfall, river discharge, and flood occurrence. It also provides feature importance, which helps explain which variables contribute most to prediction.[m
[32m+[m[32m2) XGBoost[m
[32m+[m[32mXGBoost is a gradient boosting algorithm that builds trees sequentially, where each new tree attempts to correct the errors of previous trees. It is often effective for structured tabular datasets and imbalanced classification problems when properly tuned.[m
[32m+[m[32mG. Model Evaluation[m
[32m+[m[32mThe models are evaluated separately for D+1, D+2, and D+3 horizons. Since flood prediction is an imbalanced classification problem, Accuracy alone is not sufficient. The following metrics are used:[m
[32m+[m[32m[ Accuracy =  ][m
[32m+[m[32m[ Precision =  ][m
[32m+[m[32m[ Recall =  ][m
[32m+[m[32m[ F1 = 2  ][m
[32m+[m[32mIn addition, ROC-AUC and PR-AUC are used. PR-AUC is especially important because flood events are rare compared with non-flood days.[m
[32m+[m[32mH. Risk Score and Alert Level Generation[m
[32m+[m[32mFor each forecast horizon, the trained model outputs a flood probability:[m
[32m+[m[32m[ P(flood) = model.predict_proba(X) ][m
[32m+[m[32mThe Flood Risk Score is calculated as:[m
[32m+[m[32m[ Flood Risk Score = P(flood)  ][m
[32m+[m[32mThe Alert Level is assigned using rule-based thresholds.[m
[32m+[m[32mTable IV[m
[32m+[m[32mFlood Alert Level Thresholds[m
[32m+[m[32m                                                               Flood Risk Score[m
[32m+[m[32mAlert Level[m
[32m+[m[32mMeaning[m
[32m+[m[32m                                                                         0 - 19[m
[32m+[m[32mGreen[m
[32m+[m[32mLow risk[m
[32m+[m[32m                                                                        20 - 39[m
[32m+[m[32mYellow[m
[32m+[m[32mMonitor conditions[m
[32m+[m[32m                                                                        40 - 59[m
[32m+[m[32mOrange[m
[32m+[m[32mPrepare for possible flooding[m
[32m+[m[32m                                                                        60 - 79[m
[32m+[m[32mRed[m
[32m+[m[32mHigh flood risk[m
[32m+[m[32m                                                                       80 - 100[m
[32m+[m[32mSevere Red[m
[32m+[m[32mVery high risk and urgent warning[m
[32m+[m[32mI. Confidence Score[m
[32m+[m[32mThe Confidence Score is calculated as the maximum predicted class probability:[m
[32m+[m[32m[ Confidence = max(P(flood), P(nonflood))  ][m
[32m+[m[32mThis score represents classification confidence, not fully calibrated uncertainty. In future work, probability calibration methods such as Platt Scaling or Isotonic Regression can be used to improve the reliability of confidence estimation.[m
[32m+[m[32mJ. Safety Recommendation[m
[32m+[m[32mSafety recommendations are generated using rule-based logic according to the Alert Level and main risk factors. For example:[m
[32m+[m[32m Green: normal condition, continue monitoring.[m
[32m+[m[32m Yellow: monitor rainfall and river conditions.[m
[32m+[m[32m Orange: prepare emergency supplies and avoid low-lying areas.[m
[32m+[m[32m Red: move valuable items to higher places and prepare evacuation.[m
[32m+[m[32m Severe Red: follow official evacuation instructions and avoid flooded roads.[m
[32m+[m[32mThis makes the system more useful as a practical early warning product.[m
[32m+[m
[32m+[m[32mV. Experiment and Results[m
[32m+[m[32mA. Exploratory Data Analysis[m
[32m+[m[32mExploratory data analysis is conducted to understand the characteristics of the dataset before model training.[m
[32m+[m
[32m+[m[32mFig. 2. Flood label distribution in the dataset.[m
[32m+[m[32mThe flood label distribution shows that flood events account for only a small portion of the dataset. This indicates that the dataset is highly imbalanced. Therefore, model evaluation should focus on Recall, F1-score, ROC-AUC, and PR-AUC rather than Accuracy alone.[m
[32m+[m
[32m+[m[32mFig. 3. Daily rainfall trend in Hue and Quang Nam from 2001 to 2026.[m
[32m+[m[32mThe daily rainfall trend shows strong temporal variability and several rainfall peaks. These peaks are important because extreme rainfall is one of the main triggers of flood events.[m
[32m+[m
[32m+[m[32mFig. 4. Monthly average rainfall distribution by location.[m
[32m+[m[32mMonthly rainfall analysis shows seasonal rainfall patterns in the study areas. This supports the use of month and season as temporal features in the model.[m
[32m+[m
[32m+[m
[32m+[m[32mFig. 5. Three-day and seven-day cumulative rainfall under flood and non-flood conditions.[m
[32m+[m[32mCumulative rainfall features help capture antecedent rainfall conditions. Flood risk may increase when heavy rainfall occurs continuously over several days.[m
[32m+[m
[32m+[m[32mFig. 6. River discharge distribution under flood and non-flood conditions.[m
[32m+[m[32mRiver discharge is a hydrological indicator that reflects river flow conditions. A rapid increase in river discharge may indicate rising flood risk, especially when combined with heavy rainfall.[m
[32m+[m
[32m+[m[32mFig. 7. Correlation matrix of meteorological, hydrological, and engineered variables.[m
[32m+[m[32mThe correlation matrix provides an overview of relationships among input variables and flood labels. Although correlation does not fully capture nonlinear effects, it helps identify potentially relevant predictors.[m
[32m+[m[32mB. Experimental Setup[m
[32m+[m[32mThe cleaned and labeled dataset is split using a time-based strategy to avoid data leakage. Earlier records are used for training, while later records are used for testing. For each algorithm, three models are trained for D+1, D+2, and D+3 forecasting.[m
[32m+[m[32mThe experimental setup is summarized as follows:[m
[32m+[m[32mTable V[m
[32m+[m[32mExperimental Setup[m
[32m+[m[32mComponent[m
[32m+[m[32mDescription[m
[32m+[m[32mTask[m
[32m+[m[32mBinary flood risk classification[m
[32m+[m[32mForecast horizons[m
[32m+[m[32mD+1, D+2, D+3[m
[32m+[m[32mModels[m
[32m+[m[32mRandom Forest, XGBoost[m
[32m+[m[32mInput features[m
[32m+[m[32mMeteorological, hydrological, temporal, and engineered features[m
[32m+[m[32mTarget labels[m
[32m+[m[32mflood_d1, flood_d2, flood_d3[m
[32m+[m[32mSplit method[m
[32m+[m[32mTime-based train/test split[m
[32m+[m[32mMain metrics[m
[32m+[m[32mAccuracy, Precision, Recall, F1-score, ROC-AUC, PR-AUC[m
[32m+[m[32mC. Model Comparison[m
[32m+[m[32mThe performance of Random Forest and XGBoost should be reported separately for each forecasting horizon.[m
[32m+[m[32mTable VI[m
[32m+[m[32mPerformance Comparison of Random Forest and XGBoost[m
[32m+[m[32mModel[m
[32m+[m[32mHorizon[m
[32m+[m[32m                                                                       Accuracy[m
[32m+[m[32m                                                                      Precision[m
[32m+[m[32m                                                                         Recall[m
[32m+[m[32m                                                                       F1-score[m
[32m+[m[32m                                                                        ROC-AUC[m
[32m+[m[32m                                                                         PR-AUC[m
[32m+[m[32mRandom Forest[m
[32m+[m[32mD+1[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32mRandom Forest[m
[32m+[m[32mD+2[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32mRandom Forest[m
[32m+[m[32mD+3[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32mXGBoost[m
[32m+[m[32mD+1[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32mXGBoost[m
[32m+[m[32mD+2[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32mXGBoost[m
[32m+[m[32mD+3[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32mThe final values should be filled after retraining the models using the corrected D+1, D+2, and D+3 targets. If the test set contains no positive flood events, the evaluation should be redesigned because Precision, Recall, F1-score, ROC-AUC, and PR-AUC may become undefined or misleading.[m
[32m+[m[32mD. Confusion Matrix Analysis[m
[32m+[m[32mFor each model and each forecast horizon, a confusion matrix should be generated.[m
[32m+[m[32m[Insert Fig. 8 here][m
[32m+[m[32mFig. 8. Confusion matrix of the Random Forest model for D+1 flood prediction.[m
[32m+[m[32m[Insert Fig. 9 here][m
[32m+[m[32mFig. 9. Confusion matrix of the XGBoost model for D+1 flood prediction.[m
[32m+[m[32mThe confusion matrix helps evaluate how many flood events are correctly detected and how many false alarms are produced. In flood early warning systems, false negatives are especially important because missing a real flood event may lead to serious consequences. Therefore, Recall should be prioritized together with F1-score and PR-AUC.[m
[32m+[m[32mE. Feature Importance[m
[32m+[m[32mFeature importance analysis is used to interpret the trained models.[m
[32m+[m[32m[Insert Fig. 10 here][m
[32m+[m[32mFig. 10. Top feature importance of the Random Forest flood prediction model.[m
[32m+[m[32mImportant variables are expected to include river discharge, rainfall, rainfall over three days, rainfall over seven days, river discharge change, month, and season. These variables are hydrologically meaningful because flood occurrence is strongly related to rainfall accumulation and river flow conditions.[m
[32m+[m[32mF. Example of Prediction Output[m
[32m+[m[32mThe proposed system generates three-day flood risk outputs for each selected location.[m
[32m+[m[32mTable VII[m
[32m+[m[32mExample of Three-Day Flood Forecasting Output[m
[32m+[m[32mHorizon[m
[32m+[m[32m                                                               Flood Risk Score[m
[32m+[m[32mAlert Level[m
[32m+[m[32mRiver Trend[m
[32m+[m[32m                                                               Confidence Score[m
[32m+[m[32mRecommendation[m
[32m+[m[32mD+1[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m...[m
[32m+[m[32m...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m...[m
[32m+[m[32mD+2[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m...[m
[32m+[m[32m...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m...[m
[32m+[m[32mD+3[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m...[m
[32m+[m[32m...[m
[32m+[m[32m                                                                            ...[m
[32m+[m[32m...[m
[32m+[m[32m[Insert Fig. 11 here][m
[32m+[m[32mFig. 11. Example visualization of D+1, D+2, and D+3 Flood Risk Scores.[m
[32m+[m[32mThis output format is designed to be understandable for non-technical users. Instead of showing only raw model probability, the system translates predictions into risk scores, alert levels, river trends, and safety recommendations.[m
[32m+[m
[32m+[m[32mVI. Discussion[m
[32m+[m[32mThe proposed system demonstrates the feasibility of building an AI-driven flood monitoring and prediction prototype using public meteorological and hydrological data. Its main strength is the end-to-end product design. The system does not only train a machine learning model but also connects data collection, data cleaning, database storage, feature engineering, model prediction, alert generation, and safety recommendation.[m
[32m+[m[32mThe use of D+1, D+2, and D+3 forecasting horizons makes the system more useful for short-term early warning. A one-day forecast can support immediate preparation, while two-day and three-day forecasts provide additional time for planning and monitoring. The use of both Random Forest and XGBoost also allows model comparison and helps identify which algorithm performs better for the available dataset.[m
[32m+[m[32mHowever, several limitations remain. First, the current labels are generated from disaster event records, which may not represent precise local flood depth or flood extent. Disaster records usually describe major events rather than detailed daily inundation conditions. Second, the dataset is imbalanced because flood events occur much less frequently than non-flood days. Third, if the test period does not contain positive flood events, model evaluation becomes unreliable. Fourth, the current system does not include terrain elevation, land use, drainage capacity, soil moisture, or distance to river, although these variables can strongly affect local flood risk. Fifth, the current system does not predict water depth or flood duration because ground-truth inundation data are not available.[m
[32m+[m[32mFrom a product perspective, the proposed system is suitable as an early-stage prototype. It can show users flood risk trends, warning levels, and recommendations. However, before real-world deployment, it should be validated using more locations, more flood events, official hydrological observations, and local disaster reports. The warning thresholds should also be reviewed with domain experts or official disaster management guidelines.[m
[32m+[m
[32m+[m[32mVII. Conclusion and Future Work[m
[32m+[m[32mThis paper presented an AI-driven flood monitoring and prediction system for short-term flood risk forecasting. The system collects meteorological and hydrological data, performs preprocessing and feature engineering, constructs flood labels from historical disaster records, trains Random Forest and XGBoost models, and produces product-oriented warning outputs. The proposed framework supports D+1, D+2, and D+3 flood risk forecasting and generates Flood Risk Score, Alert Level, River Trend, Confidence Score, main risk factors, and safety recommendations.[m
[32m+[m[32mThe current prototype shows a clear end-to-end design for flood early warning. However, the model must be retrained and evaluated using corrected D+1, D+2, and D+3 labels. In addition, the evaluation set should contain both flood and non-flood events to make metrics such as Precision, Recall, F1-score, ROC-AUC, and PR-AUC meaningful.[m
[32m+[m[32mFuture work will focus on five directions. First, the dataset will be expanded to include more provinces, river basins, and historical flood events. Second, additional features such as water level, elevation, land use, soil moisture, distance to river, and drainage capacity will be added. Third, the system will test more advanced models such as LightGBM, CatBoost, LSTM, GRU, and temporal Transformer models. Fourth, probability calibration and explainability methods such as SHAP will be added to improve confidence estimation and model interpretability. Finally, the prototype will be deployed as a practical web-based flood early warning platform using FastAPI, a spatial database, scheduled API updates, dashboard visualization, and map-based alert display.[m
[32m+[m
[32m+[m[32mReferences[m
[32m+[m[32m[1] A. Mosavi, P. Ozturk, and K. W. Chau, "Flood Prediction Using Machine Learning Models: Literature Review," Water, vol. 10, no. 11, 1536, 2018, doi: 10.3390/w10111536.[m
[32m+[m[32mRelation to this project: This paper reviews machine learning approaches for flood prediction and supports the use of ensemble learning methods such as Random Forest and boosting-based models.[m
[32m+[m[32m[2] S. Nevo et al., "Flood forecasting with machine learning models in an operational framework," Hydrology and Earth System Sciences, vol. 26, pp. 4013 - 4032, 2022, doi: 10.5194/hess-26-4013-2022.[m
[32m+[m[32mRelation to this project: This paper presents an operational flood forecasting system with data validation, forecasting, inundation modeling, and alert distribution, which is closely related to the end-to-end product direction of this project.[m
[32m+[m[32m[3] G. Nearing et al., "Global prediction of extreme floods in ungauged watersheds," Nature, vol. 627, pp. 559 - 563, 2024, doi: 10.1038/s41586-024-07145-1.[m
[32m+[m[32mRelation to this project: This work shows that AI can support flood forecasting in areas with limited local gauge data, which is relevant to using public data APIs for scalable flood prediction.[m
[32m+[m[32m[4] R. Costache, "Flood Susceptibility Assessment by Using Bivariate Statistics and Machine Learning Models -- A Useful Tool for Flood Risk Management," Water Resources Management, vol. 33, pp. 3239 - 3256, 2019, doi: 10.1007/s11269-019-02301-z.[m
[32m+[m[32mRelation to this project: This paper is relevant to the Flood Risk Score concept because it focuses on flood susceptibility and risk assessment using machine learning and statistical indicators.[m
[32m+[m[32m[5] S. Yi et al., "Reservoir-based flood forecasting and warning: deep learning versus machine learning," Applied Water Science, 2024, doi: 10.1007/s13201-024-02298-w.[m
[32m+[m[32mRelation to this project: This paper compares machine learning and deep learning for flood discharge forecasting, which is related to the use of river discharge as a core hydrological feature.[m
[32m+[m[32m[6] M. F. Omar, M. N. M. Nawi, J. M. Jamil, A. M. Mohamad, and S. Kamaruddin, "Research Design of Mobile Based Decision Support for Early Flood Warning System," International Journal of Interactive Mobile Technologies, vol. 14, no. 17, pp. 130 - 140, 2020, doi: 10.3991/ijim.v14i17.16557.[m
[32m+[m[32mRelation to this project: This paper supports the decision-support aspect of the proposed system, especially alert communication and safety recommendation.[m
[32m+[m[32m[7] CRED, "EM-DAT: The International Disaster Database."[m
[32m+[m[32mRelation to this project: EM-DAT-style disaster records are used as the basis for constructing historical flood labels.[m
[32m+[m[32m[8] Open-Meteo, "Weather Forecast API Documentation" and "Flood API Documentation."[m
[32m+[m[32mRelation to this project: Open-Meteo weather and flood data services provide meteorological and river discharge inputs for the proposed system.[m
[1mdiff --git a/AI_Driven_Flood_Product_Paper_Springer_Draft.docx b/AI_Driven_Flood_Product_Paper_Springer_Draft.docx[m
[1mnew file mode 100644[m
[1mindex 0000000..9f65ddd[m
