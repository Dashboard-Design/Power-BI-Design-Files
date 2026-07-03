
#  This year vs last year and % growth calculation

```
Exercise ID 1458238
```

##  Assignment 

While you are continuing your report development, one primary KPI you have been asked to track and add to the report is to show the sales growth and the rate at which a product can increase the revenue from sales during a fixed period.

In this exercise, you will do DAX calculations to add the `% Growth` measure in your report and examine the trend and revenue growth compared to last year. 

**We do not recommend doing so, but if you lost progress you can load the solution workbook of the previous exercise `2_2_data_visualization_solution.pbix` from the Exercises folder.**

##  Hints 

Have you correctly written your DAX measure for the `PY Sales`? It should look like the below:

```
PY Sales =
CALCULATE (
    SUM (Revenue),
    SAMEPERIODLASTYEAR ('Date'[Date])
)

```

`% Growth` can be calculated as:

```
% Growth = 
DIVIDE(
SUM(Sales[Revenue])-[PY Sales],[PY Sales]
)

```

**If you can't find the solution, you can load the workbook `2_3_percentage_growth_solution.pbix` from the Exercises folder on the Desktop.**



##  Solution 

No solution was found.


