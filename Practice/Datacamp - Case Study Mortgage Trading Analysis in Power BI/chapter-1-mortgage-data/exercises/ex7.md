
#  Scheduled balances

```
Exercise ID 1566450
```

##  Assignment 

In the last exercise, we needed to amortize loans to get a scheduled principal balance. We did this because between **September 21, 2021** and the settlement date, **October 13, 2021**, borrowers will need to make their **October** payment, which will reduce the total principal balance of loan population.

However, we realized that some loans had already made their **October** payment, so we didn't need to apply payments to those loans. This is not good because we subtracted too much principal from those loans.

We can solve this problem by writing an `IF()` statement to apply the principal payments only to the loans that need to make their **October** payment.

**If you have lost progress, close any open workbooks and load `1_5_paying_principal_solution.pbix` from the Exercises folder on the Desktop.**

##  Hints 

Your calculated columns should be:

```
Scheduled Next Payment Due Date = DATE(2021,11,1)
Scheduled Principal Balance =
loan_balance[current_balance]
    + IF (
        loan_balance[next_payment_due_date] &lt; loan_balance[Scheduled Next Payment Due Date],
        loan_balance[Amortization Amount],
        0
    )

```

**If you can't find the solution, you can load the report `1_6_scheduled_balances_solution.pbix` from the Exercises folder on the Desktop.**



##  Solution 

No solution was found.


