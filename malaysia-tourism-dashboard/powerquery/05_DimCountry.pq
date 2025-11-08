// ===================================================================
// DIMENSION TABLE - Country (Nationality)
// ===================================================================
// Description: Country/Nationality dimension
// Grain: One row per unique country code
// Note: Uses ISO-3 country codes; 'XXX' = unspecified nationality
// ===================================================================

let
    // Get distinct countries from fact table
    FactData = 03_FactArrivals,
    DistinctCountries = Table.Distinct(Table.SelectColumns(FactData, {"CountryCode"})),

    // Add country name mapping (ISO-3 to full name)
    // Note: This is a comprehensive mapping of common ISO-3 codes
    AddedCountryName = Table.AddColumn(
        DistinctCountries,
        "CountryName",
        each
            if [CountryCode] = "XXX" then "Unspecified"
            else if [CountryCode] = "SGP" then "Singapore"
            else if [CountryCode] = "IDN" then "Indonesia"
            else if [CountryCode] = "CHN" then "China"
            else if [CountryCode] = "IND" then "India"
            else if [CountryCode] = "THA" then "Thailand"
            else if [CountryCode] = "PHL" then "Philippines"
            else if [CountryCode] = "VNM" then "Vietnam"
            else if [CountryCode] = "JPN" then "Japan"
            else if [CountryCode] = "KOR" then "South Korea"
            else if [CountryCode] = "AUS" then "Australia"
            else if [CountryCode] = "GBR" then "United Kingdom"
            else if [CountryCode] = "USA" then "United States"
            else if [CountryCode] = "BRN" then "Brunei"
            else if [CountryCode] = "BGD" then "Bangladesh"
            else if [CountryCode] = "PAK" then "Pakistan"
            else if [CountryCode] = "NZL" then "New Zealand"
            else if [CountryCode] = "MMR" then "Myanmar"
            else if [CountryCode] = "KHM" then "Cambodia"
            else if [CountryCode] = "LAO" then "Laos"
            else if [CountryCode] = "SAU" then "Saudi Arabia"
            else if [CountryCode] = "ARE" then "United Arab Emirates"
            else if [CountryCode] = "DEU" then "Germany"
            else if [CountryCode] = "FRA" then "France"
            else if [CountryCode] = "ITA" then "Italy"
            else if [CountryCode] = "ESP" then "Spain"
            else if [CountryCode] = "NLD" then "Netherlands"
            else if [CountryCode] = "CAN" then "Canada"
            else if [CountryCode] = "RUS" then "Russia"
            else if [CountryCode] = "TUR" then "Turkey"
            else if [CountryCode] = "IRN" then "Iran"
            else if [CountryCode] = "EGY" then "Egypt"
            else if [CountryCode] = "ZAF" then "South Africa"
            else if [CountryCode] = "BRA" then "Brazil"
            else if [CountryCode] = "MEX" then "Mexico"
            else [CountryCode],  // Default to code if not mapped
        type text
    ),

    // Add regional grouping for analysis
    AddedRegion = Table.AddColumn(
        AddedCountryName,
        "Region",
        each
            if List.Contains({"SGP", "IDN", "THA", "PHL", "VNM", "BRN", "MMR", "KHM", "LAO"}, [CountryCode]) then "ASEAN"
            else if List.Contains({"CHN", "JPN", "KOR", "TWN", "HKG", "MAC"}, [CountryCode]) then "East Asia"
            else if List.Contains({"IND", "BGD", "PAK", "LKA", "NPL"}, [CountryCode]) then "South Asia"
            else if List.Contains({"AUS", "NZL", "FJI", "PNG"}, [CountryCode]) then "Oceania"
            else if List.Contains({"SAU", "ARE", "QAT", "KWT", "BHR", "OMN", "IRN", "IRQ", "JOR", "LBN", "TUR", "EGY"}, [CountryCode]) then "Middle East"
            else if List.Contains({"GBR", "DEU", "FRA", "ITA", "ESP", "NLD", "BEL", "CHE", "AUT", "SWE", "NOR", "DNK", "FIN", "IRL", "PRT", "POL", "RUS"}, [CountryCode]) then "Europe"
            else if List.Contains({"USA", "CAN", "MEX"}, [CountryCode]) then "North America"
            else if List.Contains({"BRA", "ARG", "CHL", "COL", "PER", "VEN"}, [CountryCode]) then "South America"
            else if List.Contains({"ZAF", "NGA", "KEN", "GHA", "ETH", "TZA", "UGA", "DZA", "MAR", "TUN"}, [CountryCode]) then "Africa"
            else if [CountryCode] = "XXX" then "Unspecified"
            else "Other",
        type text
    ),

    // Add market segment classification
    AddedMarketSegment = Table.AddColumn(
        AddedRegion,
        "MarketSegment",
        each
            if List.Contains({"SGP", "IDN", "THA", "BRN"}, [CountryCode]) then "Neighboring Countries"
            else if List.Contains({"CHN", "IND", "JPN", "KOR"}, [CountryCode]) then "Major Asian Markets"
            else if List.Contains({"AUS", "GBR", "USA", "CAN"}, [CountryCode]) then "Western Markets"
            else if List.Contains({"SAU", "ARE", "QAT", "KWT"}, [CountryCode]) then "Middle East Markets"
            else "Other Markets",
        type text
    ),

    // Sort by country code
    SortedRows = Table.Sort(AddedMarketSegment, {{"CountryCode", Order.Ascending}})
in
    SortedRows
