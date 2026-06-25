Let's go a step deeper. In the first chapter, we calculated full cost for the buy options at the small number of quoted production volumes. These data points could be used to drive supply chain decisions, but what if our production estimates don’t match the quoted volumes?

As Mike Tyson once said "Everyone has a plan until they get punched in the mouth."

In reality, it is unlikely to order exactly the number of products that were quoted. Projects start with assumptions that often change as the team learns more. 

That is why it is important to have a tool that guides decisions over a wider range of volumes. Determining production volumes for a new product is full of uncertainty so our tool needs to help us analyze our volumes more dynamically. 

The primary source of uncertainty for production volumes is demand. This is especially true for new products. 

If a product has never been on the market before, how can we know how many customers will want to buy it? Even if your company is launching a next generation of an old product, there is still uncertainty based on product-market fit, outside economic conditions, and price.

Demand forecasting is a fascinating and extensive topic that will not be covered in this course. The interdependence between price, demand, production volume and production cost only increases the value of a dynamic supply chain decision-making tool.

You might be wondering, if we find out we need to assess another production volume, why don’t we just ask our suppliers for another quote? 

While it is a great idea to have open lines of communication with your supply chain, asking for quotes and preparing quotes can be time consuming for both sides. The minimum turn-around time for production quotes can often be several valuable days or even longer, which can cause unwanted project delays.

Thankfully, quotes are typically set up in a way that allows for us to develop a scenario analysis tool to analyze volumes that were not expressly included in the quotes. 

Recall that the volume column is the minimum production volume associated with the unit cost and the non-recurring expense. That means the full cost formula holds between quoted production volumes. 

We can utilize Power BI’s Parameter function to set up a Scenario Volume Analysis. 

As a reminder, a Power BI parameter is a value that the user can control using a slicer. The parameter can be referenced in DAX measures that will update on the report as the user changes the parameter value.

In the first chapter, you created a column that calculated the full cost for each row in the Quotes table. 

In this chapter, you will create a Full Cost measure based on the Scenario Volume parameter. For each part number- scenario volume combination, there may be many potential rows of unit cost and non-recurring expenses. 

We want the full cost measure to return the lowest full cost from the eligible supplier, part and volume combinations. 

This is the perfect use case for an iterative function. As a reminder, an iterative function is a function that iterates through all rows of the given table, applies the expression, and then aggregates the result.

MINX returns the minimum value of an expression computed for each row of the table you pass it.

In this case, we will want to utilize the MINX function because we are looking for the minimum full cost value. You can pass a filtered table to the iterative function, and it will only iterate over the rows that meet the filter criteria.

This will be useful to make sure full cost is only calculated for valid quote rows.

What do you know? The project manager says that a recent viral internet trend has affected our projected production volumes. Let's create a tool to help us consider the scenarios!

