
#  Adding row-level security

```
Exercise ID 1554078
```

##  Assignment 

The supply chain team is impressed by your scenario planner tool so far. There have been requests for enhancements: 

- They want to see the lowest-cost supplier name prominently on the page.
- They only want to see results relevant to their own project.

**If you have lost any progress, close any open reports and load `2_3_Scenario_Planner_Solution.pbix` from the Exercises folder on the desktop.**

##  Hints 

To create a security filter, click the **Modeling** pane and select **Manage Roles**. 

- Click **Create** role. 
- Name the role. 
- Click on the `Product_Dimension` table.
- In the **Table filter DAX expression**, write your DAX filter. 
- For the "Project Siliode Team Member" role, the filter should be `"[Project] = "Siliode"`.
- For the "Project Kerfuffle Team Member" role, the filter should be `"[Project] = "Kerfuffle"`.

The final question asks about all of the part numbers associated with "Siliode." You need to click through all of the available part numbers to ensure you are giving the correct answer.

**If you can't find the solution, you can load the workbook `2_4_RLS_Solution.pbix` from the Workbooks folder on the Desktop.**



##  Solution 

No solution was found.


