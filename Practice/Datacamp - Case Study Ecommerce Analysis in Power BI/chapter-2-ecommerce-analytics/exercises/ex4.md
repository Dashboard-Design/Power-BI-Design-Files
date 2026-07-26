
#  What-if analysis metrics: Part 2

```
Exercise ID 1645153
```

##  Assignment 

Great start with the what-if metrics! Time to finish off the process by adding what-if shipping metrics and giving your colleagues to see the differences between the baseline values and the what-if values.

**We do not recommend doing so, but if you lost progress you can load the solution workbook of the previous exercise `2_3_what_if_metrics_part_1_solution.pbix` from the Workbooks folder.**

##  Hints 

- The `Shipping (What-if)` measure should be created as follows:

```
SUMX(Sales,IF(Sales[Quantity]=1,Sales[Shipping Cost],Sales[Shipping Cost]+(((Sales[Quantity])-1)*(Sales[Shipping Cost]*[Blended Shipping Cost Factor]))))

```

- The `Shipping (Difference)` measure should be created as follows:

```
[Shipping (Baseline)] - [Shipping (What-if)]

```

**If you can't find the solution, you can load the workbook `2_4_what_if_metrics_part_2_solution.pbix` from the Exercises folder on the Desktop.**



##  Solution 

No solution was found.


