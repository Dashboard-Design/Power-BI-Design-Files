
#  Build an executive summary

```
Exercise ID 1639485
```

##  Assignment 

You now have most of the pieces to create an executive summary. An executive summary provides a quick pulse of the business operations and displays metrics such as sales, profit, and expenses. In addition, it provides an ability to drill down or filter on dimensions like product and customer location. 

In this exercise you will add the final pieces to the page and start preparing the final versions of your dashboard-style pages. 

**We do not recommend doing so, but if you lost progress you can load the solution workbook of the previous exercise `3_1_revenue_and_profits_solution.pbix` from the Workbooks folder.**

##  Instructions 



##  Hints 

- Add a **Card** visual from the **Visualizations** pane, and drag the `Shipping (Baseline)` to the **Fields** section to display the value.
- Using a **Stacked bar chart**, add the `Decription` field to the **Y-axis** and the `Sales` to the **X-axis**. Make sure the summarization is set to **Sum**.
- Add `Category` to the **Legend** section in order to distinguish each product by its category.
- Create a new **Slicer** visual and change it to a dropdown menu, listing the items from the `Description` column.

**If you can't find the solution, you can load the workbook `3_2_executive_summary_solution.pbix` from the Exercises folder on the Desktop.**



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


