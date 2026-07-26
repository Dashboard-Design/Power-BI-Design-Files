
#  What-if analysis

```
Exercise ID 1630769
```

##  Assignment 

You have already created key visuals to display shipping metrics and analyze what-ifs. To better display your work and make it easier for the Whiskique management team to view the results, you must make a dashboard-style page. The business requirements for the page are:

- Prominently display key KPIs. They are total and cumulative shipping costs (baseline, what-if, and difference). 
- Change shipped quantity using a parameter.
- Breakdown of baseline and what-if shipping costs by product.

_We do not recommend doing so, but if you lost progress you can load the solution workbook of the previous exercise `2_5_costs_by_product_solution.pbix` from the Workbooks folder.

##  Instructions 



##  Hints 

- The measure `Baseline running total` can be created using the formula

```
SUMX(FILTER(ALLSELECTED(Sales), Sales[Transaction Date] &lt;=MAX('Market Basket'[Transaction Date])), [Shipping (Baseline)])

```

- The measures "What-if running total" and "Difference running total" can be created using the same formula and just replacing thelast part of the formula with the relevant measure.
- Create the **Area chart** visual using the `Year` and `Month` from the `Transaction Date` column in the `Sales` table as the **X-axis**. 
- Add `Baseline running total`, `What-if running total`, and `Difference running total` to the **Y-axis**.

**If you can't find the solution, you can load the workbook `2_6_what_if_analysis_solution.pbix` from the Exercises folder on the Desktop.**



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


