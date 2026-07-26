
#  Data clean up

```
Exercise ID 1593914
```

##  Assignment 

The business users have informed you that all valid transactions have an `Invoice No`. You need to remove transactions with empty invoice values. 

You have also been informed that different versions of the same US states in the `Order State` variable also need your attention. 

**We do not recommend doing so, but if you lost progress you can load the solution workbook of the previous exercise `1_1_data_source_solution.pbix` from the Workbooks folder.**

##  Instructions 



##  Hints 

- In the **Power Query Editor**, select the `Sales` table from the **Queries** panel and then select the `Invoice No` column.
- Using the column dropdown menu, unselect "(null)" values, then click **Close & Apply** to save and apply the changes.
- After uploading and editing the `state_region_mapping.csv` file, navigate to the **Model view** and create a relationship between the `State Mapping` and `Customers` tables using the `Order State` variable.
- The relationship created will have "Many to many" **Cardinality** and the **Cross filter direction** should be set to "Both".

**If you can't find the solution, you can load the workbook `1_2_data_clean_up_solution.pbix` from the Exercises folder on the Desktop.**



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


