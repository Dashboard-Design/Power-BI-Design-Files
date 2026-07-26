
#  Looking at quantities

```
Exercise ID 1593918
```

##  Assignment 

Let us view the total sales by average quantity. Many customers buy a single quantity of a product but combine that with other product types. The average quantity differs when calculated at the invoice level vs. across the entire business. This exercise will help solidify your understanding of the relationship between the shipped quantity and the shipping cost.

**We do not recommend doing so, but if you lost progress you can load the solution workbook of the previous exercise `1_4_order_metrics_solution.pbix` from the Workbooks folder.**

##  Instructions 



##  Hints 

- Create a **Clustered column chart**, with the `Quantity` on the **X-axis** and sum of `Sales` on the **Y-axis**. Make sure to filter out `Sales` values less than zero. The x-axis value should be displayed as a category, and the y-axis should show the percent of grand total.
- Using **Power Query Editor** replace all "Indoor Pet Camera (Wi-Fi)" descriptions in the `Sales` table with "Indoor Pet Camera", using the **Replace Values** under the **Transform** tab.
- To create the `Invoice Totals` table, duplicate the `Sales` table in **Power Query Editor**. Then use the **Group By** function to aggregate the `Quantity` and `Sales` by the `Invoice No`.

**If you can't find the solution, you can load the workbook `1_5_quantities_solution.pbix` from the Exercises folder on the Desktop.**



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


