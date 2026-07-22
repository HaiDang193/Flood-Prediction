print("=" * 118)
print(" " * 42 + "FLOOD PREDICTION SYSTEM")
print("=" * 118)

print(f"{'Dataset':<22}: API Open-Meteo and EM-DAT")
print(f"{'Period':<22}: 2001-01-01 to 2026-07-22")
print(f"{'Total samples':<22}: 18,268")
print(f"{'Features used':<22}: 16")
print(f"{'Target variables':<22}: target_d1, target_d2, target_d3")
print(f"{'Data Storage':<22}: SQL Server Management Studio (db: flood)")


# ============================================================
# MODEL COMPARISON
# ============================================================

print("\n" + "=" * 118)
print("MODEL COMPARISON")
print("=" * 118)

print(
    f"{'Model':<15}"
    f"{'Target':<12}"
    f"{'Accuracy':>10}"
    f"{'Precision':>11}"
    f"{'Recall':>10}"
    f"{'F1-score':>11}"
    f"{'ROC-AUC':>10}"
    f"{'PR-AUC':>10}"
    f"{'FN':>8}"
)

print("-" * 97)

rows = [
    ("Random Forest", "target_d1", 0.9323, 0.8282, 0.7224, 0.7717, 0.9640, 0.8670, 113),
    ("Random Forest", "target_d2", 0.9009, 0.7360, 0.5823, 0.6502, 0.9206, 0.7445, 170),
    ("Random Forest", "target_d3", 0.8612, 0.5902, 0.3877, 0.4680, 0.8643, 0.5593, 248),

    ("XGBoost", "target_d1", 0.9086, 0.6581, 0.8796, 0.7529, 0.9648, 0.8730, 49),
    ("XGBoost", "target_d2", 0.8713, 0.5640, 0.8231, 0.6693, 0.9253, 0.7556, 72),
    ("XGBoost", "target_d3", 0.8247, 0.4648, 0.7506, 0.5741, 0.8695, 0.5699, 101),
]

for row in rows:

    model, target, acc, prec, recall, f1, roc, pr, fn = row

    print(
        f"{model:<15}"
        f"{target:<12}"
        f"{acc:>10.4f}"
        f"{prec:>11.4f}"
        f"{recall:>10.4f}"
        f"{f1:>11.4f}"
        f"{roc:>10.4f}"
        f"{pr:>10.4f}"
        f"{fn:>8}"
    )


# ============================================================
# SELECTED MODELS
# ============================================================

print("\n" + "=" * 118)
print("SELECTED MODELS FOR FLOOD PREDICTION")
print("=" * 118)

print(
    f"{'Target':<12}"
    f"{'Model':<12}"
    f"{'Accuracy':>10}"
    f"{'Precision':>11}"
    f"{'Recall':>10}"
    f"{'F1-score':>11}"
    f"{'ROC-AUC':>10}"
    f"{'PR-AUC':>10}"
)

print("-" * 86)

selected_rows = [
    ("target_d1", "XGBoost", 0.908631, 0.658088, 0.879607, 0.752892, 0.964759, 0.873036),
    ("target_d2", "XGBoost", 0.871306, 0.563973, 0.823096, 0.669331, 0.925262, 0.755556),
    ("target_d3", "XGBoost", 0.824650, 0.464832, 0.750617, 0.574127, 0.869479, 0.569905),
]

for row in selected_rows:

    target, model, acc, prec, recall, f1, roc, pr = row

    print(
        f"{target:<12}"
        f"{model:<12}"
        f"{acc:>10.4f}"
        f"{prec:>11.4f}"
        f"{recall:>10.4f}"
        f"{f1:>11.4f}"
        f"{roc:>10.4f}"
        f"{pr:>10.4f}"
    )


# ============================================================
# CONFUSION MATRIX
# ============================================================

print("\n" + "=" * 118)
print("CONFUSION MATRIX - SELECTED XGBOOST MODELS")
print("=" * 118)

print(
    f"{'Target':<12}"
    f"{'TN':>12}"
    f"{'FP':>12}"
    f"{'FN':>12}"
    f"{'TP':>12}"
)

print("-" * 60)

confusion_rows = [
    ("target_d1", 1979, 186, 49, 358),
    ("target_d2", 1906, 259, 72, 335),
    ("target_d3", 1817, 350, 101, 304),
]

for row in confusion_rows:

    target, tn, fp, fn, tp = row

    print(
        f"{target:<12}"
        f"{tn:>12}"
        f"{fp:>12}"
        f"{fn:>12}"
        f"{tp:>12}"
    )


# ============================================================
# FINAL MODEL SELECTION
# ============================================================

print("\n" + "=" * 118)
print("FINAL MODEL SELECTION")
print("=" * 118)

print(f"{'D+1 Flood Prediction':<30}: XGBoost")
print(f"{'D+2 Flood Prediction':<30}: XGBoost")
print(f"{'D+3 Flood Prediction':<30}: XGBoost")

print("-" * 118)

print("Selection priority: Recall > Precision > F1-score > PR-AUC")
print("Reason: Missing a real flood (False Negative) is more critical than issuing a false warning.")

print("=" * 118)