Hello again! In this video, we will review some of the finer details about mortgages to give you a better context on the rest of the case study.

A loan agreement is the borrower's promise to repay the money the lender gave them. It's essentially a repayment plan that details the terms and conditions on how the borrower will pay back the loan.

In this graph, the loan was made for $100,000, and $20,000 is paid down each year for five years until it is paid in full.

The original amount borrowed is called the "loan amount".

Each period, usually monthly, the borrower will make payments with principal and interest to pay down the loan amount.

Principal is the current amount owed on the loan, which is why it is sometimes called the current balance. As the borrower makes payments on their loan, the principal balance goes down. 

Here, this graph shows the principal balance decreases as payments are made. This phenomenon is known as "amortization".

The interest rate is the proportion of interest owed on the principal balance each period, and it is quoted as an annual rate.

However, since most payments are made monthly, we must convert the annual rate into a monthly one. This is done easily by dividing by 12.

Let's look at an example and calculate the interest for the month on $100,000 with a 5% annual rate.

First, we divide 5% by 12, and we get 0 point 417% as our monthly rate.

Then, we multiply 0 point 417% by the principal balance of $100,000 and get $417 of interest owed for this month.

With amortization, as payments are made and the loan balance decreases, less interest is owed.

Payments usually stay the same, so as the interest portion decreases, the principal portion increases and the loan is paid down faster toward the end. Look how the portion of principal and interest changes for this $6,500 payment over 30 years.

Since the principal portion of a payment is different for each period, Power BI has a formula to find it: PPMT, which is short for principal payment.

The syntax needs a few inputs, like the rate, the period the payment is being amortized, the total number of periods in the loan, and the current balance which is the present value. The future value and type are optional and can be omitted or have zeros. 

Note that this function produces a negative value.
Also, remember to adjust the rate, just like we practiced in the previous slides.

For example, to find the principal portion of the first payment on a $100,000 loan with a 5% interest rate and 360-month term, we would first plug in the numbers, adjusting the rate to a monthly figure since the periods are in months.

Once we run this function, it will return negative $120 and 15 cents.

To amortize, we simply subtract the principal amount paid with the payment from the principal balance.

Since the PPMT creates a negative output, we should add so we don't create a double negative. 

Following our previous example, the principal balance is reduced to $99,879 and 85 cents after the first payment.

Finally, lenders have qualification criteria to make sure borrowers can afford the loans they take out. This is highly regulated, especially after the 2008 Global Financial Crisis that resulted from bad mortgage lending practices.

The first qualification criteria are credit scores. They are based on a borrower's history of making payments to loans they owe. Missing payments badly hurt a borrower's score as it shows they may be a risky investment.

In the US, this score ranges from 300 to 850. Higher is better.

The debt-to-income ratio divides a borrower's monthly debt over their total monthly income. Generally, lenders like to see this under 50%.

Finally, lenders look at loan-to-value, or LTV, which divides the loan amount by the property value. Lenders never want to lend more than the property is worth and lower LTVs are seen as less risky.

Alright, let's continue with our case study.

