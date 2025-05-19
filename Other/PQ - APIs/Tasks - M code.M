let
    
    Token = // add your token here
    BaseUrl = "https://api.todoist.com/rest/v2/tasks",
    ProjectIDs = {
        2287468394,
        2353996410,
        2353996636,
        2354042816,
        2354042859,
        2354042892
    },

    // Function: for a single project, fetch ALL pages of tasks
    FetchAllTasksForProject = (projId as number) as list =>
        let
            // inner recursive fetcher
            FetchPage = (offset as number) as list =>
                let
                    // build URL with project_id, limit=100, offset
                    Url = BaseUrl
                        & "?project_id=" & Text.From(projId)
                        & "&limit=100"
                        & "&offset=" & Text.From(offset),

                    // call the API
                    Raw = Web.Contents(
                        Url,
                        [
                            Headers = [ Authorization = "Bearer " & Token ]
                        ]
                    ),

                    // parse JSON array of tasks
                    Page = Json.Document(Raw),

                    // if we got a full page (100), fetch next
                    Next =
                        if List.Count(Page) = 100
                        then @FetchPage(offset + 100)
                        else {}
                in
                    // combine current page + next pages
                    List.Combine({ Page, Next })
        in
            // start at offset = 0
            FetchPage(0),

    TablesPerProject = List.Transform(
        ProjectIDs,
        each Table.FromRecords( FetchAllTasksForProject(_) )
    ),
    #"Converted to Table" = Table.FromList(TablesPerProject, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Expanded Column1" = Table.ExpandTableColumn(#"Converted to Table", "Column1", {"id", "assigner_id", "assignee_id", "project_id", "section_id", "parent_id", "order", "content", "description", "is_completed", "labels", "priority", "comment_count", "creator_id", "created_at", "due", "url", "duration", "deadline"}, {"id", "assigner_id", "assignee_id", "project_id", "section_id", "parent_id", "order", "content", "description", "is_completed", "labels", "priority", "comment_count", "creator_id", "created_at", "due", "url", "duration", "deadline"})
in
    #"Expanded Column1"
