
#  Show me the money

```
Exercise ID 1582032
```

##  Assignment 

The Director of Trade approved our trade proposal, nice work! Now we need to analyze how much money the company made on these loans. Therefore, we should calculate the **gross profit** of each of these loans. 

**Close any open workbooks and load `3_0_loan_profit.pbix` from the Exercises folder on the Desktop.**

##  Hints 

**Total Loan Revenue**:

```
Total Loan Revenue = SUMX(loan_data,loan_data[Trade Premium]+loan_data[origition_charges])

```

**Loan Gross Profit**:

```
Loan Gross Profit = SUMX(loan_data,[Total Loan Revenue]-loan_data[lender_credits])

```

**Loan Profit Margin**

```
Loan Profit Margin = DIVIDE([Loan Gross Profit],SUMX(loan_balance,loan_balance[Scheduled Principal Balance]),0)

```

**If you can't find the solution, you can load the report `3_1_loan_profit_solution.pbix` from the Exercises folder on the Desktop.**



##  Solution 

No solution was found.


