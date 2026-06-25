
#  Assessing Make vs. Buy

```
Exercise ID 1541060
```

##  Assignment 

You have calculated all of the full costs for the Make and Buy options. Now it is time to communicate the results with a Make versus Buy Scenario Planner report. 

**If you have lost any progress, close any open reports and load `3_2_Make_Scenario_Full_Cost_Solution.pbix` from the Exercises folder on the desktop.**

##  Hints 

For all of the visuals, make sure that the `Part_Number` comes from the `Product_Dimension` table because this has a relationship with both the Make and Buy tables. 

The Make vs Buy measure should be equivalent to this: `Make vs Buy = IF(ISBLANK([Make Scenario Full Cost]), BLANK(), IF([Make Scenario Full Cost] &gt;= [Buy Scenario Full Cost], "Buy","Make"))`

The cost avoidance measure should be equivalent to: `Cost Avoidance = ABS([Make Scenario Full Cost] -  [Buy Scenario Full Cost])`

**If you can't find the solution, you can load the workbook `3_3_Make_vs_Buy_Solution.pbix` from the Workbooks folder on the Desktop.**



##  Solution 

No solution was found.


