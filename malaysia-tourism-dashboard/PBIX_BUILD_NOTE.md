# Building the PBIX File

## Important Note

This project delivers all source code and artifacts needed to build the Power BI dashboard, but **does not include a pre-built .pbix file** due to the execution environment constraints.

## Why No PBIX File?

- Power BI Desktop requires a Windows GUI environment
- This project was built in a Linux command-line environment
- All source artifacts (M, DAX, JSON) are provided for manual rebuild

## How to Build the PBIX

### Option 1: Manual Build (Recommended)

Follow the detailed step-by-step instructions in:

📖 **`docs/BUILD_GUIDE.md`**

**Time Required:** 45-55 minutes
**Result:** Fully functional .pbix file ready for use

**Quick Steps:**
1. Open Power BI Desktop
2. Load Power Query scripts from `powerquery/*.pq`
3. Add DAX measures from `dax/*.dax`
4. Create visuals per `docs/REPORT_LAYOUT.md`
5. Apply `scripts/theme.json`
6. Save as `Malaysia_Tourism_Dashboard.pbix`

### Option 2: Automated Build (Advanced)

If you have **Tabular Editor** installed, you can use the programmatic approach:

```powershell
# Install Tabular Editor CLI (if not installed)
# https://github.com/TabularEditor/TabularEditor

# Load model from scripts
te2.exe -B scripts/model-relationships.json -D malaysia_tourism.bim

# Then open in Power BI Desktop and build report layer
```

### Option 3: Power BI Project (PBIP) Folder

For version control and team collaboration:

1. Create new Power BI Project in Power BI Desktop
2. File → Save As → Power BI Project (*.pbip)
3. Copy M scripts to `.SemanticModel/definition/tables/` folder
4. Copy DAX to appropriate definition files
5. Power BI Desktop will load from folder structure

## Verification Checklist

After building, verify:

- [ ] All 4 tables loaded (FactArrivals, DimDate, DimCountry, DimState)
- [ ] DimDate marked as date table (calendar icon visible)
- [ ] 3 relationships active (check Model View)
- [ ] 26 measures in _Measures table
- [ ] 5 calculated columns added
- [ ] Theme applied (blue color scheme)
- [ ] All visuals rendering correctly
- [ ] Slicers cross-filtering visuals
- [ ] Data refresh works without errors

## Need Help?

- **Build Issues:** See `README.md` → Troubleshooting
- **DAX Errors:** Check syntax at https://dax.guide/
- **Power Query:** Verify file paths in 01_Parameters.pq

## Alternative: Request Pre-built PBIX

If you need a pre-built PBIX file:

1. **Clone this repository** to a Windows machine
2. **Open Power BI Desktop** (ensure latest version)
3. **Follow BUILD_GUIDE.md** exactly
4. **Save and share** the resulting .pbix

Or contact the project team for assistance.

---

**Note:** All functionality is available in the source files. The PBIX is simply a container format that packages these components. Rebuilding from source ensures you can customize and understand every aspect of the solution.
