# Power BI Build Guide - Malaysia Tourism Dashboard

**Step-by-step instructions to recreate the dashboard from source files**

---

## Prerequisites

Before you begin, ensure you have:

- ✅ Power BI Desktop (latest version) installed
- ✅ All project files downloaded/cloned
- ✅ 30-45 minutes of uninterrupted time
- ✅ Basic familiarity with Power BI interface

---

## Build Process Overview

```
[1] Prepare Environment (5 min)
     ↓
[2] Create New PBIX File (2 min)
     ↓
[3] Load Power Query Scripts (10 min)
     ↓
[4] Configure Data Model (5 min)
     ↓
[5] Add DAX Calculations (10 min)
     ↓
[6] Create Report Visuals (15 min)
     ↓
[7] Apply Theme & Formatting (3 min)
     ↓
[8] Save & Test (5 min)
```

**Total Time:** 45-55 minutes

---

## Step 1: Prepare Environment

### 1.1 Verify Files

Open a terminal/command prompt and navigate to the project folder:

```bash
cd malaysia-tourism-dashboard/
ls -R
```

Ensure you see:
```
./data/arrivals_soe.csv
./powerquery/*.pq (6 files)
./dax/*.dax (4 files)
./scripts/theme.json
./README.md
```

### 1.2 Check Data File

```bash
head -5 data/arrivals_soe.csv
```

Expected output:
```
date,country,soe,arrivals,arrivals_male,arrivals_female
2020-01-01,ABW,Kedah,0,0,0
...
```

✅ If you see this, data is ready!

---

## Step 2: Create New Power BI File

### 2.1 Launch Power BI Desktop

1. Open **Power BI Desktop**
2. Close any startup prompts/templates
3. You should see a blank canvas

### 2.2 Disable Auto Date/Time (CRITICAL)

This step prevents Power BI from creating hidden date tables.

1. **File** → **Options and Settings** → **Options**
2. In the left pane: **Current File** → **Data Load**
3. **UNCHECK** ✅ → ⬜ "Auto Date/Time"
4. Click **OK**

⚠️ **Why?** We're creating a custom Date dimension; auto date/time causes duplicates and performance issues.

### 2.3 Set Locale (Optional but Recommended)

1. Still in **Options** → **Regional Settings**
2. Set **Locale for import:** English (United States)
3. Click **OK**

---

## Step 3: Load Power Query Scripts

This is the most time-consuming step but crucial for proper data modeling.

### 3.1 Open Power Query Editor

1. **Home** tab → **Transform Data** button
2. Power Query Editor window opens

### 3.2 Load Parameters Query

1. In Power Query Editor: **Home** → **New Source** → **Blank Query**
2. A new query appears in the Queries pane (left side), named "Query1"
3. **Right-click** Query1 → **Rename** → Type: `01_Parameters`
4. With `01_Parameters` selected, click **View** → **Advanced Editor**
5. **Delete all text** in the editor window
6. Open file `powerquery/01_Parameters.pq` in a text editor
7. **Copy entire contents**
8. **Paste** into Advanced Editor
9. **IMPORTANT:** Update the `LocalFilePath` line:
   ```m
   LocalFilePath = "/home/user/Power-BI-Design-Files/malaysia-tourism-dashboard/data/arrivals_soe.csv"
   ```
   Change this to match YOUR actual file path. Examples:
   - Windows: `"C:\\Users\\YourName\\Documents\\malaysia-tourism-dashboard\\data\\arrivals_soe.csv"`
   - Mac: `"/Users/YourName/Documents/malaysia-tourism-dashboard/data/arrivals_soe.csv"`
   - Linux: (use your actual path)

10. Click **Done**
11. You should see a **Table** icon next to `01_Parameters` in the Queries pane

### 3.3 Load Source Data Query

Repeat the process for the next query:

1. **Home** → **New Source** → **Blank Query**
2. Rename to `02_SourceData`
3. **Advanced Editor**
4. Delete existing text
5. Copy/paste contents of `powerquery/02_SourceData.pq`
6. Click **Done**

⚠️ You may see an error initially - this is normal until all dependencies load.

### 3.4 Load Remaining Queries

Repeat Step 3.3 for:

- `03_FactArrivals.pq` → Rename query to `03_FactArrivals`
- `04_DimDate.pq` → Rename query to `04_DimDate`
- `05_DimCountry.pq` → Rename query to `05_DimCountry`
- `06_DimState.pq` → Rename query to `06_DimState`

