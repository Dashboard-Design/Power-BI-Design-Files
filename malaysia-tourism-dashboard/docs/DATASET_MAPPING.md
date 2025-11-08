# Dataset Mapping to 5 Dimensions

**Project:** Malaysia Tourism Dashboard
**Dataset:** Monthly Arrivals by State of Entry, Nationality & Sex
**Source:** Immigration Department of Malaysia (data.gov.my)

---

## Overview

This document details how the selected dataset maps to the five required analytical dimensions:

1. **People**
2. **Product/Services**
3. **Time/Date**
4. **Place**
5. **Behaviour**

---

## 1. People Dimension

### Implementation

The **People** dimension represents the tourists/visitors arriving in Malaysia.

| Aspect | Implementation | Details |
|--------|----------------|---------|
| **Primary Metric** | `arrivals` (total count) | Total number of people entering Malaysia |
| **Supporting Metrics** | `arrivals_male`, `arrivals_female` | Gender breakdown of arrivals |
| **Granularity** | Individual arrivals aggregated by month/country/state | Monthly aggregation of immigration records |
| **DAX Measures** | `Total Arrivals`, `Male Arrivals`, `Female Arrivals` | SUM of respective columns |
| **Distinct Count** | `Distinct Countries` | Number of unique nationalities (proxy for diversity) |

### Example Analysis Questions

- How many tourists arrived in Malaysia in 2024?
- What is the gender distribution of arrivals?
- Which nationality group has the most arrivals?

### Data Quality

- **Completeness:** 100% - All records have arrival counts
- **Accuracy:** High - Sourced from official immigration system (MyIMMs)
- **Timeliness:** Monthly updates

---

## 2. Product/Services Dimension

### Implementation

The **Product/Services** dimension represents the tourism market segments, using **nationality** as a proxy for tourism services/products consumed.

| Aspect | Implementation | Details |
|--------|----------------|---------|
| **Primary Field** | `country` (ISO-3 code) | Nationality of arrivals |
| **Enrichment** | `DimCountry` table | Country names, regions, market segments |
| **Categorization** | `Region` | Geographic grouping (ASEAN, East Asia, Middle East, etc.) |
| **Segmentation** | `MarketSegment` | Business classification (Neighboring, Major Asian, Western, etc.) |
| **Granularity** | ~200 unique countries | Comprehensive nationality coverage |

### Mapping Rationale

While the dataset doesn't explicitly contain "products" or "services," we use **nationality as a service proxy** because:

1. **Different nationalities consume different tourism products:**
   - ASEAN neighbors → Short-term business/leisure travel
   - Middle East → Halal tourism, shopping
   - Western markets → Long-haul tourism, cultural experiences
   - East Asian → Group tours, shopping

2. **Market segmentation enables product-level analysis:**
   - Target marketing campaigns
   - Service customization
   - Revenue optimization

### Example Analysis Questions

- Which market segment (ASEAN/Middle East/Western) drives the most arrivals?
- How do neighboring countries (Singapore, Thailand, Indonesia) compare?
- What is the market concentration (top 10 countries vs. long tail)?

### Data Quality

- **Country Codes:** ISO-3 standard (e.g., SGP, CHN, USA)
- **Unspecified:** ~0.01% coded as "XXX"
- **Mapping Accuracy:** 95%+ mapped to full names in DimCountry

---

## 3. Time/Date Dimension

### Implementation

The **Time/Date** dimension enables temporal analysis and trend identification.

| Aspect | Implementation | Details |
|--------|----------------|---------|
| **Primary Field** | `date` | Month start date (YYYY-MM-01 format) |
| **Granularity** | Monthly | Finest available grain (no daily data) |
| **Date Range** | 2020-01-01 to 2024-10-01 | 58 months of data |
| **Date Table** | `DimDate` | Full calendar with attributes |
| **Attributes** | Year, Quarter, Month, Week, YearMonth, Season | Comprehensive time attributes |
| **Time Intelligence** | YoY%, MoM%, YTD, MTD, Rolling 12M | Standard time comparisons |

### Date Dimension Structure

```
DimDate
├── Date (PK)
├── Year (2020, 2021, ..., 2025)
├── Quarter (1, 2, 3, 4)
├── QuarterName (Q1 2020, Q2 2020, ...)
├── Month (1-12)
├── MonthName (January, February, ...)
├── YearMonth (202001, 202002, ...)
├── YearMonthName (Jan 2020, Feb 2020, ...)
├── WeekOfYear (1-53)
├── Season (Northeast Monsoon, Southwest Monsoon, Inter-Monsoon)
└── Fiscal Year (same as calendar year for Malaysia)
```

### Example Analysis Questions

- What is the year-over-year growth in arrivals?
- Which months are peak season vs. off-peak?
- How did COVID-19 impact arrivals in 2020-2021?
- What are the rolling 12-month trends?

### Data Quality

