let
    Token      = // add your token here
    SyncUrl    = "https://api.todoist.com/sync/v9/sync",

    FormRecord = [
        sync_token     = "*",
        resource_types = "[""projects""]"
    ],
    FormText   = Uri.BuildQueryString(FormRecord),
    FormBinary = Text.ToBinary(FormText),
    Raw        = Web.Contents(
        SyncUrl,
        [
            Headers = [
                Authorization  = "Bearer " & Token,
                #"Content-Type" = "application/x-www-form-urlencoded"
            ],
            Content = FormBinary
        ]
    ),
    Json       = Json.Document(Raw),
    projects = Json[projects],
    #"Converted to Table" = Table.FromList(projects, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Expanded Column1" = Table.ExpandRecordColumn(#"Converted to Table", "Column1", {"id", "is_archived", "is_deleted", "is_favorite", "name", "role", "updated_at", "view_style"}, {"id", "is_archived", "is_deleted", "is_favorite", "name", "role", "updated_at", "view_style"})
in
    #"Expanded Column1"