### 3.5 Verify Query Dependencies

Your Queries pane should now show:

```
📁 Queries (6)
  📄 01_Parameters
  📄 02_SourceData
  📄 03_FactArrivals
  📄 04_DimDate
  📄 05_DimCountry
  📄 06_DimState
```

### 3.6 Configure Query Loading

We don't want the intermediate queries to load to the model:

1. **Right-click** `01_Parameters` → **Properties**
2. **UNCHECK** ✅ → ⬜ "Enable load to report"
3. Click **OK**
4. Repeat for `02_SourceData`

Only `03_FactArrivals`, `04_DimDate`, `05_DimCountry`, `06_DimState` should load.

### 3.7 Close & Apply

1. **Home** → **Close & Apply**
2. Wait for data to load (10-30 seconds)
3. You should see 4 tables appear in the **Fields** pane (right side):
   - FactArrivals
   - DimDate
   - DimCountry
   - DimState

✅ **Success!** Data model loaded.

---

## Step 4: Configure Data Model

### 4.1 Switch to Model View

1. Click **Model View** icon on left sidebar (looks like connected tables)

### 4.2 Mark Date Table

1. Click on the **DimDate** table (in the model diagram)
2. **Table Tools** tab appears in ribbon
3. Click **Mark as Date Table** → **Mark as Date Table**
4. Dialog appears: "Choose a date column"
5. Select **Date** from dropdown
6. Click **OK**

✅ DimDate table now has a calendar icon.

### 4.3 Verify Relationships

Power BI should auto-detect relationships. Verify these exist:

| From | To | Cardinality |
|------|-----|-------------|
| FactArrivals[DateKey] | DimDate[DateKey] | Many-to-One (*:1) |
| FactArrivals[CountryCode] | DimCountry[CountryCode] | Many-to-One (*:1) |
| FactArrivals[StateOfEntry] | DimState[StateOfEntry] | Many-to-One (*:1) |

If any are missing:

1. Click **Manage Relationships** (Home tab)
2. **New...**
3. Select tables and columns
4. Ensure **Cardinality: Many to One**
5. **Cross filter direction: Single**
6. Click **OK**

### 4.4 Hide Technical Columns

Hide columns that users shouldn't filter by:

In **FactArrivals** table, right-click these columns → **Hide**:
- DateKey
- Year
- Month
- CountryCode
- StateOfEntry
- DataSource

In **DimDate** table, hide:
- DateKey
- Quarter (keep QuarterName)
- Month (keep MonthName)
- YearMonth (keep YearMonthName)

In **DimState** table, hide:
- StateOfEntry (keep StateName)

### 4.5 Set Sort-By Columns

Ensure month names sort correctly:

1. Select **DimDate** table
2. Click column **MonthName**
3. **Column Tools** tab → **Sort by Column** → Select **Month**
4. Repeat: **YearMonthName** sorted by **YearMonth**
5. Repeat: **QuarterName** sorted by **Quarter**

---

## Step 5: Add DAX Calculations

### 5.1 Create Measures Table

1. Switch to **Data View** (left sidebar, table icon)
2. **Home** tab → **New Table**
3. In formula bar, type: `_Measures = {0}`
4. Press **Enter**
5. **Right-click** `_Measures` table → **Hide in report view**

### 5.2 Add Key Metrics Measures

1. Ensure `_Measures` table is selected
2. **Table Tools** → **New Measure**
3. In formula bar, delete existing text
4. Open `dax/01_Measures_KeyMetrics.dax` in text editor
5. Copy the FIRST measure:
   ```dax
   Total Arrivals :=
   SUM ( FactArrivals[TotalArrivals] )
   ```
6. Paste into formula bar
7. Press **Enter**

Repeat for ALL measures in `01_Measures_KeyMetrics.dax`.

**Tip:** Copy one measure at a time, including the name before `:=`.

### 5.3 Add Time Intelligence Measures

Repeat Step 5.2 for all measures in:
- `dax/02_Measures_TimeIntelligence.dax`

### 5.4 Add Advanced Measures

Repeat Step 5.2 for all measures in:
- `dax/03_Measures_Advanced.dax`

### 5.5 Format Measures

For each measure, set the format:

