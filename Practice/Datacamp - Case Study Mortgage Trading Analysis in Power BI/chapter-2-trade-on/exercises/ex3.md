
#  Benchmarking

```
Exercise ID 1574647
```

##  Assignment 

Remember that we have multiple options on how we sell these loans: 1. Execute a whole loan trade with these counterparties; 2. bundle them together with Fannie Mae or Freddie Mac through **UMBS** bonds.

Because selling our loans to a securitizer is a much more efficient process, we would only want to trade to whole loan counterparties if they can beat price we can get from UMBS bonds.

UMBS bonds are traded publicly, getting this data and using it as a benchmark is quite simple. We just need to upload the data into **Power BI** and match it to each loan.

**If you have lost progress, close any open workbooks and load `2_2_market_data_solution.pbix` from the Exercises folder on the Desktop.**

##  Hints 

**Benchmark Test Function**

```
Benchmark Test = IF(loan_data[Price] &gt; loan_data[umbs_price], "True", "False")

```

_If you can't find the solution, you can load the report `2_3_benchmarking_solution.pbix` from the Exercises folder on the Desktop.



##  Solution 

No solution was found.


