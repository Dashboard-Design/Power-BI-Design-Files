
#  Inventory turnover

```
Exercise ID 1463013
```

##  Assignment 

Warmehands Inc. wants to know how often they sold their products during 2021. Your task is to analyze this issue using the Inventory Turnover. Now that you have the current inventory stock, it will be easy to calculate this efficiency ratio. Remember, you can calculate this metric as:

\(Inventory\;turnover = \frac{COGS}{Average\;value\;of\;inventory}\)

**We recommend you to keep working in your own workbook but if you lost progress you can open `2_1_sales_by_year_solution.pbix` from the Exercises folder on the Desktop**

##  Hints 

<li><p>Try comparing your formula for a new table with the following:
<code>
Turnover = SELECTCOLUMNS(Stock, "SKU-ID", Stock[SKU-ID],
                            "Description", Stock[Description],
                            "2021_Start_stock", Stock[2021_start_stock],
                            "Quantity_2021",Stock[Quantity_2021],
                            "COGS",Stock[COGS])
</code></p></li>
<li><p>Your column `2021_End_stock` must be written as follows:
<code>
2021_End_stock = Turnover[2021_Start_stock] - Turnover[Quantity_2021]
</code></p></li>
<li><p>Try the following for `Avg_inventory`: 
<code>
Avg_inventory = ( Turnover[2021_Start_stock] + 
              Turnover[2021_End_stock] )* Turnover[COGS] / 2
</code></p></li>
<li><p>Inventory turnover should be calculated as:
<code>
Inventory_turnover = Turnover[COGS]*Turnover[Quantity_2021]/Turnover[Avg_inventory]
</code></p></li>

**If you can't find the solution, you can load the report `2_2_inventory_turnover.pbix` from the Exercises folder on the Desktop.**



##  Solution 

No solution was found.