1. Select measure in Fields pane
2. **Measure Tools** tab → **Format** dropdown

| Measure Type | Format |
|--------------|--------|
| Total Arrivals, counts | Whole Number: **#,##0** |
| Percentages (YoY %, Female %) | Percentage: **0.0%** |
| Indices, ratios | Decimal: **0.00** |

### 5.6 Organize into Display Folders

1. Select measure
2. **Properties** pane (right side, if not visible: View → Properties)
3. **Display Folder:** Type folder name

Use these folders:
- Key Metrics
- Time Intelligence
- Advanced Analytics
- Rankings
- Demographics

### 5.7 Add Calculated Columns

Switch to **Data View**, select **FactArrivals** table:

1. **Table Tools** → **New Column**
2. Copy/paste from `dax/04_CalculatedColumns.dax`:
   ```dax
   Arrival Volume Category =
   SWITCH (
       TRUE (),
       FactArrivals[TotalArrivals] = 0, "No Arrivals",
       ...
   )
   ```
3. Press **Enter**
4. Repeat for `Gender Dominance` column

Select **DimDate** table, add:
- `Is Weekend`
- `Season`

✅ **DAX layer complete!**

---

## Step 6: Create Report Visuals

### 6.1 Switch to Report View

Click **Report View** icon (left sidebar, chart icon)

### 6.2 Page 1: Executive Dashboard

#### Top Row - KPI Cards

1. **Insert** → **Card** visual
2. Drag to top-left corner
3. **Fields:** Drag `Total Arrivals` measure to **Fields** well
4. Resize card to ~300x150px

Repeat for 3 more cards:
- YoY %
- Distinct Countries
- Female Percentage

#### Line Chart - Arrivals Over Time

1. **Insert** → **Line Chart**
2. **X-axis:** DimDate[YearMonthName]
3. **Y-axis:** Total Arrivals
4. **Legend:** (leave empty)
5. **Title:** "Total Arrivals Trend"
6. Resize: ~600x300px

#### Bar Chart - Top Countries

1. **Insert** → **Clustered Bar Chart**
2. **Y-axis:** DimCountry[CountryName]
3. **X-axis:** Total Arrivals
4. **Filters:** Visual-level filter: Top 10 by Total Arrivals
5. **Title:** "Top 10 Countries by Arrivals"

#### Map - Arrivals by State

1. **Insert** → **Map** or **Filled Map**
2. **Location:** DimState[StateName]
3. **Size/Values:** Total Arrivals
4. **Title:** "Arrivals by State"

⚠️ **Note:** Map requires internet connection. If offline, use **Table** instead.

#### Donut Chart - Behavior Categories

1. **Insert** → **Donut Chart**
2. **Legend:** FactArrivals[Arrival Volume Category]
3. **Values:** Total Arrivals
4. **Title:** "Distribution by Volume Category"

#### Slicers

Add 4 slicers across the top/left:

1. **Insert** → **Slicer**
2. **Field:** DimDate[Year]
3. **Style:** Dropdown
4. Repeat for:
   - DimDate[MonthName] → List
   - DimCountry[Region] → List
   - DimState[StateName] → Dropdown

### 6.3 Page 2: Detailed Analysis

1. Click **+** button at bottom to add new page
2. Rename: Right-click page tab → Rename → "Detailed Analysis"

#### Matrix Table

1. **Insert** → **Matrix**
2. **Rows:** DimCountry[CountryName], DimState[StateName]
3. **Columns:** DimDate[Year]
4. **Values:** Total Arrivals, Female Percentage, YoY %
5. Enable drill-down
6. Resize to fill most of page

#### Supporting Charts

Add any combination of:
- Stacked column chart (Gender breakdown)
- Scatter plot (State vs Country volume)
- Ribbon chart (Top countries over time)

### 6.4 Configure Interactions

1. Select a slicer
2. **Format** → **Edit Interactions**
3. Ensure all slicers have **Filter** icon on all visuals (not **None** or **Highlight**)
4. Click **Edit Interactions** again to exit mode

---

## Step 7: Apply Theme & Formatting

### 7.1 Apply Theme

1. **View** tab → **Themes** → **Browse for Themes**
2. Navigate to `scripts/theme.json`
3. Click **Open**
4. Theme applies automatically (blues and professional colors)

### 7.2 Format Page Background

