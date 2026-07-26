
#  Analysis of length of stay

```
Exercise ID 1557833
```

##  Assignment 

So far we have established some key information about total hospitals and discharges in the dataset, along with some interesting demographics on the patient profile. 

Now it's time get calculating our first efficiency measure of interest, the average length of stay (LOS) days. Your task here will be to explore how LOS varies across some of demographics fields you have become familiar with. 

**We do not recommend doing so, but if you lost progress, you can load the solution workbook of the previous exercise `1_3_analysis_of_total_discharges_solution.pbix` from the Exercises folder.**

##  Hints 

- Have you checked that your calculated column for `Age Band` is picking up the correct `age_group` values?
- To view your `Average LOS Days` value by selected age group and gender, you can cross-slice the value from a chart by clicking on both the age group of interest (50+) and the gender group of interest (M).
- Your final DAX measures should look like this `Average LOS Days = AVERAGE(length_of_stay)`.
- Your final DAX code for calculating `Age Band` should look something like this:

```
Age Bins = 
IF(
    OR(
        hospital_discharges[age_group] = "50 to 69",
        hospital_discharges[age_group] = "70 or Older"
    ),
    "Age 50+",
    "Age &lt;50"
)

```

- If you can't find the solution, you can load the workbook `1_4_analysis_of_length_of_stay_solution.pbix` from the Exercises folder on the Desktop.



##  Solution 

No solution was found.


