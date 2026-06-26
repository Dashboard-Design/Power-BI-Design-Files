
#  Bids received

```
Exercise ID 1562915
```

##  Assignment 

The trade is on! After sending our mortgage data out, we have some interest from various counterparties. They are sending us their best bids, and we need to figure out who placed the highest offer on each mortgage. This can be done within a few steps of **Power Query Editor**.

**If you have lost progress, close any open workbooks and load `1_6_scheduled_balances_solution.pbix` from the Exercises folder on the Desktop.**

##  Hints 

While in the **Power Query Editor**, click on the **View** ribbon, then select **Column profile**. Then click on the `Price` column. The **Column statistics** will show the Max value for `Price`. Make sure the column profiling is based on the entire dataset. 

The **M** formula for the custom column should read like this: `Table.Max([All Bids], "Price")`

**If you can't find the solution, you can load the report `2_1_bids_received_solution.pbix` from the Exercises folder on the Desktop.**



##  Solution 

No solution was found.


