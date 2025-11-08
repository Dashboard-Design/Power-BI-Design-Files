#!/usr/bin/env python3
"""
===================================================================
DATA QUALITY VALIDATION SCRIPT
===================================================================
Description: Validates the Malaysia Tourism dataset for quality issues
Usage: python qa-validation.py
Output: Prints validation report to console and saves to docs/QA_REPORT.md
===================================================================
"""

import pandas as pd
import numpy as np
from pathlib import Path
import sys
from datetime import datetime

# Configuration
DATA_FILE = Path(__file__).parent.parent / "data" / "arrivals_soe.csv"
OUTPUT_FILE = Path(__file__).parent.parent / "docs" / "QA_REPORT.md"

def print_header(title):
    """Print formatted section header"""
    print(f"\n{'='*70}")
    print(f" {title}")
    print(f"{'='*70}\n")

def print_check(check_name, status, details=""):
    """Print formatted check result"""
    status_icon = "✅" if status else "❌"
    print(f"{status_icon} {check_name:40} {details}")

def main():
    print_header("MALAYSIA TOURISM DATASET - QA VALIDATION")

    # Check if file exists
    if not DATA_FILE.exists():
        print(f"❌ ERROR: Data file not found at {DATA_FILE}")
        sys.exit(1)

    print(f"📁 Loading data from: {DATA_FILE}")

    # Load dataset
    try:
        df = pd.read_csv(DATA_FILE)
        print(f"✅ Successfully loaded {len(df):,} rows\n")
    except Exception as e:
        print(f"❌ ERROR: Failed to load CSV: {e}")
        sys.exit(1)

    # Initialize results dictionary
    results = {
        "timestamp": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        "file_path": str(DATA_FILE),
        "checks": []
    }

    # ===================================================================
    # 1. BASIC STRUCTURE CHECKS
    # ===================================================================
    print_header("1. BASIC STRUCTURE CHECKS")

    # Row count
    row_count = len(df)
    print_check("Row count", True, f"{row_count:,} rows")
    results["row_count"] = row_count

    # Column count
    expected_cols = ["date", "country", "soe", "arrivals", "arrivals_male", "arrivals_female"]
    col_count = len(df.columns)
    cols_match = list(df.columns) == expected_cols
    print_check("Column schema", cols_match, f"{col_count} columns")
    results["columns"] = list(df.columns)

    if not cols_match:
        print(f"  Expected: {expected_cols}")
        print(f"  Actual:   {list(df.columns)}")

    # ===================================================================
    # 2. DATA TYPE VALIDATION
    # ===================================================================
    print_header("2. DATA TYPE VALIDATION")

    # Convert date column
    try:
        df['date'] = pd.to_datetime(df['date'])
        print_check("Date type conversion", True, "Successfully parsed as datetime")
    except Exception as e:
        print_check("Date type conversion", False, f"Error: {e}")

    # Check numeric columns
    numeric_cols = ['arrivals', 'arrivals_male', 'arrivals_female']
    for col in numeric_cols:
        is_numeric = pd.api.types.is_numeric_dtype(df[col])
        print_check(f"{col} is numeric", is_numeric, f"dtype: {df[col].dtype}")

    # ===================================================================
    # 3. NULL/MISSING VALUE CHECKS
    # ===================================================================
    print_header("3. NULL/MISSING VALUE CHECKS")

    null_counts = df.isnull().sum()
    for col in df.columns:
        null_count = null_counts[col]
        null_pct = (null_count / len(df) * 100) if len(df) > 0 else 0
        status = null_count == 0
        print_check(f"Nulls in {col}", status, f"{null_count:,} ({null_pct:.2f}%)")
        results["checks"].append({
            "check": f"Nulls in {col}",
            "status": "PASS" if status else "FAIL",
            "count": int(null_count),
            "percentage": round(null_pct, 2)
        })

    # ===================================================================
    # 4. DUPLICATE CHECKS
    # ===================================================================
    print_header("4. DUPLICATE CHECKS")

    # Check for duplicate rows (entire row)
    dup_rows = df.duplicated().sum()
    print_check("Duplicate rows", dup_rows == 0, f"{dup_rows:,} duplicates")

    # Check for duplicate keys (date + country + soe)
    dup_keys = df.duplicated(subset=['date', 'country', 'soe']).sum()
    print_check("Duplicate keys", dup_keys == 0, f"{dup_keys:,} duplicates")
    results["checks"].append({
        "check": "Duplicate keys",
        "status": "PASS" if dup_keys == 0 else "FAIL",
        "count": int(dup_keys)
    })

    # ===================================================================
    # 5. VALUE RANGE VALIDATION
    # ===================================================================
    print_header("5. VALUE RANGE VALIDATION")

    # Check for negative values
    for col in numeric_cols:
        neg_count = (df[col] < 0).sum()
        print_check(f"No negative values in {col}", neg_count == 0, f"{neg_count:,} negative")
        results["checks"].append({
            "check": f"Negative values in {col}",
            "status": "PASS" if neg_count == 0 else "FAIL",
            "count": int(neg_count)
        })

    # Check sum validation (total = male + female)
    df['calculated_total'] = df['arrivals_male'] + df['arrivals_female']
    sum_mismatch = (df['arrivals'] != df['calculated_total']).sum()
    print_check("Sum validation (total = male + female)", sum_mismatch == 0,
                f"{sum_mismatch:,} mismatches")
    results["checks"].append({
        "check": "Sum validation",
        "status": "PASS" if sum_mismatch == 0 else "FAIL",
        "count": int(sum_mismatch)
    })

    # Date range
    min_date = df['date'].min()
    max_date = df['date'].max()
    date_range_days = (max_date - min_date).days
    print_check("Date range", True, f"{min_date.strftime('%Y-%m-%d')} to {max_date.strftime('%Y-%m-%d')}")
    print(f"   Total period: {date_range_days} days ({date_range_days/30:.1f} months)")
    results["date_range"] = {
        "min": min_date.strftime('%Y-%m-%d'),
        "max": max_date.strftime('%Y-%m-%d'),
        "days": int(date_range_days)
    }

    # ===================================================================
    # 6. CARDINALITY CHECKS
    # ===================================================================
    print_header("6. CARDINALITY CHECKS")

    distinct_dates = df['date'].nunique()
    distinct_countries = df['country'].nunique()
    distinct_states = df['soe'].nunique()

    print_check("Distinct dates", True, f"{distinct_dates:,} unique months")
    print_check("Distinct countries", True, f"{distinct_countries:,} unique countries")
    print_check("Distinct states", True, f"{distinct_states:,} unique states")

    results["cardinality"] = {
        "dates": int(distinct_dates),
        "countries": int(distinct_countries),
        "states": int(distinct_states)
    }

    # List states
    states = sorted(df['soe'].unique())
    print(f"\n   States: {', '.join(states)}")

    # Top 10 countries
    top_countries = df.groupby('country')['arrivals'].sum().nlargest(10)
    print(f"\n   Top 10 Countries by Total Arrivals:")
    for country, arrivals in top_countries.items():
        print(f"   - {country}: {arrivals:,}")

    # ===================================================================
    # 7. STATISTICAL SUMMARY
    # ===================================================================
    print_header("7. STATISTICAL SUMMARY")

    print("Arrivals Statistics:")
    print(df[numeric_cols].describe().to_string())

    total_arrivals = df['arrivals'].sum()
    avg_arrivals = df['arrivals'].mean()
    median_arrivals = df['arrivals'].median()

    print(f"\n📊 Key Statistics:")
    print(f"   Total Arrivals:   {total_arrivals:,}")
    print(f"   Average per row:  {avg_arrivals:,.0f}")
    print(f"   Median per row:   {median_arrivals:,.0f}")
    print(f"   Max single entry: {df['arrivals'].max():,}")
    print(f"   Records with 0:   {(df['arrivals'] == 0).sum():,}")

    results["statistics"] = {
        "total_arrivals": int(total_arrivals),
        "mean_arrivals": float(avg_arrivals),
        "median_arrivals": float(median_arrivals),
        "max_arrivals": int(df['arrivals'].max()),
        "zero_count": int((df['arrivals'] == 0).sum())
    }

    # ===================================================================
    # 8. DATA QUALITY SCORE
    # ===================================================================
    print_header("8. DATA QUALITY SCORE")

    # Calculate quality score
    quality_checks = [
        dup_keys == 0,  # No duplicate keys
        null_counts.sum() == 0,  # No nulls
        (df['arrivals'] >= 0).all(),  # No negative arrivals
        sum_mismatch == 0,  # Sum validation passes
        cols_match  # Schema matches
    ]

    quality_score = (sum(quality_checks) / len(quality_checks)) * 100

    print(f"Overall Quality Score: {quality_score:.1f}%")
    print(f"Checks Passed: {sum(quality_checks)}/{len(quality_checks)}")

    if quality_score == 100:
        print("✅ EXCELLENT - Dataset passes all quality checks!")
    elif quality_score >= 80:
        print("⚠️  GOOD - Minor issues detected")
    else:
        print("❌ POOR - Significant data quality issues found")

    results["quality_score"] = round(quality_score, 1)

    # ===================================================================
    # 9. SAVE REPORT
    # ===================================================================
    print_header("9. SAVING REPORT")

    # Create markdown report
    OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)

    with open(OUTPUT_FILE, 'w') as f:
        f.write(f"# Data Quality Validation Report\n\n")
        f.write(f"**Generated:** {results['timestamp']}  \n")
        f.write(f"**Dataset:** {results['file_path']}  \n")
        f.write(f"**Row Count:** {results['row_count']:,}  \n\n")

        f.write(f"## Quality Score\n\n")
        f.write(f"**{results['quality_score']}%** ({sum(quality_checks)}/{len(quality_checks)} checks passed)\n\n")

        f.write(f"## Data Range\n\n")
        f.write(f"- **Start Date:** {results['date_range']['min']}\n")
        f.write(f"- **End Date:** {results['date_range']['max']}\n")
        f.write(f"- **Period:** {results['date_range']['days']} days\n\n")

        f.write(f"## Cardinality\n\n")
        f.write(f"- **Unique Dates:** {results['cardinality']['dates']:,}\n")
        f.write(f"- **Unique Countries:** {results['cardinality']['countries']:,}\n")
        f.write(f"- **Unique States:** {results['cardinality']['states']:,}\n\n")

        f.write(f"## Key Statistics\n\n")
        f.write(f"- **Total Arrivals:** {results['statistics']['total_arrivals']:,}\n")
        f.write(f"- **Mean Arrivals per Record:** {results['statistics']['mean_arrivals']:,.0f}\n")
        f.write(f"- **Median Arrivals:** {results['statistics']['median_arrivals']:,.0f}\n")
        f.write(f"- **Max Arrivals (single record):** {results['statistics']['max_arrivals']:,}\n")
        f.write(f"- **Records with Zero Arrivals:** {results['statistics']['zero_count']:,}\n\n")

        f.write(f"## Validation Checks\n\n")
        f.write(f"| Check | Status | Details |\n")
        f.write(f"|-------|--------|----------|\n")

        for check in results['checks']:
            status_icon = "✅" if check['status'] == "PASS" else "❌"
            details = f"{check.get('count', 'N/A'):,}"
            if 'percentage' in check:
                details += f" ({check['percentage']}%)"
            f.write(f"| {check['check']} | {status_icon} {check['status']} | {details} |\n")

        f.write(f"\n## Recommendations\n\n")

        if quality_score == 100:
            f.write(f"✅ **No issues detected.** Dataset is ready for use in Power BI.\n")
        else:
            f.write(f"⚠️ **Review issues above before proceeding.**\n")

    print(f"✅ Report saved to: {OUTPUT_FILE}")

    print_header("VALIDATION COMPLETE")

    return 0 if quality_score == 100 else 1

if __name__ == "__main__":
    sys.exit(main())
