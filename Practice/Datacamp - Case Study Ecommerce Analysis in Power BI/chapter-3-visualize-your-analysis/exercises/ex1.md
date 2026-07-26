
#  Revenue and profits

```
Exercise ID 1639484
```

##  Assignment 

Let us build core KPIs which executives frequently ask to see. For example, who are my top customers? What are the company's profits?
To help answer these types of questions you will build a map of sales by state, while also creating some new variables that will allow you to show Whiskique’s profitability.

**We do not recommend doing so, but if you lost progress you can load the solution workbook of the previous exercise `2_6_what_if_analysis_solution.pbix` from the Workbooks folder.**

##  Instructions 



##  Hints 

- The two new columns in the `Sales` table are calculated as follows:

```
COGS = [Landed Cost]*[Quantity]
Profit (Baseline) = [Sales]-[COGS]-[Shipping (Baseline)]

```

- The new measure in the `New_Measures` table is calculated as follows:

```
Profit % = sum([Profit (Baseline)])/sum([Sales])

```

**If you can't find the solution, you can load the workbook `3_1_revenue_and_profits_solution.pbix` from the Exercises folder on the Desktop.**



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


