
#  Calculating relative differences

```
Exercise ID 1564716
```

##  Assignment 

The average cost per discharge and average LOS vary per hospital facility. Your next task is to create two metrics to quantify the relative difference between each hospital vs the overall state average.

**We do not recommend doing so, but if you lost progress, you can load the solution workbook of the previous exercise `2_1_cost_analysis_by_hospital_solution.pbix` from the Exercises folder.**

##  Hints 

DAX code structure for `Average Cost per Discharge ALL` and `Average LOS Days ALL`:

```
CALCULATE(
    [Average Cost per Discharge],
    ALL()
)

```

Here's how you can structure your final DAX code for `% Var Average Cost per Discharge` and `% Var Average LOS Days`:

```
% Var Average Cost per Discharge = 
DIVIDE(
    ([Average Cost per Discharge]-[Average Cost per Discharge ALL]),
    [Average Cost per Discharge ALL]
)

```

**If you can't find the solution, you can load the workbook `2_2_calculating_relative_differences_solution.pbix` from the Exercises folder on the Desktop.**



##  Solution 

No solution was found.


