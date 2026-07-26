
#  Market basket visualization

```
Exercise ID 1593919
```

##  Assignment 

Market basket analysis allows a retailer like Whiskique to understand customer purchasing patterns better. If they buy one specific product, what else do they buy?

Due to time constraints, you will build a simplified version of a market basket analysis visualization that allows your colleagues to see which products are purchased more often in combination with a specific product they select. You will have to duplicate your `Sales` data and create a new relationship to achieve this.

**We do not recommend doing so, but if you lost progress you can load the solution workbook of the previous exercise `1_5_quantities_solution.pbix` from the Workbooks folder.**

##  Instructions 



##  Hints 

<li>The DAX formula for your new table should look like this:
`Market Basket = Sales`</li>
- Use the 'Invoice No' to create a relationship between the `Market Basket` table and the `Sales` table. 
- Create a **Table** or **Slicer** containing the product descriptions from the `Sales` table. 
- Create a chart visual using the `Description` from the `Market Basket` table, counting the number of occurrences of the variable.
- Alter the interactions between the two visuals, ensuring that the list filters down the information in the chart. 

**If you can't find the solution, you can load the workbook `1_6_market_basket_solution.pbix` from the Exercises folder on the Desktop.**



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


