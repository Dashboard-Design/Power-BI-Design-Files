
#  Products and shipping

```
Exercise ID 1593916
```

##  Assignment 

As well as overall sales information, it is important for Whiskique to know what products sell well and what type of costs might be associated with selling those products. In this exercise, you will look at what products sell in higher quantities and how much total sales they generate. You will also look into which products have the highest shipping costs associated. 

**We do not recommend doing so, but if you lost progress you can load the solution workbook of the previous exercise `1_3_customer_metrics_solution.pbix` from the Workbooks folder.**

##  Instructions 



##  Hints 

- Create a **Stacked bar chart** that has the `Description` variable from the `Sales` table in the **Y-axis** and the `Quantity` variable in the **X-axis**. Make sure that the `Quantity` has the summarization is set to **Average**.
- The **Treemap** visual should have the `Category` and `Description` variables in the **Category** section, with the `Sales` variable in the **Values** section, ensuring that the aggregation type is set to **Sum**.
- Create a **Stacked bar chart** with the `Description` variable from the `Products` table in the **Y-axis** and the `Shipping_Cost_1000_mile` in the **X-axis**. Set the summarization of `Shipping_Cost_1000_mile` to **Average**.

**If you can't find the solution, you can load the workbook `1_4_order_metrics_solution.pbix` from the Exercises folder on the Desktop.**



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


