
#  Cost of Quality

```
Exercise ID 1558809
```

##  Assignment 

You presented your Make versus Buy analysis tool to the Project Kerfuffle team. They were impressed, but they had some feedback and ideas. 

**Quality team said:** "We've had consistent quality issues with Widgetmakers and Ringo Nova on other projects. The cost impact is not negligible!"

They've asked us to update the cost model with these factors. 

**If you have lost any progress, close any open reports and load `3_3_Make_vs_Buy_Solution.pbix` from the Exercises folder on the desktop.**

##  Hints 

Your new measure should be: 

`Buy Scenario Full Cost = MINX(FILTER(Quotes, Quotes[Volume] &lt;= 'Scenario Volume'[Scenario Volume Value]), ([Scenario Volume Value] * Quotes[Unit_Cost] / Quotes[Yield Rate]) + Quotes[Non_recurring_expenses])`

**If you can't find the solution, you can load the workbook `3_4_Scrap_Cost_Solution.pbix` from the Workbooks folder on the Desktop.**



##  Solution 

No solution was found.


