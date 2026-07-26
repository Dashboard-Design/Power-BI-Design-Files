
#  New customer measures

```
Exercise ID 1593915
```

##  Assignment 

Now that you have a clean dataset, you can build a few customer metrics to understand how many customers the company has and their total business. You will create the metrics: **Number of Customers** and **Customer Lifetime Value**. You will then find the best way to display these metrics so your colleagues can obtain their desired insights.

**We do not recommend doing so, but if you lost progress you can load the solution workbook of the previous exercise `1_2_data_clean_up_solution.pbix` from the Workbooks folder.**

##  Instructions 



##  Hints 

- To create a new blank table, use `{BLANK()}`.
- The measure that counts the distinct number of customers is created using `DISTINCTCOUNTNOBLANK(Sales[Customer ID])`.
<li>To create the `Customer LTV (avg)` use the following:
`SUM(Sales[Sales])/[Number of Customers]`</li>

**If you can't find the solution, you can load the workbook `1_3_customer_metrics_solution.pbix` from the Exercises folder on the Desktop.**



##  Solution 

```
# Edit or remove this code to create your own exercise.
# This is 1 type of drag and drop exercise, there are 2 other types. See documentation:
# http://instructor-support.datacamp.com/en/articles/3039539-course-drag-drop-exercises

# Make sure you only use SPACES, NOT TABS in front of each line.
- id: data_science_process
  title: Data Science Process
  items:
    - id: question # ID of the item. This can be used in the SCTs.
      content: Ask an interesting question # Name of an item. Feel free to use markdown.
    - id: data
      content: Get the data
    - id: explore
      content: Explore the data
    - id: model
      content: Model the data
    - id: communicate
      content: Communicate and visualize the results
```


