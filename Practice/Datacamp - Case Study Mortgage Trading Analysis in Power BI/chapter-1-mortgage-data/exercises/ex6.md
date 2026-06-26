
#  Paying principal

```
Exercise ID 1562911
```

##  Assignment 

For the context of this case study, today's date is **September 21, 2021**. Generally, trades take time as buyers review the loan data, perform financial analysis and contracts are signed. Therefore, we'll target **October 13, 2021** as the settlement date. The settlement date is the day the transaction happens: everything is finalized and the lender sells their loans to the financial institutions.

Since the trade settles in the next month, some borrowers will have to make payments on their mortgages for **October**. We'll need to do some math to figure out what the **scheduled principal balance** will be for each loan next month. 

We can do this with the `PPMT()` function, which will find the principal portion of the payment, and subtracting it from the **current balance** of the loan. Review the syntax for `PPMT()` [here](https://learn.microsoft.com/en-us/dax/ppmt-function-dax).

**If you have lost progress, close any open workbooks and load `1_4_ready_yet_solution.pbix` from the Exercises folder on the Desktop.**

##  Hints 

To find the pattern, look at the dates. Should we be be amortizing payments for loans that have already made their October payment?

Your final formulas should look like this:

1. `Payment Period = loan_balance[payment_periods_made]+1`
1. `Amortization Amount = PPMT(loan_balance[interest_rate]/12,loan_balance[Payment Period],loan_balance[loan_term],loan_balance[current_balance],0,0)`
1. `Scheduled Principal Balance = loan_balance[current_balance]+loan_balance[Amortization Amount]`

**If you can't find the solution, you can load the report `1_5_paying_principal_solution.pbix` from the Exercises folder on the Desktop.**



##  Solution 

No solution was found.


