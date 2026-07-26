
#  Cost analysis by hospital

```
Exercise ID 1564715
```

##  Assignment 

To broaden your analysis on hospital comparisons, you have been requested to calculate a new metric for the average cost per discharge and use this to gain insights into cost variability by hospital and region. 

The leadership has also tasked you with assessing this new metric by some suspected drivers of high cost. You will evaluate patient mortality risk, severity of illness, diagnosis description, and disposition to identify any factors that stand out.

**We do not recommend doing so, but if you lost progress, you can load the solution workbook of the previous exercise `1_5_initial_comparison_of_hospitals_solution.pbix` from the Exercises folder.**

##  Hints 

- Your DAX code should look something like this:

```
Average Cost per Discharge = 
DIVIDE(
    SUM(hospital_discharges[total_costs]),
    [Total Discharges] -- your calculated measure from previous chapter
)

```

**If you can't find the solution, you can load the workbook `2_1_cost_analysis_by_hospital_solution.pbix` from the Exercises folder on the Desktop.**



##  Solution 

No solution was found.


