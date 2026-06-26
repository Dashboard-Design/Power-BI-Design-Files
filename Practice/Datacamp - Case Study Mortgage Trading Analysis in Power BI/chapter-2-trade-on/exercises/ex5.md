
#  Weight in gold

```
Exercise ID 1562919
```

##  Assignment 

Not all averages are equal. The **weighted-average** can give more representation to some variables over others.

When we consider prices, does it make sense to use a normal **arithmetic average**? An average of price would simply take the sum of prices and divide it by the total number of loans.

A **weighted-average** would give more representation to larger loans which would produce more dollar price amount, than smaller loans. 

**If you have lost progress, close any open workbooks and load `2_4_trade_premium_solution.pbix` from the Exercises folder on the Desktop.**

##  Hints 

The completed weighted average calculation should be:

```
WA Price = DIVIDE(SUMX(loan_data,loan_data[Price]*RELATED(loan_balance[Scheduled Principal Balance])),SUM(loan_balance[Scheduled Principal Balance]),0)

```

**If you can't find the solution, you can load the report `2_5_weighted_average_solution.pbix` from the Exercises folder on the Desktop.**



##  Solution 

No solution was found.


