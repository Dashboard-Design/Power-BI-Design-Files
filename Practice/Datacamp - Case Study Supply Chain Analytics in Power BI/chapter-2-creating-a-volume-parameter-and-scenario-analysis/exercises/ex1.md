
#  Adding a volume parameter

```
Exercise ID 1541057
```

##  Assignment 

In the previous exercises, we calculated full costs at the minimum volumes included in the quotes. What happens if our company decides to order a volume that is different from the few points quoted? 

We will now use a DAX parameter to create a scenario planning tool that calculates full costs for a wider range of production volumes. 

**If you have lost any progress, close any open reports and load `1_4_Supplier_Card_Solution.pbix` from the Exercises folder on the desktop.**

##  Hints 

- In your visualization, make sure that the columns are not summarized.
<li>Your calculated measures should be: 
`Scenario Full Cost = MINX(FILTER(Quotes, 'Scenario Volume'[Scenario Volume Value] &gt;= Quotes[Volume]), Quotes[Non_recurring_expenses] + Quotes[Unit_Cost] * 'Scenario Volume'[Scenario Volume Value])`</li>
- The full cost is specific to the combination of supplier and part number, so make sure all of those are represented in your visualization.

**If you can't find the solution, you can load the workbook `2_1_Parameter_Solution.pbix` from the Workbooks folder on the Desktop.**



##  Solution 

No solution was found.


