
#  ABC analysis

```
Exercise ID 1463015
```

##  Assignment 

Part of WarmeHands Inc. deliverables includes a way to give an idea of how important items sold are to the company. Since you have information on revenue now, you can use the ABC analysis. Your task is to use the steps of the ABC analysis to classify the items. 

**We recommend you to keep working in your own workbook, but if you lost progress you can open `2_3_contrasting_revenue_solution.pbix` from the Exercises folder on the Desktop**

##  Hints 

- To create your table, your code should be like the following:

```
ABC = SELECTCOLUMNS(Stock, "SKU-ID", Stock[SKU-ID],
                           "Description", Stock[Description],
                           "Revenue_2021", Stock[Revenue_2021],
                           "percent_revenue_2021", Stock[percent_revenue_2021])

```

- Your formula for cumulative percentage should look like this:

```
CP_revenue = CALCULATE(
    SUM(ABC[percent_revenue_2021]),
    FILTER(ABC,
    ABC[percent_revenue_2021]&gt;=EARLIER(ABC[percent_revenue_2021])))

```

- Your formula for assigning the categories should be as follows:

```
ABC = IF(ABC[CP_revenue]&lt;=70,"A [High Value]", IF(ABC[CP_revenue]&lt;=90,"B [Medium Value]", "C [Low Value]" ))

```

- Make sure you had `percent_revenue_2021` sorted in descending order before assigning your ABC categories.

**If you can't find the solution, you can load the report `2_4_abc_analysis_solution.pbix` from the Exercises folder on the Desktop.**



##  Solution 

No solution was found.


