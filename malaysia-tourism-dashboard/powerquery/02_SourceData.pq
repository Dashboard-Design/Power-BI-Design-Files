// ===================================================================
// SOURCE DATA - Tourism Arrivals
// ===================================================================
// Description: Imports raw arrivals data from web or local source
// Source: Immigration Department of Malaysia (data.gov.my)
// License: CC BY 4.0
// ===================================================================

let
    // Load parameters
    Params = 01_Parameters,

    // Select source based on mode parameter
    Source = if Params[DataSourceMode] = "Web" then
        Csv.Document(
            Web.Contents(Params[DataSourceURL]),
            [Delimiter=",", Columns=6, Encoding=65001, QuoteStyle=QuoteStyle.None]
        )
    else
        Csv.Document(
            File.Contents(Params[LocalFilePath]),
            [Delimiter=",", Columns=6, Encoding=65001, QuoteStyle=QuoteStyle.None]
        ),

    // Promote headers
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),

    // Data type conversion
    ChangedType = Table.TransformColumnTypes(
        PromotedHeaders,
        {
            {"date", type date},
            {"country", type text},
            {"soe", type text},
            {"arrivals", Int64.Type},
            {"arrivals_male", Int64.Type},
            {"arrivals_female", Int64.Type}
        }
    ),

    // Trim and clean text columns
    TrimmedText = Table.TransformColumns(
        ChangedType,
        {
            {"country", Text.Trim, type text},
            {"soe", Text.Trim, type text}
        }
    ),

    // Remove any null dates or invalid records
    RemovedNulls = Table.SelectRows(TrimmedText, each [date] <> null and [arrivals] <> null),

    // Add metadata
    AddedMetadata = Table.AddColumn(
        RemovedNulls,
        "DataSource",
        each "Immigration Department Malaysia - MyIMMs",
        type text
    )
in
    AddedMetadata
