
#  Bringing in the data

```
Exercise ID 1593912
```

##  Assignment 

The first step in any analysis is to connect data sources and do a data check. In this exercise, you'll bring in data to Power BI from three different CSV files. 

You will then ensure that the correct relationships exist between the tables in your data model and carry out the first checks on your `Sales` table.

##  Instructions 



##  Hints 

- Add the three files using the **Text/CSV** option in the **Get data** menu.
- Update the relationship between the `Sales` table and the `Product` table so that they are joined by the `Stock Code`.
<li>Create two **Card** visualizations:<ul>
- The first card will use the `Total_Rows` measure to display the total number of rows.
- The second card will use the `Invoice No` variable to display the total number of invoice numbers in the data, ensuring the summarization method is set to **Count**.
**If you can't find the solution, you can load the workbook `1_1_data_source_solution.pbix` from the Exercises folder on the Desktop.**



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


