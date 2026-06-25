
#  Sales by year

```
Exercise ID 1452160
```

##  Assignment 

It seems we have sales information for all years together, but we want to focus on comparing years separately. To be able to calculate the current stock, you will first have to calculate the amount of items sold in 2021 and 2022 for each item.

**We recommend you to keep working in your own workbook but if you lost progress you can open `1_4_revenue_and_profit_solution.pbix` from the Exercises folder on the Desktop**

##  Hints 

- For the **Bar chart** you should be looking at `Description` and the year with more sales, `Quantity_2021`.
- Make sure you display your values from 2021 as percentages from the total by going to the **Visualizations** pane and selecting the down arrow next to the variable's name.
- Try checking if your function for quantity looks like the example below:

```
Quantity_2021=CALCULATE(SUM(Orders[Quantity]),FILTER(Orders,Stock[SKU-ID]=Orders[SKU] &amp;&amp; Orders[Year]=2021))

```

**If you can't find the solution, you can load the report `2_1_sales_by_year_solution.pbix` from the Exercises folder on the Desktop.**



##  Solution 

No solution was found.


