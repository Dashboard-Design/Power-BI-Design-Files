
#  Setting up relationships

```
Exercise ID 1450927
```

##  Assignment 

Modeling data is a crucial aspect of report development as it helps connect different tables in the form of a star or snowflake schema. There is no column in the `Geography` table with distinct values, so we cannot directly create its relationship with the `Sales` table. 

In this exercise, you will set up the appropriate relationship between `Sales` and `Geography` by creating a calculated column that combines two columns to set up a relationship. Additionally, we will be creating a dedicated date table. 

**We do not recommend doing so, but if you lost progress you can load the solution workbook of the previous exercise `1_4_data_model_performance_optimization_solution.pbix` from the Exercises folder**

##  Hints 

Your final DAX calculations should look like below:

- `Geography[ZipCountry] = Geography[Zip] &amp; "," &amp; Geography[Country]`
- `Sales[ZipCountry] = Sales[Zip] &amp; "," &amp; Sales[Country]`
- `Date = CALENDAR(DATE(2017,1,1), DATE(2021,12,31))`

**If you can't find the solution, you can load the workbook `1_5_relationships_solution.pbix` from the Workbooks folder on the Exercises.**



##  Solution 

No solution was found.


