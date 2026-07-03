Hi, I'm Deepesh, and I'll be your instructor in this competitor sales analysis case study.

A case study allows you to apply your skills and combine the skills you have learned in the previous courses by practicing them in a real-world business scenario.

For this case study, no new concepts will be introduced which are already there in the below prerequisite courses.

When we work on a BI solution, identifying and solving the end user's needs is the best place to start.

Access to the data that lives in different systems and locations.

Cleaning the data.

Combine the data from all the disparate data sources to produce the needed reports.

Exploring and analyzing the data.

As we usually say, a picture is worth 1000 words; so visualizing it, and share the results with the other end users.

Sharing of the reports and dashboards is outside the scope of this case study.

The core goal of this case study is to build a report using a fictional Sales and Market share dataset for a manufacturing company called Sintec. 

Sintec is looking for a solution to focus not only on the company's performance internally on how well their products sell but also analyze other top competitors' sales and how well they are performing against the other competitors' products.

In this case study, we'll create a snowflake-based schema and work with fact and dimension tables. 
The data is spread across six countries in one folder, and USA's data is in a separate folder. So we are going to work with one fact table that will be created through the transformations step by combining multiple files.

The final fact table stores all the transactional data by date, product, and zip code.

In addition, we'll be working with multiple dimension tables. Dimension tables are often highly de-normalized because these structures are not built to manage transactions. Instead, they are built to enable users to analyze data as easily as possible.

We have four dimension tables: Geography having city, state, and zip details. Product table comprising of products data along with their price. The manufacturer table contains the manufacturer's information, and the Date table.

The Date table will be created using DAX calculations during the case study.

This is what our final data model will look like. It follows a snowflake schema where we'll have one dimension table that isn't directly connected to the fact table.

Let's dive deeper into the case study and start our journey.

