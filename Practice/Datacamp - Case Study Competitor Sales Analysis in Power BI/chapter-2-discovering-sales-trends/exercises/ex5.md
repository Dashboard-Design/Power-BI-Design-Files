
#  Market share analysis

```
Exercise ID 1448592
```

##  Assignment 

Now that we have completed the data exploration, you have good insights to share with your team. But when the data is expressed in a tabular format, it becomes difficult to understand if the values are higher or lower at first glance.

In this exercise, we'll apply conditional formatting in the matrix visual to make it more readable. Secondly, we will also check how much market share "Sintec" is holding compared to the other manufacturers. 

**We do not recommend doing so, but if you lost progress you can load the solution workbook of the previous exercise `2_3_percentage_growth_solution.pbix` from the Exercises folder.**

##  Hints 

Have you written your DAX code correctly to calculate the `Sintec Revenue`? It should look like the below:

```
Sintec Revenue = 
Calculate(
SUM(Sales[Revenue]), Manufacturer[ManufacturerID] = 4
)

```

`Sintec Market Share` can be calculated as

```
Sintec Market Share = 
DIVIDE(
Sales[Sintec Revenue],SUM(Sales[Revenue]),0
)

```

**If you can't find the solution, you can load the workbook `2_4_market_share_solution.pbix` from the Workbooks folder on the Desktop.**



##  Solution 

No solution was found.


