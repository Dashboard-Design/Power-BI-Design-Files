# Malaysia Tourism Dashboard - Power BI Project

**A production-ready Power BI dashboard analyzing tourism arrivals in Malaysia**

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
[![Data Source: data.gov.my](https://img.shields.io/badge/Data-data.gov.my-blue.svg)](https://data.gov.my/)

---

## 📋 Table of Contents

- [Executive Summary](#executive-summary)
- [Dataset Information](#dataset-information)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Detailed Build Instructions](#detailed-build-instructions)
- [Publishing to Power BI Service](#publishing-to-power-bi-service)
- [Data Model](#data-model)
- [Metrics & Dimensions](#metrics--dimensions)
- [QA & Validation](#qa--validation)
- [Limitations & Assumptions](#limitations--assumptions)
- [Next Steps](#next-steps)
- [Support & Contact](#support--contact)

---

## 📊 Executive Summary

This Power BI dashboard provides comprehensive analytics on **tourism arrivals** in Malaysia using official open data from the Immigration Department of Malaysia. The dashboard covers the five required dimensions:

| Dimension | Implementation |
|-----------|----------------|
| **People** | Tourist arrivals count (total, male, female) |
| **Product/Services** | Country/nationality as market segments |
| **Time/Date** | Monthly time series from 2020 onwards |
| **Place** | Malaysian states (state of entry) |
| **Behaviour** | Arrival volume categories, gender patterns, seasonality |

**Key Features:**
- ✅ Star schema data model with proper relationships
- ✅ 15+ DAX measures including YoY% and time intelligence
- ✅ Calculated columns for behavior classification
- ✅ Professional branding with custom theme
- ✅ Automated publish scripts
- ✅ Full source control (M scripts, DAX, documentation)

---

## 🗃️ Dataset Information

### Primary Dataset

**Name:** Monthly Arrivals by State of Entry, Nationality & Sex
**Source:** Immigration Department of Malaysia (via data.gov.my)
**URL:** https://data.gov.my/data-catalogue/arrivals_soe
**License:** Creative Commons Attribution 4.0 International (CC BY 4.0)
**Format:** CSV (2.7 MB, ~92,675 records)
**Update Frequency:** Monthly
**Last Updated:** November 25, 2024 (data as of October 31, 2024)

### Dataset Schema

| Column | Type | Description |
|--------|------|-------------|
| `date` | Date | Month (YYYY-MM-01 format) |
| `country` | String | ISO-3 country code (XXX = unspecified) |
| `soe` | String | State of entry (Malaysian state name) |
| `arrivals` | Integer | Total arrivals count |
| `arrivals_male` | Integer | Male arrivals count |
| `arrivals_female` | Integer | Female arrivals count |

### Rationale for Dataset Selection

This dataset was chosen because it:

1. **Comprehensive Coverage** - Contains all 5 required dimensions naturally
2. **High Quality** - Official government data with consistent structure
3. **Freshness** - Updated monthly, covers 2020-2024
4. **Granularity** - Monthly time series with state and nationality breakdowns
5. **Size** - Manageable at 2.7 MB (<200 MB requirement)
6. **License** - Permissive CC BY 4.0 allows reuse and redistribution

### Research Sources Consulted

1. **data.gov.my** - https://data.gov.my/data-catalogue
   - Selected: Tourism arrivals dataset
   - Also considered: Household income/expenditure data

2. **OpenDOSM** - https://open.dosm.gov.my/
   - Reviewed: Economic and demographic datasets
   - Note: Tourism data more suitable for 5-dimension analysis

3. **Tourism Malaysia** - https://data.tourism.gov.my/
   - Cross-referenced official tourism statistics

4. **DOSM Open Data Portal** - https://www.dosm.gov.my/portal-main/downloadslist/open-data
   - Reviewed available statistical datasets

5. **Data.gov.my Documentation** - https://developer.data.gov.my/
   - API documentation and data standards

---

## 🏗️ Architecture

### Project Structure

```
malaysia-tourism-dashboard/
├── data/
│   └── arrivals_soe.csv              # Raw data file (2.7 MB)
├── powerquery/
│   ├── 01_Parameters.pq              # Configuration parameters
│   ├── 02_SourceData.pq              # Data ingestion (web/local)
│   ├── 03_FactArrivals.pq            # Fact table transformation
│   ├── 04_DimDate.pq                 # Date dimension
│   ├── 05_DimCountry.pq              # Country dimension
│   └── 06_DimState.pq                # State dimension
├── dax/
│   ├── 01_Measures_KeyMetrics.dax    # Core KPI measures
│   ├── 02_Measures_TimeIntelligence.dax  # YoY, MoM, etc.
│   ├── 03_Measures_Advanced.dax      # Rankings, shares, etc.
│   └── 04_CalculatedColumns.dax      # Behavior classifications
├── scripts/
│   ├── model-relationships.json      # Star schema definition
│   ├── theme.json                    # Power BI theme (branding)
│   ├── publish.ps1                   # PowerShell publish script
│   └── qa-validation.py              # Data quality checks
├── docs/
│   ├── DATASET_MAPPING.md            # 5-dimension mapping details
│   ├── QA_REPORT.md                  # Data quality report
│   └── BUILD_GUIDE.md                # Step-by-step build guide
└── README.md                          # This file
```

### Star Schema Model

```
┌─────────────┐        ┌──────────────┐        ┌──────────────┐
│  DimDate    │        │ FactArrivals │        │ DimCountry   │
├─────────────┤        ├──────────────┤        ├──────────────┤
│ DateKey (PK)│◄───────┤ DateKey (FK) │────────►│CountryCode(PK)│
│ Date        │        │ CountryCode  │        │ CountryName  │
│ Year        │        │ StateOfEntry │        │ Region       │
│ Quarter     │        │ TotalArrivals│        │MarketSegment │
│ Month       │        │ MaleArrivals │        └──────────────┘
│ YearMonth   │        │FemaleArrivals│
└─────────────┘        └──────────────┘
                              │
                              │
                       ┌──────▼──────┐
                       │  DimState   │
                       ├─────────────┤
                       │StateOfEntry │
                       │ StateName   │
                       │ Region      │
                       │EntryPointType│
                       └─────────────┘
```

---

## 🔧 Prerequisites

### Required Software

1. **Power BI Desktop** (version 2.0 or later)
   - Download: https://powerbi.microsoft.com/desktop/

2. **PowerShell 5.1+** (for publish automation)
   - Windows: Built-in
   - macOS/Linux: Install PowerShell Core

3. **Power BI PowerShell Module**
   ```powershell
   Install-Module -Name MicrosoftPowerBIMgmt -Scope CurrentUser
   ```

### Optional Tools

- **Tabular Editor 2/3** - For advanced model editing
- **DAX Studio** - For DAX query testing and optimization
- **Python 3.7+** - For QA validation scripts

### Power BI Service Requirements

- Power BI Pro or Premium Per User license
- Workspace creation permissions
- Or: Use Power BI Desktop in import mode (no service required)

---

## 🚀 Quick Start

### Option A: Using Pre-built PBIX (If Available)

1. Download `Malaysia_Tourism_Dashboard.pbix`
2. Open in Power BI Desktop
3. Refresh data (Data → Refresh All)
4. Publish to service (optional)

### Option B: Build from Source

```bash
# 1. Clone/download the project
cd malaysia-tourism-dashboard/

# 2. Verify data file exists
ls -lh data/arrivals_soe.csv

# 3. Open Power BI Desktop and create new blank file

# 4. Import Power Query scripts (see Detailed Build Instructions)

# 5. Apply DAX measures and calculated columns

# 6. Create report visuals

# 7. Apply theme (View → Themes → Browse → theme.json)

# 8. Save as .pbix file
```

---

## 📚 Detailed Build Instructions

### Step 1: Create New Power BI Project

1. Open **Power BI Desktop**
2. File → **Options and Settings** → **Options**
3. Data Load → Disable **"Auto Date/Time"** (important!)
4. Click **OK**

### Step 2: Load Power Query Scripts

1. Go to **Home** → **Transform Data** (opens Power Query Editor)
2. **New Source** → **Blank Query**
3. Open **Advanced Editor**
4. Copy/paste contents from `powerquery/01_Parameters.pq`
5. Rename query to `01_Parameters`
6. Repeat for all .pq files in order (02-06)

**Important:** Ensure dependencies load in this order:
```
01_Parameters → 02_SourceData → 03_FactArrivals
                                 04_DimDate
                                 05_DimCountry
                                 06_DimState
```

7. Right-click `01_Parameters` → **Advanced Editor** → Update `LocalFilePath` to match your system
8. Click **Close & Apply**

### Step 3: Mark Date Table

1. Go to **Model View**
2. Select `DimDate` table
3. Right-click → **Mark as Date Table**
4. Select **Date** column as the date column
5. Click **OK**

### Step 4: Create Relationships

Power BI should auto-detect relationships. Verify:

```
FactArrivals[DateKey]      → DimDate[DateKey]      (Many-to-One)
FactArrivals[CountryCode]  → DimCountry[CountryCode]  (Many-to-One)
FactArrivals[StateOfEntry] → DimState[StateOfEntry]   (Many-to-One)
```

### Step 5: Create Measure Table

1. In **Model View**, click **New Table**
2. Enter: `_Measures = {0}`
3. Press Enter
4. Right-click table → Hide in report view

### Step 6: Add DAX Measures

1. Select `_Measures` table
2. Click **New Measure** in ribbon
3. Copy/paste measure definitions from `dax/01_Measures_KeyMetrics.dax`
4. Repeat for all measures in files 01-03
5. Organize measures into Display Folders:
   - Select measure → Properties → Display Folder → Enter folder name

### Step 7: Add Calculated Columns

1. Select `FactArrivals` table
2. Click **New Column**
3. Copy/paste column definitions from `dax/04_CalculatedColumns.dax`
4. Repeat for `DimDate` table columns

### Step 8: Format Measures

For each measure, set appropriate formats:

| Measure Type | Format String |
|--------------|---------------|
| Count/Total | `#,##0` |
| Percentage | `0.0%` |
| Decimal | `0.00` |
| Currency | `$#,##0` (if applicable) |

### Step 9: Apply Theme

1. Go to **Report View**
2. **View** → **Themes** → **Browse for Themes**
3. Select `scripts/theme.json`
4. Click **Open**

### Step 10: Create Report Pages

Create visuals covering all required dimensions:

#### Page 1: Executive Dashboard

**KPI Cards** (Top row):
- Total Arrivals
- YoY %
- Distinct Countries
- Female Percentage

**Charts:**
1. **Line Chart** - Total Arrivals by Date (Time dimension)
2. **Bar Chart** - Top 10 Countries by Arrivals (Product/Services dimension)
3. **Map Visual** - Arrivals by State (Place dimension)
4. **Donut Chart** - Arrivals by Volume Category (Behaviour dimension)

**Slicers:**
- Year (dropdown)
- Month Name (list)
- Region (country region)
- State Name (list)

#### Page 2: Detailed Analysis

**Matrix Table:**
- Rows: Country Name, State Name
- Columns: Year, Month
- Values: Total Arrivals, Female %, YoY %

**Additional Charts:**
- Stacked Column: Arrivals by Gender and State
- Ribbon Chart: Top countries over time
- Scatter Plot: State vs. Country volume with bubble size

### Step 11: Configure Cross-Filtering

1. Select each visual
2. Format → Edit Interactions
3. Ensure slicers filter all visuals on the page

### Step 12: Save Project

1. **File** → **Save As**
2. Save as `Malaysia_Tourism_Dashboard.pbix` in project root
3. Optionally save as `.pbip` (Power BI Project) for source control

---

## 📤 Publishing to Power BI Service

### Automated Publishing (PowerShell)

```powershell
cd scripts/
.\publish.ps1 -WorkspaceName "Malaysia Open Data Demo" -TriggerRefresh
```

The script will:
1. ✅ Authenticate to Power BI Service
2. ✅ Create workspace (if needed)
3. ✅ Upload PBIX file
4. ✅ Trigger dataset refresh
5. ⚠️ Prompt for manual credential configuration

### Manual Publishing

1. In Power BI Desktop: **Home** → **Publish**
2. Select workspace: **Malaysia Open Data Demo**
3. Click **Select**
4. Wait for upload to complete
5. Go to Power BI Service
6. Open workspace → Dataset settings
7. Configure data source credentials:
   - Data source: `https://storage.data.gov.my/demography/arrivals_soe.csv`
   - Authentication: **Anonymous** (public data)
8. Click **Refresh Now**

### Scheduled Refresh

1. In workspace, click dataset → **Settings**
2. **Scheduled Refresh** → **Enabled**
3. Set refresh frequency: **Daily** (since data updates monthly)
4. Time zone: **Asia/Kuala_Lumpur**
5. Click **Apply**

---

## 🗂️ Data Model

### Tables

| Table | Type | Rows | Description |
|-------|------|------|-------------|
| `FactArrivals` | Fact | ~92K | Arrivals transactions |
| `DimDate` | Dimension | ~2,191 | 2020-2025 calendar |
| `DimCountry` | Dimension | ~200 | Countries/nationalities |
| `DimState` | Dimension | 16 | Malaysian states |
| `_Measures` | Measures | 1 | Calculation logic |

### Key Measures

| Measure | Definition | Format |
|---------|------------|--------|
| `Total Arrivals` | SUM(FactArrivals[TotalArrivals]) | #,##0 |
| `YoY %` | ([Total Arrivals] - [PY Arrivals]) / [PY Arrivals] | 0.0% |
| `Female Percentage` | [Female Arrivals] / [Total Arrivals] | 0.0% |
| `Distinct Countries` | DISTINCTCOUNT(FactArrivals[CountryCode]) | #,##0 |
| `Rolling 12M Total` | DATESINPERIOD last 12 months | #,##0 |

See `dax/` folder for complete DAX code.

### Calculated Columns

| Column | Table | Purpose |
|--------|-------|---------|
| `Arrival Volume Category` | FactArrivals | **Behaviour** classification (Low/Medium/High) |
| `Gender Dominance` | FactArrivals | **Behaviour** pattern (Male/Female/Balanced) |
| `Season` | DimDate | Monsoon season classification |
| `Region` | DimCountry | Geographic grouping (ASEAN, East Asia, etc.) |
| `EntryPointType` | DimState | Entry classification (Airport, Land, Sea) |

---

## 📏 Metrics & Dimensions

### Mapping to 5 Required Dimensions

| Dimension | Implementation | Tables/Fields |
|-----------|----------------|---------------|
| **People** | Tourist arrivals count | `FactArrivals[TotalArrivals]`, `[MaleArrivals]`, `[FemaleArrivals]` |
| **Product/Services** | Nationality as market segment | `DimCountry[CountryName]`, `[Region]`, `[MarketSegment]` |
| **Time/Date** | Monthly time series | `DimDate[Date]`, `[YearMonth]`, `[Quarter]`, `[Year]` |
| **Place** | Malaysian state of entry | `DimState[StateName]`, `[Region]`, `[EntryPointType]` |
| **Behaviour** | Arrival patterns & volume | `FactArrivals[Arrival Volume Category]`, `[Gender Dominance]`, Seasonality measures |

### Behavior Proxy Derivation

Since the dataset doesn't have explicit "behavior" fields, we derive behavioral metrics through:

1. **Arrival Volume Categories** - Classify traffic as Very Low/Low/Medium/High/Very High/Extreme
2. **Gender Patterns** - Male-dominated, Female-dominated, or Balanced arrivals
3. **Seasonality** - Peak vs. off-peak periods (monsoon seasons)
4. **Frequency Patterns** - Rolling averages, month-over-month trends
5. **Market Concentration** - Top 10 countries vs. long tail

---

## ✅ QA & Validation

### Data Quality Checks

Run QA script:
```bash
python scripts/qa-validation.py
```

### QA Results Summary

| Check | Result | Details |
|-------|--------|---------|
| **Row Count** | ✅ 92,675 | As expected |
| **Duplicates** | ✅ 0 | No duplicate date-country-state combinations |
| **Null Dates** | ✅ 0 | All records have valid dates |
| **Null Arrivals** | ✅ 0 | All records have arrival counts |
| **Data Types** | ✅ Pass | Correct types applied |
| **Date Range** | ✅ 2020-01-01 to 2024-10-01 | 58 months |
| **States** | ✅ 16 | All Malaysian states represented |
| **Countries** | ✅ ~200 | Comprehensive nationality coverage |
| **Negative Values** | ✅ 0 | No negative arrival counts |
| **Sum Validation** | ✅ Pass | Total = Male + Female |

### Data Type Validation

| Column | Expected Type | Actual Type | Status |
|--------|---------------|-------------|--------|
| date | Date | Date | ✅ |
| country | String | String | ✅ |
| soe | String | String | ✅ |
| arrivals | Integer | Integer | ✅ |
| arrivals_male | Integer | Integer | ✅ |
| arrivals_female | Integer | Integer | ✅ |

### Null Handling Strategy

- **Nulls in date/arrivals**: Filtered out during M transformation (RemovedNulls step)
- **Country = "XXX"**: Mapped to "Unspecified" in DimCountry
- **Zero arrivals**: Retained (valid data point indicating no traffic)

### Known Data Limitations

1. **State of Entry ≠ Destination** - The `soe` field represents entry point, not final destination
2. **~0.01% Unspecified Nationality** - Records with country = "XXX"
3. **COVID-19 Impact** - 2020-2021 data affected by pandemic travel restrictions
4. **Entry Point Bias** - States with major airports (Selangor/KL) show higher volumes

See `docs/QA_REPORT.md` for full validation details.

---

## ⚙️ Limitations & Assumptions

### Assumptions

1. **Fiscal Year = Calendar Year** - Malaysia's fiscal year aligns with calendar year
2. **Locale**: English (en-US) for number/date formatting
3. **Time Zone**: Asia/Kuala_Lumpur (GMT+8)
4. **Data Source Mode**: Defaults to "Local" for development; change to "Web" for production
5. **Refresh Schedule**: Daily (though source updates monthly)

### Limitations

1. **No Demographic Details** - Dataset doesn't include age, purpose of visit, duration
2. **Entry Point Only** - State reflects entry point, not travel destination
3. **No Revenue Data** - Cannot analyze spending or economic impact
4. **Limited Historical Data** - Only covers 2020 onwards (COVID era)
5. **Aggregated Data** - Monthly grain; daily data not available

### Technical Constraints

- **Maximum Dataset Size**: Power BI Import mode limits apply (~10GB)
- **DirectQuery Not Supported**: CSV source requires Import mode
- **Real-time Updates**: Not applicable (monthly batch updates)
- **Row-Level Security**: Not implemented (open public data)

---

## 🚀 Next Steps & Extensibility

### Recommended Enhancements

1. **Add Tourism Revenue Data**
   - Enrich with expenditure data from DOSM
   - Calculate economic impact metrics

2. **Integrate Hotel/Accommodation Data**
   - Cross-reference with occupancy rates
   - Better understand destination patterns

3. **Weather Data Correlation**
   - Analyze impact of monsoon seasons on arrivals
   - Use data.gov.my weather datasets

4. **Predictive Analytics**
   - Build forecasting models using Azure ML
   - Predict future arrival trends

5. **Real-time Dashboards**
   - If daily data becomes available, implement streaming
   - Use Power BI streaming datasets

### Additional Data Sources to Consider

| Source | URL | Use Case |
|--------|-----|----------|
| Domestic Tourism Survey | https://open.dosm.gov.my/ | Complement with domestic travel |
| GDP by State | https://data.gov.my/ | Economic correlation analysis |
| Public Holidays | data.gov.my | Event-based seasonality |
| Flight Statistics | MAVCOM | Airline capacity analysis |

### Code Improvements

- [ ] Parameterize date ranges via Power BI parameters
- [ ] Add incremental refresh for large datasets
- [ ] Implement data quality alerts in Power Query
- [ ] Create automated testing suite for DAX measures
- [ ] Build CI/CD pipeline for deployment

---

## 📞 Support & Contact

### Documentation

- **Full Build Guide**: See `docs/BUILD_GUIDE.md`
- **Dataset Mapping Details**: See `docs/DATASET_MAPPING.md`
- **QA Report**: See `docs/QA_REPORT.md`

### Troubleshooting

**Problem: Data doesn't load**
- Check `LocalFilePath` parameter in `01_Parameters.pq`
- Verify `data/arrivals_soe.csv` file exists

**Problem: Relationships not working**
- Ensure DimDate is marked as date table
- Check cardinality settings (many-to-one)
- Verify key columns have no nulls

**Problem: YoY% shows blank**
- Ensure DimDate has continuous date range
- Check filter context (need prior year data)
- Verify date relationships are active

**Problem: Publish script fails**
- Install PowerShell module: `Install-Module MicrosoftPowerBIMgmt`
- Check Power BI Pro license
- Verify workspace permissions

### Data Source Issues

If web data source fails to load:
```M
// In 02_SourceData.pq, change parameter:
DataSourceMode = "Local"  // Use local CSV file
```

### Resources

- **Power BI Documentation**: https://docs.microsoft.com/power-bi/
- **DAX Guide**: https://dax.guide/
- **M Language Reference**: https://docs.microsoft.com/powerquery-m/
- **Data.gov.my Support**: data@data.gov.my

---

## 📄 License & Attribution

### Data License

This project uses data from **data.gov.my** licensed under:

**Creative Commons Attribution 4.0 International (CC BY 4.0)**

You are free to:
- ✅ Share — copy and redistribute the material
- ✅ Adapt — remix, transform, and build upon the material

Under the following terms:
- **Attribution** — You must give appropriate credit to Immigration Department of Malaysia

### Project License

This Power BI project code (M scripts, DAX, documentation) is provided as-is for educational and analytical purposes.

### Required Attribution

When using this dashboard or derivatives, please include:

```
Data Source: Immigration Department of Malaysia via data.gov.my
Dataset: Monthly Arrivals by State of Entry, Nationality & Sex
License: CC BY 4.0
URL: https://data.gov.my/data-catalogue/arrivals_soe
```

---

## 📊 Project Metadata

| Attribute | Value |
|-----------|-------|
| **Project Name** | Malaysia Tourism Dashboard |
| **Version** | 1.0.0 |
| **Created** | 2025-01-08 |
| **Power BI Version** | Desktop (latest) |
| **Dataset Rows** | 92,675 |
| **Dataset Size** | 2.7 MB |
| **Tables** | 5 (1 fact + 3 dims + measures) |
| **Measures** | 20+ |
| **Calculated Columns** | 5 |
| **Target Workspace** | Malaysia Open Data Demo |

---

**Built with ❤️ using Malaysian Open Data**
