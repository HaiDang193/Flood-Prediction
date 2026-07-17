[33mcommit 1d0d4fea33c53d4604a85c0735ea1eedb138c82b[m[33m ([m[1;36mHEAD[m[33m -> [m[1;32mmain[m[33m, [m[1;31morigin/main[m[33m, [m[1;31morigin/HEAD[m[33m)[m
Author: Haidang193 <Haidang1932006@gmail.com>
Date:   Sat Jul 4 16:12:51 2026 +0700

    Update project

 ...ven Flood Monitoring and Prediction System.docx |   Bin [31m0[m -> [32m399100[m bytes
 AI_Driven_Flood_Product_Paper_Springer_Draft.docx  |   Bin [31m0[m -> [32m211981[m bytes
 api/config.py                                      |    37 [32m+[m[31m-[m
 api/csv_exporter.py                                |     1 [32m+[m
 api/ui.py                                          |    67 [32m+[m[31m-[m
 api/weather_api.py                                 |    29 [32m+[m[31m-[m
 data/cleaned/cleaned_weather.csv                   | 20817 [32m+++++++++++++++++[m[31m--[m
 data/train/data_train.csv                          | 18623 [32m+++++++++++++++++[m
 data/train/label_raw.csv                           | 15990 [32m++++++++++++++[m
 data/train/master_weather.csv                      | 18623 [32m+++++++++++++++++[m
 data/train/test.csv                                |  2547 [32m+++[m
 data/train/train.csv                               | 16071 [32m++++++++++++++[m
 end                                                |  3891 [32m++++[m
 notebooks/cleaning.ipynb                           |   854 [32m+[m[31m-[m
 output/feature_importance.csv                      |    13 [32m+[m
 output/model_metrics.csv                           |     3 [32m+[m
 output/paper_figures/fig2_label_distribution.png   |   Bin [31m0[m -> [32m68428[m bytes
 output/paper_figures/fig3_daily_rainfall_trend.png |   Bin [31m0[m -> [32m279179[m bytes
 output/paper_figures/fig4_monthly_rainfall.png     |   Bin [31m0[m -> [32m181654[m bytes
 output/paper_figures/fig5_rainfall_3days.png       |   Bin [31m0[m -> [32m104535[m bytes
 output/paper_figures/fig5_rainfall_7days.png       |   Bin [31m0[m -> [32m107063[m bytes
 output/paper_figures/fig6_river_discharge.png      |   Bin [31m0[m -> [32m112464[m bytes
 output/paper_figures/fig7_correlation_heatmap.png  |   Bin [31m0[m -> [32m414117[m bytes
 output/test_predictions.csv                        |  4313 [32m++++[m
 sql/create_table.sql                               |     6 [32m+[m[31m-[m
 sql/insert.sql                                     |     0
 sql/querry.sql                                     |    21 [32m+[m[31m-[m
 src/analyst.ipynb                                  |  2446 [32m+++[m
 src/analyst.py                                     |    73 [31m-[m
 src/db_connection.py                               |     4 [32m+[m[31m-[m
 src/insert_locations.py                            |    44 [32m+[m[31m-[m
 src/insert_river.py                                |    52 [32m+[m[31m-[m
 src/insert_weather.py                              |    57 [32m+[m[31m-[m
 src/label.ipynb                                    |  2110 [32m++[m
 src/paper_figures.ipynb                            |   151 [32m+[m
 src/predict_one_dat.ipynb                          |  1567 [32m++[m
 src/queries.py                                     |    15 [32m+[m[31m-[m
 src/train_model.ipynb                              |  1555 [32m++[m
 38 files changed, 107143 insertions(+), 2837 deletions(-)