- **Continuity:** Monthly series with no gaps
- **Format:** Standardized YYYY-MM-DD
- **Coverage:** Historical (2020) through recent (2024-10)

---

## 4. Place Dimension

### Implementation

The **Place** dimension represents geographical distribution across Malaysia.

| Aspect | Implementation | Details |
|--------|----------------|---------|
| **Primary Field** | `soe` (State of Entry) | Malaysian state name |
| **States Covered** | 16 states/territories | All Malaysian administrative regions |
| **Enrichment** | `DimState` table | State codes, regions, entry types |
| **Regional Grouping** | `Region` | Northern, Central, Southern, East Coast, East Malaysia |
| **Entry Classification** | `EntryPointType` | Airport, Land Border, Sea Port |
| **Population Context** | `PopulationTier` | High/Medium/Low (for per-capita analysis) |

### Malaysian States

| State | State Code | Region | Entry Point Type |
|-------|-----------|--------|------------------|
| Johor | JHR | Southern | International Airport + Land Border |
| Kedah | KDH | Northern | Land Border |
| Kelantan | KTN | East Coast | Land Border |
| Melaka | MLK | Central | Mixed |
| Negeri Sembilan | NSN | Central | Mixed |
| Pahang | PHG | East Coast | Land Border |
| Perak | PRK | Northern | Mixed |
| Perlis | PLS | Northern | Land Border |
| Pulau Pinang | PNG | Northern | International Airport |
| Sabah | SBH | East Malaysia | International Airport + Sea Port |
| Sarawak | SWK | East Malaysia | International Airport + Land Border |
| Selangor | SGR | Central | Major Airport (KLIA) |
| Terengganu | TRG | East Coast | Mixed |
| Kuala Lumpur | KUL | Central | Major Airport (KLIA) |
| Labuan | LBN | East Malaysia | Sea Port |
| Putrajaya | PJY | Central | Airport |

### Important Note

⚠️ **State of Entry ≠ Final Destination**

The `soe` field represents the **entry point** where the tourist first entered Malaysia, not necessarily their final destination. For example:

- Tourist arrives at KLIA (Selangor) but travels to Penang → Recorded as Selangor
- Tourist crosses land border at Johor but visits KL → Recorded as Johor

This is a **data limitation** but still provides valuable insights on:
- Entry point capacity and traffic
- Border/airport utilization
- Regional connectivity

### Example Analysis Questions

- Which states have the highest arrival volumes?
- How do airport entry points compare to land borders?
- What is the distribution between West Malaysia and East Malaysia?
- Which regions are most popular entry points by nationality?

### Data Quality

- **Coverage:** All 16 states/territories represented
- **Consistency:** Standardized state names (may need cleaning for "W.P." variations)
- **Granularity:** State-level (no district/city-level data)

---

## 5. Behaviour Dimension

### Implementation

The **Behaviour** dimension is derived from patterns and classifications since explicit behavioral data isn't in the raw dataset.

| Aspect | Implementation | Details |
|--------|----------------|---------|
| **Volume Behavior** | `Arrival Volume Category` (calculated column) | Classification: Very Low, Low, Medium, High, Very High, Extreme |
| **Gender Patterns** | `Gender Dominance` (calculated column) | Male/Female Dominated or Balanced |
| **Temporal Behavior** | Seasonality measures | Peak vs. off-peak identification |
| **Frequency Patterns** | Rolling averages, MoM trends | Consistency vs. volatility |
| **Market Concentration** | Top 10 share vs. long tail | Concentrated vs. distributed |

### Behavior Classifications

#### 1. Arrival Volume Category

Classifies each record into behavioral segments based on traffic volume:

```dax
Arrival Volume Category =
SWITCH (
    TRUE (),
    FactArrivals[TotalArrivals] = 0, "No Arrivals",
    FactArrivals[TotalArrivals] <= 10, "Very Low (1-10)",
    FactArrivals[TotalArrivals] <= 100, "Low (11-100)",
    FactArrivals[TotalArrivals] <= 1000, "Medium (101-1K)",
    FactArrivals[TotalArrivals] <= 10000, "High (1K-10K)",
    FactArrivals[TotalArrivals] <= 50000, "Very High (10K-50K)",
    "Extreme (50K+)"
)
```

**Behavioral Insight:**
- "No Arrivals" → Rare routes or exceptional circumstances
- "Very Low/Low" → Niche markets, emerging destinations
- "Medium" → Stable secondary markets
- "High/Very High" → Core markets, major traffic
- "Extreme" → Dominant routes (e.g., Singapore → Johor)

#### 2. Gender Dominance

Identifies gender skew patterns:

```dax
Gender Dominance =
VAR MalePct = DIVIDE(MaleArrivals, TotalArrivals, 0)
RETURN
SWITCH (
    TRUE (),
    MalePct >= 0.6, "Male Dominated (60%+)",
    MalePct >= 0.55, "Male Majority (55-60%)",
    MalePct >= 0.45, "Balanced (45-55%)",
    MalePct >= 0.4, "Female Majority (55-60%)",
    "Female Dominated (60%+)"
)
```

