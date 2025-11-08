// ===================================================================
// PARAMETERS
// ===================================================================
// Description: Configuration parameters for the Power BI dataset
// Usage: Change these values to point to different data sources
// ===================================================================

let
    // Data source parameters
    DataSourceURL = "https://storage.data.gov.my/demography/arrivals_soe.csv" meta [IsParameterQuery=true, Type="Text", IsParameterQueryRequired=true],

    // Local file path parameter (for offline development)
    LocalFilePath = "/home/user/Power-BI-Design-Files/malaysia-tourism-dashboard/data/arrivals_soe.csv" meta [IsParameterQuery=true, Type="Text", IsParameterQueryRequired=false],

    // Data source mode: "Web" or "Local"
    DataSourceMode = "Local" meta [IsParameterQuery=true, Type="Text", IsParameterQueryRequired=true],

    // Date range parameters
    MinDateOverride = #date(2020, 1, 1) meta [IsParameterQuery=true, Type="Date"],
    MaxDateOverride = #date(2025, 12, 31) meta [IsParameterQuery=true, Type="Date"]
in
    [
        DataSourceURL = DataSourceURL,
        LocalFilePath = LocalFilePath,
        DataSourceMode = DataSourceMode,
        MinDateOverride = MinDateOverride,
        MaxDateOverride = MaxDateOverride
    ]
