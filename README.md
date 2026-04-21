# RFM-Sales-Data-Analysis

Who are your most valuable customers? The data has the answer. 🕵️‍♂️

I recently completed a Customer Segmentation Analysis to move beyond surface-level sales totals. By performing RFM Analysis, I categorized our 287 customers into actionable segments to help drive targeted marketing strategies.

## The Tech Stack:

## SQL: 
Used for data cleaning and complex transformations to calculate Recency, Frequency, and Monetary scores for every customer ID.

## Visualization: 
Built a dynamic dashboard to highlight revenue concentration.

## The Big Win: 
Even though "Active" customers are our largest group by count (22%), our Loyal VIPs and Loyals are the real heavy hitters, contributing over $7,200 of the total $17.07K revenue. This insight allows us to focus retention efforts where the ROI is highest.

<img width="900" height="580" alt="Screenshot 2026-04-21 142333" src="https://github.com/user-attachments/assets/20927faf-c4d6-42b2-8d61-5b565611c748" />

From raw database rows to strategic customer segments. 💻📊

## My Process:

## SQL Transformation: 
I wrote CTEs and window functions to aggregate order dates and total spend, creating the RFM framework.

## Segmentation Logic: 
Applied scoring logic to rank customers into groups like "Loyal VIPs," "Need Attention," and "Lost/In-Active."

## Dash-boarding: 
Visualized the segments to show the discrepancy between customer count and revenue contribution (as seen in the Treemap).

It’s one thing to see total sales; it’s another to see that 16% of our base is "Lost/In-Active." Now, we have a list of exactly who to target for a "Win-Back" campaign
