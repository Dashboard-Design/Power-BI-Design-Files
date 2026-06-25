
#  Full Cost with capital investment

```
Exercise ID 1541059
```

##  Assignment 

You have created a measure to calculate the excess production demand. You can now use that to calculate the capital investment cost, which will allow us to calculate the full cost of the Make option. 

**If you have lost any progress, close any open reports and load `3_1_Unit_Capacity_Solution.pbix` from the Exercises folder on the desktop.**

##  Hints 

<li><p>Your capital investment measure should be equivalent to the following: 
`Capital Investment Required (Make) = MINX(Internal_Mfg_Resource_Estimates, ROUNDUP([Additional Unit Capacity Required] / MIN(Internal_Mfg_Resource_Estimates[Unit_Capacity]),0) * Internal_Mfg_Resource_Estimates[Machine_Fixed_Cost])`</p></li>
<li><p>Your make full cost measure should be: 
`Make Scenario Full Cost = MINX(Internal_Mfg_Resource_Estimates, [Capital Investment Required (Make)] + Internal_Mfg_Resource_Estimates[Cost_per_Unit] * 'Scenario Volume'[Scenario Volume Value])`</p></li>
- The full cost is specific to the combination of supplier, part number, and volume quoted, so make sure all of those are represented in your visualization.

**If you can't find the solution, you can load the workbook `3_2_Make_Scenario_Full_Cost_Solution.pbix` from the Workbooks folder on the Desktop.**



##  Solution 

No solution was found.


