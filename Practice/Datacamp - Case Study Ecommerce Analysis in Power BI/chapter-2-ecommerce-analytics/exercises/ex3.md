
#  What-if analysis metrics: Part 1

```
Exercise ID 1630767
```

##  Assignment 

Due to a lack of automatic shipping cost capture at the transaction level, Whiskique's shipping department relies on spreadsheets. The shipping department has told you that shipping more than one quantity of an item costs, on average, 70% of the cost of a single-unit shipment. There are variances based on the product. In this exercise, you will start to build the required metrics to make an interactive what-if analysis for your colleagues to play around with effective shipping rates as the quantity changes.

**We do not recommend doing so, but if you lost progress you can load the solution workbook of the previous exercise `2_2_sales_by_state_solution.pbix` from the Workbooks folder.**

##  Instructions 



##  Hints 

- The `Shipping (Baseline)` measure should be created as follows:

```
SUMX(Sales, IF(Sales[Quantity]=1,Sales[Shipping Cost],Sales[Shipping Cost]+(((Sales[Quantity])-1)*(Sales[Shipping Cost]*0.7))))

```

- The `Whatt-if quantity` parameter should range from `1` to `20`. The incremental value should be `1` and the default value `5`.
- The  `Blended Shipping Cost Factor` measure is created as follows:

```
IF('What-if quantity'[What-if quantity Value]&lt;=1,1,IF('What-if quantity'[What-if quantity Value]&lt;=2,0.8,IF('What-if quantity'[What-if quantity Value]&lt;=4,0.6,IF('What-if quantity'[What-if quantity Value]&lt;=7,0.5,IF('What-if quantity'[What-if quantity Value]&lt;=9,0.4,0.3)))))

```

**If you can't find the solution, you can load the workbook `2_3_what_if_metrics_part_1_solution.pbix` from the Exercises folder on the Desktop.**



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


