// ===================================================================
// DIMENSION TABLE - State (State of Entry)
// ===================================================================
// Description: Malaysian states dimension table
// Grain: One row per state
// ===================================================================

let
    // Get distinct states from fact table
    FactData = 03_FactArrivals,
    DistinctStates = Table.Distinct(Table.SelectColumns(FactData, {"StateOfEntry"})),

    // Add state metadata
    AddedStateCode = Table.AddColumn(
        DistinctStates,
        "StateCode",
        each
            if [StateOfEntry] = "Johor" then "JHR"
            else if [StateOfEntry] = "Kedah" then "KDH"
            else if [StateOfEntry] = "Kelantan" then "KTN"
            else if [StateOfEntry] = "Melaka" then "MLK"
            else if [StateOfEntry] = "Negeri Sembilan" then "NSN"
            else if [StateOfEntry] = "Pahang" then "PHG"
            else if [StateOfEntry] = "Perak" then "PRK"
            else if [StateOfEntry] = "Perlis" then "PLS"
            else if [StateOfEntry] = "Pulau Pinang" then "PNG"
            else if [StateOfEntry] = "Sabah" then "SBH"
            else if [StateOfEntry] = "Sarawak" then "SWK"
            else if [StateOfEntry] = "Selangor" then "SGR"
            else if [StateOfEntry] = "Terengganu" then "TRG"
            else if Text.Contains([StateOfEntry], "Kuala Lumpur") or Text.Contains([StateOfEntry], "W.P. Kuala Lumpur") then "KUL"
            else if Text.Contains([StateOfEntry], "Labuan") or Text.Contains([StateOfEntry], "W.P. Labuan") then "LBN"
            else if Text.Contains([StateOfEntry], "Putrajaya") or Text.Contains([StateOfEntry], "W.P. Putrajaya") then "PJY"
            else "OTH",
        type text
    ),

    // Standardize state names
    AddedStateName = Table.AddColumn(
        AddedStateCode,
        "StateName",
        each
            if Text.Contains([StateOfEntry], "Kuala Lumpur") or [StateOfEntry] = "W.P. Kuala Lumpur" then "Kuala Lumpur"
            else if Text.Contains([StateOfEntry], "Labuan") or [StateOfEntry] = "W.P. Labuan" then "Labuan"
            else if Text.Contains([StateOfEntry], "Putrajaya") or [StateOfEntry] = "W.P. Putrajaya" then "Putrajaya"
            else [StateOfEntry],
        type text
    ),

    // Add region grouping
    AddedRegion = Table.AddColumn(
        AddedStateName,
        "Region",
        each
            if List.Contains({"Perlis", "Kedah", "Pulau Pinang", "Perak"}, [StateName]) then "Northern Region"
            else if List.Contains({"Kelantan", "Terengganu", "Pahang"}, [StateName]) then "East Coast"
            else if List.Contains({"Selangor", "Kuala Lumpur", "Putrajaya", "Negeri Sembilan", "Melaka"}, [StateName]) then "Central Region"
            else if List.Contains({"Johor"}, [StateName]) then "Southern Region"
            else if List.Contains({"Sabah", "Sarawak", "Labuan"}, [StateName]) then "East Malaysia"
            else "Other",
        type text
    ),

    // Add entry point classification
    AddedEntryType = Table.AddColumn(
        AddedRegion,
        "EntryPointType",
        each
            if List.Contains({"Selangor", "Kuala Lumpur"}, [StateName]) then "Major Airport (KLIA)"
            else if List.Contains({"Pulau Pinang", "Johor", "Sabah", "Sarawak"}, [StateName]) then "International Airport"
            else if List.Contains({"Perlis", "Kedah", "Kelantan", "Perak", "Pahang"}, [StateName]) then "Land Border"
            else if List.Contains({"Labuan"}, [StateName]) then "Sea Port"
            else "Mixed Entry Points",
        type text
    ),

    // Add population tier (for context)
    AddedPopulationTier = Table.AddColumn(
        AddedEntryType,
        "PopulationTier",
        each
            if List.Contains({"Selangor", "Johor", "Sabah", "Sarawak"}, [StateName]) then "High"
            else if List.Contains({"Perak", "Kedah", "Pulau Pinang", "Pahang", "Kelantan"}, [StateName]) then "Medium"
            else "Low",
        type text
    ),

    // Sort by state name
    SortedRows = Table.Sort(AddedPopulationTier, {{"StateName", Order.Ascending}})
in
    SortedRows
