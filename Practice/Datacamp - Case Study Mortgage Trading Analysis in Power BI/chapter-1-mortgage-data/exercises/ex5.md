
#  Ready yet?

```
Exercise ID 1562914
```

##  Assignment 

In the last exercise, we explored `loan_status.xlsx` and found that some loans were missing all the necessary time-stamps they need to be traded.

We need a simpler way to identify these loans than having to look through every single date field. One way to do this is to create our own status that can summarize the loan's readiness to trade.

**If you have lost progress, close any open workbooks and load `1_3_post_close_process_solution.bpix` from the Exercises folder on the Desktop. Continue working on the Loan Statuses table.**

##  Hints 

Your formula should be:

```
Trade Status =
    IF(ISBLANK(loan_status[file_in_audit]),
        "Closed - Needs Audit",
    IF(ISBLANK(loan_status[file_audit_complete]),
        "Closed - In Audit",
    IF(ISBLANK(loan_status[file_sent_to_custodian]),
        "Closed - Audit Complete",
    IF(ISBLANK(loan_status[file_at_custodian]),
        "Closed - File Sent to Custodian",
        "Closed - Ready to Trade"))))

```

**If you can't find the solution, you can load the report `1_4_ready_yet_solution.pbix` from the Exercises folder on the Desktop.**



##  Solution 

No solution was found.