1. Click blank area of canvas (deselect all visuals)
2. **Format** pane (paint roller icon) → **Canvas Background**
3. **Color:** White or Light Gray (#F3F2F1)

### 7.3 Add Page Title

1. **Insert** → **Text Box**
2. Type: "Malaysia Tourism Dashboard - Executive View"
3. **Font:** Segoe UI Semibold, 20pt
4. **Color:** #004C97 (theme primary)
5. Position at top-left

### 7.4 Polish Visuals

For each visual:
- **Title:** Make descriptive and concise
- **Border:** Turn off (unless needed)
- **Background:** Transparent
- **Data Labels:** Show for cards; hide for charts (use axis)

---

## Step 8: Save & Test

### 8.1 Save File

1. **File** → **Save As**
2. Navigate to project root: `malaysia-tourism-dashboard/`
3. **Filename:** `Malaysia_Tourism_Dashboard.pbix`
4. Click **Save**

### 8.2 Test Functionality

Run through this checklist:

- [ ] Click **Refresh** (Home tab) → Data refreshes successfully
- [ ] Select a slicer value → All visuals update
- [ ] Hover over chart → Tooltip shows correct values
- [ ] Click on bar/line → Cross-filters work
- [ ] Check YoY % measure → Shows positive/negative correctly
- [ ] Verify map displays Malaysia states

### 8.3 Test Data Quality

1. Create a new **Table** visual
2. Add: DimDate[Date], Total Arrivals
3. Check row count: Should show 58 months
4. Verify no blank dates or null arrivals

### 8.4 Performance Check

1. Open **Performance Analyzer** (View tab)
2. Click **Start Recording**
3. Click **Refresh Visuals**
4. Review load times (should be <2 seconds per visual)

---

## Step 9: Optional - Save as PBIP (Source Control)

For version control with Git:

1. **File** → **Save As**
2. Change **Save as type:** to **Power BI Project (.pbip)**
3. Save in project folder
4. This creates a folder structure with text-based files

---

## Troubleshooting

### Problem: "Could not find file" error in Power Query

**Solution:**
1. Open Power Query Editor
2. Select `01_Parameters` query
3. Edit `LocalFilePath` to match your actual file location
4. Close & Apply

### Problem: Relationships not created

**Solution:**
1. Model View → Manage Relationships
2. Manually create missing relationships
3. Ensure column names match exactly (case-sensitive)

### Problem: YoY % shows blank

**Solution:**
1. Ensure DimDate is marked as date table
2. Check filter: Need at least 2 years of data
3. Verify date relationship is active (solid line in Model View)

### Problem: Visuals don't cross-filter

**Solution:**
1. Format → Edit Interactions
2. Set all slicers to **Filter** mode
3. Exit Edit Interactions mode

### Problem: Map doesn't load

**Solution:**
- Check internet connection (map requires Bing Maps)
- Alternative: Use **Filled Map** or **Table** visual instead

### Problem: Measures showing #ERROR

**Solution:**
1. Check for typos in DAX code
2. Ensure referenced tables/columns exist
3. Use **DAX Formatter** online tool to validate syntax

---

## Validation Checklist

Before considering build complete:

- [ ] All 4 tables loaded (FactArrivals, DimDate, DimCountry, DimState)
- [ ] DimDate marked as date table
- [ ] 3 relationships active in model
- [ ] 20+ measures created in _Measures table
- [ ] Calculated columns added to FactArrivals and DimDate
- [ ] At least 6-8 visuals on Page 1
- [ ] Theme applied (professional blue color scheme)
- [ ] Slicers filter all visuals correctly
- [ ] File saved as .pbix in project root
- [ ] Refresh works without errors

---

## Next Steps

After successful build:

1. **Test with stakeholders** - Get feedback on layout/metrics
2. **Publish to Service** - Use `scripts/publish.ps1` for automation
3. **Set up refresh** - Configure scheduled refresh in Power BI Service
4. **Share** - Distribute link or embed in SharePoint/Teams

---

## Need Help?

- **Documentation:** See README.md for full details
- **DAX Reference:** https://dax.guide/
- **Power Query:** https://docs.microsoft.com/powerquery-m/
- **Community:** Power BI Community Forums

---

**Build Guide Version:** 1.0
**Last Updated:** 2025-01-08
**Estimated Build Time:** 45-55 minutes
