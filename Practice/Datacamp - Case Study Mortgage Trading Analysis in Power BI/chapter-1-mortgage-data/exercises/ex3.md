
#  Risky ratios

```
Exercise ID 1562912
```

##  Assignment 

The two most fundamental ratios that describe the riskiness of the loan are **loan to value** and **debt to income**. 

The **loan to value** (LTV) ratio gives the loan amount over the value of the property. This is important in determining how much the investor would expect to get back if the borrower were to default and stop paying. In that case, the investor could take the property and sell it to try and recoup the loan amount.

The **debt to income** (DTI) ratio gives the monthly debt payments over the monthly income, and it tells the investor how well the borrower can pay back the loan. Usually, investors don't like to see this over 50% as that would imply that 50% of the borrowers gross income is spent just on debt payments! This doesn't leave a lot of room to pay other things like utility bills, groceries or taxes.

**If you have lost progress, close any open workbooks and load `1_1_loan_data_solution.bpix` from the Exercises folder on the Desktop.**

##  Hints 

Your formulas may look like this: 

```
Loan to Value Ratio = DIVIDE(SUM(loan_data[loan_amount]),SUM(loan_data[property_value]),0)

Monthly Income = DIVIDE(SUM(loan_data[income_thousands]),12,0)*1000

Debt to Income Ratio = DIVIDE(SUM(loan_data[recurring_monthly_debt]),[Monthly Income],0)

```

**If you can't find the solution, you can load the report `1_2_risky_ratios_solution.pbix` from the Exercises folder on the Desktop.**



##  Solution 

No solution was found.