**Behavioral Insight:**
- Male-dominated → Business travel, labor migration
- Female-dominated → Education, family visits
- Balanced → Leisure tourism, family travel

#### 3. Seasonality Behavior

Derived from monsoon seasons and monthly patterns:

```dax
Season =
SWITCH (
    TRUE (),
    DimDate[Month] IN { 11, 12, 1, 2, 3 }, "Northeast Monsoon",
    DimDate[Month] IN { 5, 6, 7, 8, 9 }, "Southwest Monsoon",
    "Inter-Monsoon"
)
```

**Behavioral Insight:**
- Seasonality Factor measure identifies peak/off-peak months
- Weather-driven travel patterns
- Holiday season effects

#### 4. Frequency & Consistency

Measures that reveal behavioral patterns:

| Measure | Behavior Revealed |
|---------|-------------------|
| `Rolling 3M Avg` | Smooths volatility, shows underlying trends |
| `MoM %` | Month-to-month consistency vs. spikes |
| `Arrival Intensity Index` | Above/below average traffic identification |

#### 5. Market Concentration

Reveals competitive dynamics:

| Measure | Behavior Revealed |
|---------|-------------------|
| `Top 10 Countries Share` | Market concentration |
| `Share of Total %` | Individual country/state importance |
| `Country Rank` / `State Rank` | Relative positioning |

### Example Analysis Questions

- Which arrival volume categories are most common?
- Do certain nationalities show gender imbalance (business vs. leisure)?
- How does seasonality affect different market segments?
- Are arrivals concentrated in a few routes or distributed evenly?
- Which states show the most volatile arrival patterns?

### Behavior Proxy Justification

Since the dataset doesn't include explicit behavioral fields (e.g., "purpose of visit", "length of stay"), we derive behavior through:

1. **Volume patterns** → Traffic intensity, route importance
2. **Gender distribution** → Trip purpose proxy
3. **Temporal patterns** → Seasonal vs. year-round, peak timing
4. **Concentration metrics** → Market maturity, diversity
5. **Trend stability** → Predictable vs. volatile demand

This approach is standard in tourism analytics when detailed visitor surveys aren't available.

---

## Summary Mapping Table

| Dimension | Primary Field(s) | Enrichment | Grain | Analytical Value |
|-----------|------------------|------------|-------|------------------|
| **People** | `arrivals`, `arrivals_male`, `arrivals_female` | None needed | Monthly aggregated count | Volume, demographics |
| **Product/Services** | `country` | `DimCountry` (regions, segments) | ~200 nationalities | Market segmentation |
| **Time/Date** | `date` | `DimDate` (calendar attributes) | Monthly (58 periods) | Trends, seasonality |
| **Place** | `soe` | `DimState` (regions, entry types) | 16 states | Geographic distribution |
| **Behaviour** | Derived from above | Calculated columns + measures | Multi-faceted | Patterns, classification |

---

## Data Lineage

```
Source: Immigration Dept (MyIMMs)
    ↓
data.gov.my CSV (arrivals_soe.csv)
    ↓
Power Query M Transformation
    ├── FactArrivals (92K rows)
    ├── DimDate (2,191 days)
    ├── DimCountry (200 countries)
    └── DimState (16 states)
    ↓
DAX Calculations
    ├── 20+ Measures
    └── 5 Calculated Columns
    ↓
Power BI Report Visuals
```

---

## Coverage Assessment

| Dimension | Coverage | Gaps | Mitigation |
|-----------|----------|------|------------|
| People | ✅ Excellent | No age/demographics | Gender provides partial segmentation |
| Product/Services | ✅ Good | Proxy via nationality | Use region/segment groupings |
| Time/Date | ✅ Excellent | Monthly grain only | Sufficient for strategic analysis |
| Place | ⚠️ Good | Entry ≠ destination | Still valuable for entry point analysis |
| Behaviour | ⚠️ Moderate | Inferred not explicit | Use multiple proxies for triangulation |

**Overall Assessment:** Dataset provides **strong coverage** across all 5 dimensions with some limitations on granularity and behavioral explicitness. These limitations are acceptable given data availability constraints and can be addressed through enrichment with additional datasets in future iterations.

---

## Recommended Enhancements

To strengthen each dimension:

1. **People:** Enrich with age/income demographics from DOSM surveys
2. **Product/Services:** Add expenditure data to analyze actual tourism products consumed
3. **Time/Date:** Request daily-grain data from Immigration Dept (if available)
4. **Place:** Cross-reference with hotel occupancy data to identify final destinations
5. **Behaviour:** Integrate visitor satisfaction surveys, length of stay data

---

**Document Version:** 1.0
**Last Updated:** 2025-01-08
**Maintained By:** Project Documentation Team
