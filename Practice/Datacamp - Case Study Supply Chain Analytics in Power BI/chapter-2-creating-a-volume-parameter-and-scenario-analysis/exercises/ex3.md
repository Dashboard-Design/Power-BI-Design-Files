
#  Analyzing volumes outside the quoted range

```
Exercise ID 1541058
```

##  Assignment 

Now that you have created a volume parameter and responsive measures, it is time to build visualizations in a scenario planner report. The scenario planner report will help the Supply Chain team analyze the lowest-cost supplier choice over a range of potential production volumes.

**If you have lost any progress, close any open reports and load `2_2_NRE_Solution.pbix` from the Exercises folder on the desktop.**

##  Hints 

<li><p>Your full cost measure should be: 
`Scenario Full Cost (All) = MINX(FILTER(Quotes, Quotes[Volume] &lt;= MIN('Scenario Volumes (All)'[Scenario Volume])), MIN('Scenario Volumes (All)'[Scenario Volume]) * Quotes[Unit_Cost] + Quotes[Non_recurring_expenses])`</p></li>
- The full cost is specific to the combination of supplier, part number, and volume quoted, so make sure all of those are represented in your visualization.

**If you can't find the solution, you can load the workbook `2_3_Scenario_Planner_Solution.pbix` from the Workbooks folder on the Desktop.**



##  Solution 

No solution was found.


