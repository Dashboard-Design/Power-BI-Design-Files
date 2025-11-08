// ===================================================================
// DIMENSION TABLE - Date
// ===================================================================
// Description: Date dimension table with calendar attributes
// Grain: One row per day
// Range: Covers full extent of fact data plus buffer
// ===================================================================

let
    // Get min and max dates from fact table
    FactData = 03_FactArrivals,
    MinDate = List.Min(FactData[ArrivalDate]),
    MaxDate = List.Max(FactData[ArrivalDate]),

    // Extend range to cover full years
    StartDate = Date.StartOfYear(MinDate),
    EndDate = Date.EndOfYear(Date.AddYears(MaxDate, 1)),

    // Generate date list
    DateList = List.Dates(StartDate, Duration.Days(EndDate - StartDate) + 1, #duration(1,0,0,0)),

    // Convert to table
    DateTable = Table.FromList(DateList, Splitter.SplitByNothing(), {"Date"}),

    // Change type
    ChangedType = Table.TransformColumnTypes(DateTable, {{"Date", type date}}),

    // Add DateKey (integer representation)
    AddedDateKey = Table.AddColumn(
        ChangedType,
        "DateKey",
        each Number.From([Date]),
        Int64.Type
    ),

    // Add Year
    AddedYear = Table.AddColumn(
        AddedDateKey,
        "Year",
        each Date.Year([Date]),
        Int64.Type
    ),

    // Add Quarter
    AddedQuarter = Table.AddColumn(
        AddedYear,
        "Quarter",
        each Date.QuarterOfYear([Date]),
        Int64.Type
    ),

    AddedQuarterName = Table.AddColumn(
        AddedQuarter,
        "QuarterName",
        each "Q" & Text.From([Quarter]) & " " & Text.From([Year]),
        type text
    ),

    // Add Month
    AddedMonth = Table.AddColumn(
        AddedQuarterName,
        "Month",
        each Date.Month([Date]),
        Int64.Type
    ),

    AddedMonthName = Table.AddColumn(
        AddedMonth,
        "MonthName",
        each Date.ToText([Date], "MMMM"),
        type text
    ),

    AddedMonthShort = Table.AddColumn(
        AddedMonthName,
        "MonthShort",
        each Date.ToText([Date], "MMM"),
        type text
    ),

    // Add YearMonth
    AddedYearMonth = Table.AddColumn(
        AddedMonthShort,
        "YearMonth",
        each [Year] * 100 + [Month],
        Int64.Type
    ),

    AddedYearMonthName = Table.AddColumn(
        AddedYearMonth,
        "YearMonthName",
        each Date.ToText([Date], "MMM yyyy"),
        type text
    ),

    // Add Week
    AddedWeek = Table.AddColumn(
        AddedYearMonthName,
        "WeekOfYear",
        each Date.WeekOfYear([Date]),
        Int64.Type
    ),

    // Add Day attributes
    AddedDayOfMonth = Table.AddColumn(
        AddedWeek,
        "DayOfMonth",
        each Date.Day([Date]),
        Int64.Type
    ),

    AddedDayOfWeek = Table.AddColumn(
        AddedDayOfMonth,
        "DayOfWeek",
        each Date.DayOfWeek([Date], Day.Monday) + 1,
        Int64.Type
    ),

    AddedDayName = Table.AddColumn(
        AddedDayOfWeek,
        "DayName",
        each Date.ToText([Date], "dddd"),
        type text
    ),

    AddedDayShort = Table.AddColumn(
        AddedDayName,
        "DayShort",
        each Date.ToText([Date], "ddd"),
        type text
    ),

    // Add Fiscal Year (Malaysia fiscal year = calendar year)
    AddedFiscalYear = Table.AddColumn(
        AddedDayShort,
        "FiscalYear",
        each Date.Year([Date]),
        Int64.Type
    ),

    // Add relative date flags
    AddedIsToday = Table.AddColumn(
        AddedFiscalYear,
        "IsToday",
        each [Date] = Date.From(DateTime.LocalNow()),
        type logical
    ),

    AddedIsCurrentMonth = Table.AddColumn(
        AddedIsToday,
        "IsCurrentMonth",
        each Date.Year([Date]) = Date.Year(DateTime.LocalNow()) and Date.Month([Date]) = Date.Month(DateTime.LocalNow()),
        type logical
    ),

    AddedIsCurrentYear = Table.AddColumn(
        AddedIsCurrentMonth,
        "IsCurrentYear",
        each Date.Year([Date]) = Date.Year(DateTime.LocalNow()),
        type logical
    ),

    // Reorder columns
    ReorderedColumns = Table.SelectColumns(
        AddedIsCurrentYear,
        {
            "DateKey",
            "Date",
            "Year",
            "Quarter",
            "QuarterName",
            "Month",
            "MonthName",
            "MonthShort",
            "YearMonth",
            "YearMonthName",
            "WeekOfYear",
            "DayOfMonth",
            "DayOfWeek",
            "DayName",
            "DayShort",
            "FiscalYear",
            "IsToday",
            "IsCurrentMonth",
            "IsCurrentYear"
        }
    )
in
    ReorderedColumns
