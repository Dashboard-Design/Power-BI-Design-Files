
#  Impact of surgical program size

```
Exercise ID 1564718
```

##  Assignment 

Before completing a root cause analysis, your boss asked you to make sure to account for surgical program size as a variable.

While our source data doesn't explicitly state the surgical program size, we can calculate a proxy for this by referencing the total elective hip replacement surgeries done in the year. 

To do this, we will use a DAX function to create a new table that summarizes total discharges and surgeons by hospital. This table can then be joined to the master data table for analysis going forward.

**We do not recommend doing so, but if you lost progress, you can load the solution workbook of the previous exercise `2_3_highlighting_the_outliers_solution.pbix` from the Exercises folder.**

##  Hints 

- You can create your calculated table using the following DAX structure:

```
surgical_program_size_summary = 

SUMMARIZECOLUMNS(
    Hospital_Discharges[facility_name], -- your groupBy variable
    "Total Discharges", [Total Discharges], -- reference your existing measure
    "Total Surgeons", [Total Surgeons] -- reference your existing measure
)

```

- Your calculated column for `Surgical Program Size` can be created using the following DAX syntax:

```
Surgical Program Size = 
SWITCH(
    TRUE(),
    surgical_program_size_summary[Total Discharges (bins)] = 0, "&lt;200",
    surgical_program_size_summary[Total Discharges (bins)] = 200, "200-399",
    surgical_program_size_summary[Total Discharges (bins)] = 400, "400-599",
    "&gt;=600"
)

```

**If you can't find the solution, you can load the workbook `2_4_impact_of_surgical_program_size_solution.pbix` from the Exercises folder on the Desktop.**



##  Solution 

No solution was found.


