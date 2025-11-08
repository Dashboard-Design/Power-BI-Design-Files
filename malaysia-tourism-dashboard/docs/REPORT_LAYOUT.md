# Report Layout Specification

**Dashboard:** Malaysia Tourism Dashboard
**Pages:** 2
**Target Resolution:** 1920x1080 (16:9 aspect ratio)
**Theme:** Malaysia Tourism - Professional Blue

---

## Page 1: Executive Dashboard

**Purpose:** High-level overview for executives and stakeholders
**Key Metrics:** Total arrivals, YoY growth, country diversity, gender distribution
**Interactivity:** Full slicer support with cross-filtering

### Layout Grid (1920x1080)

```
┌────────────────────────────────────────────────────────────────────┐
│  MALAYSIA TOURISM DASHBOARD - EXECUTIVE VIEW                       │
├──────────┬──────────┬──────────┬──────────┬─────────────────────────┤
│  CARD    │  CARD    │  CARD    │  CARD    │  SLICER: Year          │
│  Total   │  YoY %   │ Countries│  Female% │  [Dropdown]            │
│ Arrivals │          │          │          ├─────────────────────────┤
│  32.5M   │  +12.5%  │    195   │   47.2%  │  SLICER: Month         │
│          │          │          │          │  [List - Multi-select] │
├──────────┴──────────┴──────────┴──────────┤                        │
│                                            │                        │
│  LINE CHART                                │  SLICER: Region        │
│  Total Arrivals Over Time                  │  [List]                │
│  X: YearMonth, Y: Total Arrivals           │                        │
│  (600x300px)                               │  SLICER: State         │
│                                            │  [Dropdown]            │
│                                            │                        │
├──────────────────────┬─────────────────────┴─────────────────────────┤
│  BAR CHART           │  MAP VISUAL                                  │
│  Top 10 Countries    │  Arrivals by State (Malaysia)                │
│  Y: Country Name     │  Location: State, Size: Total Arrivals       │
│  X: Total Arrivals   │  (600x400px)                                 │
│  (500x400px)         │                                              │
│                      │                                              │
├──────────────────────┼──────────────────────────────────────────────┤
│  DONUT CHART         │  STACKED BAR                                 │
│  Volume Categories   │  Arrivals by Gender & Top States             │
│  (350x300px)         │  (600x300px)                                 │
└──────────────────────┴──────────────────────────────────────────────┘
```

### Visual Specifications

#### KPI Cards (Top Row)

1. **Total Arrivals Card**
   - Measure: `Total Arrivals`
   - Format: #,##0
   - Font Size: 32pt (value), 14pt (label)
   - Color: #004C97 (theme primary)
   - Dimensions: 200x120px
   - Position: (20, 100)

2. **YoY % Card**
   - Measure: `YoY %`
   - Format: +0.0%;-0.0%
   - Conditional Formatting: Green (+), Red (-)
   - Font Size: 32pt
   - Dimensions: 200x120px
   - Position: (240, 100)

3. **Distinct Countries Card**
   - Measure: `Distinct Countries`
   - Format: #,##0
   - Subtitle: "Nationalities"
   - Font Size: 32pt
   - Dimensions: 200x120px
   - Position: (460, 100)

4. **Female Percentage Card**
   - Measure: `Female Percentage`
   - Format: 0.0%
   - Icon: Gender symbol
   - Font Size: 32pt
   - Dimensions: 200x120px
   - Position: (680, 100)

#### Main Charts

5. **Line Chart - Arrivals Trend**
   - Visual: Line Chart
   - **X-Axis:** DimDate[YearMonthName]
   - **Y-Axis:** [Total Arrivals]
   - **Legend:** None
   - **Data Labels:** Off
   - **Markers:** On
   - **Line Color:** #00A3E0 (theme blue)
   - **Title:** "Tourism Arrivals Trend (Monthly)"
   - Dimensions: 900x320px
   - Position: (20, 240)

6. **Bar Chart - Top Countries**
   - Visual: Clustered Bar Chart
   - **Y-Axis:** DimCountry[CountryName]
   - **X-Axis:** [Total Arrivals]
   - **Sort:** Descending by Total Arrivals
   - **Top N Filter:** 10
   - **Data Labels:** On (inside end)
   - **Color:** Gradient from #004C97 to #00A3E0
   - **Title:** "Top 10 Source Markets"
   - Dimensions: 450x380px
   - Position: (20, 580)

