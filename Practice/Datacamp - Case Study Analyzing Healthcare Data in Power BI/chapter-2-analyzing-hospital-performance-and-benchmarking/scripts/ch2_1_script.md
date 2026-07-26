Great work so far! You have set up your dataset and done some data cleaning. Now is your chance to scrub in and get operating on some in-depth analysis into our data.

So far, we have taken a broad assessment of the hospital dataset. We learned there are 151 hospitals in New York state that did our surgical procedure of interest, and over 26 thousand discharges. Patients stayed an average of 2.65 days for the procedure, though there was significant variability between hospitals.

We looked at some demographics like age and gender, but we don’t yet have a clear understanding of what is behind the variability in LOS, or what the most significant factors are. There are many attributes in the dataset we will still need to analyze.

Our first task in this chapter will be to add costing to the equation by assessing the average cost per discharge. 

This will be calculated by dividing sum of total costs over sum of total discharges.

Going forward, this metric will serve as a helpful benchmark to compare between hospitals, and highlight areas for efficiency improvement.

There are multiple factors that can impact cost of a patient stay, such as patient severity of condition, patient age, the size of the hospital, the procedure itself, types of equipment used, to name a few.

Throughout this chapter, we'll seek to answer the following business questions:

Which hospitals stand out with highest average cost and Length of Stay relative to the state averages?

Which hospitals stand out as biggest outliers overall?

Does larger surgical program size impact LOS and cost?

Lastly, for a root cause analysis: what factors influence LOS and cost the most?

Are you ready to get to it? Let's go!

