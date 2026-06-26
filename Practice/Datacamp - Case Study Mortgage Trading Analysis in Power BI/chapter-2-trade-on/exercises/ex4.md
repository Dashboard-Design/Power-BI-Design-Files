
#  Trade premium

```
Exercise ID 1562918
```

##  Assignment 

Great work so far. After benchmarking our prices, we know which loans we want to trade versus hold back. Now, we'll want to calculate the **trade amount** and **trade premium** amounts to understand how much money we'll make on these trades.

To do this, we'll need to multiply `Price` by the `Scheduled Principal Balance`. Both of these fields live in two separate tables that we haven't merged together. We can use the `RELATED([column])` to call a value from another table.

More information on the syntax for `RELATED()` can be found [here](https://learn.microsoft.com/en-us/dax/related-function-dax).

**If you have lost progress, close any open workbooks and load `2_3_benchmarking_solution.pbix` from the Exercises folder on the Desktop.**

##  Hints 

**Trade Price**

```
Trade Amount = RELATED(loan_balance[Scheduled Principal Balance])*[Price]/100

```

**Trade Premium**

```
Trade Premium = [Trade Amount]-RELATED(loan_balance[Scheduled Principal Balance])

```

**If you can't find the solution, you can load the report `2_4_trade_premium_solution.pbix` from the Exercises folder on the Desktop.**



##  Solution 

No solution was found.