7. **Map Visual - Geographic Distribution**
   - Visual: Filled Map (or Map if filled map unavailable)
   - **Location:** DimState[StateName]
   - **Size/Saturation:** [Total Arrivals]
   - **Color Scale:** Light to Dark Blue
   - **Zoom:** Malaysia bounds
   - **Title:** "Arrivals by Entry State"
   - Dimensions: 800x380px
   - Position: (500, 580)

8. **Donut Chart - Volume Categories**
   - Visual: Donut Chart
   - **Legend:** FactArrivals[Arrival Volume Category]
   - **Values:** [Total Arrivals]
   - **Inner Radius:** 50%
   - **Data Labels:** Percentage
   - **Colors:** Multi-color from theme palette
   - **Title:** "Traffic Distribution by Volume"
   - Dimensions: 400x280px
   - Position: (1320, 580)

#### Slicers

9. **Year Slicer**
   - Field: DimDate[Year]
   - Style: Dropdown
   - Default: All selected
   - Position: (1350, 100)
   - Dimensions: 250x60px

10. **Month Slicer**
    - Field: DimDate[MonthName]
    - Style: List (Vertical)
    - Multi-select: Enabled
    - Position: (1350, 180)
    - Dimensions: 250x200px

11. **Region Slicer**
    - Field: DimCountry[Region]
    - Style: List
    - Multi-select: Enabled
    - Position: (1350, 400)
    - Dimensions: 250x200px

12. **State Slicer**
    - Field: DimState[StateName]
    - Style: Dropdown
    - Position: (1350, 620)
    - Dimensions: 250x60px

---

## Page 2: Detailed Analysis

**Purpose:** Drill-down analysis for analysts
**Key Features:** Matrix table, detailed breakdowns, cross-tabs
**Interactivity:** Drill-down enabled, filters inherited from Page 1

### Layout Grid

```
┌────────────────────────────────────────────────────────────────────┐
│  MALAYSIA TOURISM DASHBOARD - DETAILED ANALYSIS                    │
├────────────────────────────────────────────────────────────────────┤
│  FILTERS (from Page 1 carry over)                                  │
├─────────────────────────────────────┬──────────────────────────────┤
│                                     │  COLUMN CHART                │
│  MATRIX TABLE                       │  Gender Breakdown by State   │
│  Rows: Country → State              │  (Stacked Column)            │
│  Columns: Year                      │  (600x350px)                 │
│  Values:                            │                              │
│    - Total Arrivals                 │                              │
│    - Female %                       │                              │
│    - YoY %                          ├──────────────────────────────┤
│                                     │  RIBBON CHART                │
│  (900x900px)                        │  Top 10 Countries Over Time  │
│                                     │  (600x350px)                 │
│                                     │                              │
│                                     │                              │
│                                     ├──────────────────────────────┤
│                                     │  SCATTER PLOT                │
│                                     │  X: State, Y: Country        │
│                                     │  Size: Total Arrivals        │
│                                     │  (600x300px)                 │
└─────────────────────────────────────┴──────────────────────────────┘
```

### Visual Specifications

1. **Matrix Table**
   - Visual: Matrix
   - **Rows:** DimCountry[CountryName], DimState[StateName]
   - **Columns:** DimDate[Year], DimDate[Quarter]
   - **Values:**
     - [Total Arrivals] - Format: #,##0
     - [Female Percentage] - Format: 0.0%
     - [YoY %] - Format: +0.0%;-0.0%
   - **Drill-down:** Enabled (Country → State)
   - **Conditional Formatting:**
     - YoY %: Red-Yellow-Green scale
     - Total Arrivals: Data bars
   - **Subtotals:** Enabled
   - **Grand Totals:** Enabled
   - Dimensions: 950x900px
   - Position: (20, 100)

2. **Stacked Column - Gender Breakdown**
   - Visual: Stacked Column Chart
   - **X-Axis:** DimState[StateName]
   - **Y-Axis:** [Male Arrivals], [Female Arrivals]
   - **Legend:** Gender
   - **Colors:** Blue (Male), Orange (Female)
   - **Data Labels:** Off (use axis)
   - **Title:** "Gender Distribution by State"
   - Dimensions: 640x350px
   - Position: (1000, 100)

3. **Ribbon Chart - Countries Over Time**
   - Visual: Ribbon Chart
   - **X-Axis:** DimDate[Year]
   - **Y-Axis:** [Total Arrivals]
   - **Legend:** DimCountry[CountryName]
   - **Top N:** 10 countries
   - **Title:** "Top Country Rankings Over Time"
   - Dimensions: 640x350px
   - Position: (1000, 470)

