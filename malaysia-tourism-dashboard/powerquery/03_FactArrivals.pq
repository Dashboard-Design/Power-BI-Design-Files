// ===================================================================
// FACT TABLE - Arrivals
// ===================================================================
// Description: Cleaned and transformed fact table for arrivals data
// Grain: One row per date, country, state combination
// ===================================================================

let
    // Load source data
    Source = 02_SourceData,

    // Remove duplicates (if any)
    RemovedDuplicates = Table.Distinct(Source, {"date", "country", "soe"}),

    // Rename columns to semantic names
    RenamedColumns = Table.RenameColumns(
        RemovedDuplicates,
        {
            {"country", "CountryCode"},
            {"soe", "StateOfEntry"},
            {"arrivals", "TotalArrivals"},
            {"arrivals_male", "MaleArrivals"},
            {"arrivals_female", "FemaleArrivals"},
            {"date", "ArrivalDate"}
        }
    ),

    // Add surrogate keys for dimensional modeling
    AddedDateKey = Table.AddColumn(
        RenamedColumns,
        "DateKey",
        each Number.From([ArrivalDate]),
        Int64.Type
    ),

    // Add Year, Month for easier filtering (redundant with Date dim but useful for performance)
    AddedYearMonth = Table.AddColumn(
        AddedDateKey,
        "Year",
        each Date.Year([ArrivalDate]),
        Int64.Type
    ),

    AddedMonth = Table.AddColumn(
        AddedYearMonth,
        "Month",
        each Date.Month([ArrivalDate]),
        Int64.Type
    ),

    // Filter out records with zero arrivals (optional - uncomment to reduce data size)
    // FilteredZeros = Table.SelectRows(AddedMonth, each [TotalArrivals] > 0),

    // Reorder columns
    ReorderedColumns = Table.SelectColumns(
        AddedMonth,
        {
            "DateKey",
            "ArrivalDate",
            "Year",
            "Month",
            "CountryCode",
            "StateOfEntry",
            "TotalArrivals",
            "MaleArrivals",
            "FemaleArrivals",
            "DataSource"
        }
    ),

    // Set data types explicitly
    SetTypes = Table.TransformColumnTypes(
        ReorderedColumns,
        {
            {"DateKey", Int64.Type},
            {"ArrivalDate", type date},
            {"Year", Int64.Type},
            {"Month", Int64.Type},
            {"CountryCode", type text},
            {"StateOfEntry", type text},
            {"TotalArrivals", Int64.Type},
            {"MaleArrivals", Int64.Type},
            {"FemaleArrivals", Int64.Type},
            {"DataSource", type text}
        }
    )
in
    SetTypes