4. **Scatter Plot - Volume Analysis**
   - Visual: Scatter Chart
   - **X-Axis:** DimState[StateName] (encoded)
   - **Y-Axis:** DimCountry[CountryName] (encoded)
   - **Size:** [Total Arrivals]
   - **Color:** DimCountry[Region]
   - **Play Axis:** DimDate[Year] (animation)
   - **Title:** "State × Country Volume Matrix"
   - Dimensions: 640x280px
   - Position: (1000, 840)

---

## Formatting Standards

### Colors (from theme.json)

| Element | Hex Code | Usage |
|---------|----------|-------|
| Primary Blue | #004C97 | Titles, KPI values, primary emphasis |
| Light Blue | #00A3E0 | Charts, secondary elements |
| Accent Yellow | #FFB81C | Highlights, warnings |
| Success Green | #6CC24A | Positive metrics (YoY growth) |
| Alert Red | #E94B3C | Negative metrics, alerts |
| Neutral Gray | #605E5C | Labels, secondary text |

### Typography

| Element | Font | Size | Weight | Color |
|---------|------|------|--------|-------|
| Page Title | Segoe UI | 20pt | Semibold | #004C97 |
| Visual Title | Segoe UI | 14pt | Semibold | #252423 |
| Data Label | Segoe UI | 11pt | Regular | #605E5C |
| KPI Value | Segoe UI Light | 32pt | Light | #004C97 |
| KPI Label | Segoe UI | 14pt | Regular | #605E5C |

### Visual Styling

- **Borders:** Off (use whitespace for separation)
- **Background:** Transparent or White
- **Grid Lines:** Minimal (vertical only in charts)
- **Padding:** 10px between visuals
- **Alignment:** Left-aligned titles, center-aligned values

---

## Interactivity Matrix

**Cross-filtering behavior between visuals:**

| Source ↓ / Target → | Line Chart | Bar Chart | Map | Donut | Matrix |
|---------------------|------------|-----------|-----|-------|--------|
| **Year Slicer** | Filter | Filter | Filter | Filter | Filter |
| **Month Slicer** | Filter | Filter | Filter | Filter | Filter |
| **Region Slicer** | Filter | Filter | Filter | Filter | Filter |
| **State Slicer** | Filter | Filter | Highlight | Filter | Filter |
| **Line Chart** | - | Highlight | Highlight | Highlight | Filter |
| **Bar Chart** | Highlight | - | Highlight | Highlight | Filter |
| **Map** | Highlight | Highlight | - | Highlight | Filter |

**Filter Direction:** All relationships set to **Single** (one-way filtering from dimension to fact)

---

## Accessibility Features

1. **Alt Text:** All visuals have descriptive alt text
2. **Tab Order:** Logical left-to-right, top-to-bottom
3. **High Contrast:** Theme supports high-contrast mode
4. **Screen Reader:** Semantic titles and labels
5. **Keyboard Navigation:** All slicers keyboard-accessible

---

## Performance Optimization

1. **Visuals per Page:** ≤12 (avoid overload)
2. **Data Points per Visual:** ≤10,000 (use Top N filters)
3. **Import Mode:** All tables imported (no DirectQuery)
4. **Aggregations:** Pre-aggregated in DAX measures
5. **Relationships:** Star schema (no many-to-many)

---

## Mobile Layout (Optional)

**Portrait Mode (768x1024):**

```
┌──────────────────┐
│  Page Title      │
├──────────────────┤
│  KPI Cards       │
│  (2x2 grid)      │
├──────────────────┤
│  Slicers         │
│  (Stacked)       │
├──────────────────┤
│  Line Chart      │
├──────────────────┤
│  Bar Chart       │
│  (Top 5)         │
├──────────────────┤
│  Map             │
└──────────────────┘
```

**Key Changes for Mobile:**
- Stack visuals vertically
- Reduce Top N to 5 items
- Larger touch targets (slicers)
- Simplified matrix (collapse hierarchies)

---

## Print Layout

**For PDF Export:**

1. Set page size to **A4 Landscape** (297x210mm)
2. Margins: 10mm all sides
3. Remove interactive slicers (or show as fixed labels)
4. Add footer: "Malaysia Tourism Dashboard | Source: data.gov.my | Generated: {Today}"
5. Ensure all visuals fit within print boundaries

---

## Versioning & Change Log

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2025-01-08 | Initial layout specification |

---

**Document Owner:** BI Development Team
**Review Frequency:** Quarterly or upon major dashboard updates
