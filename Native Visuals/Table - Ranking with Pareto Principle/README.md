# Dynamic Ranking + Pareto Analysis

A responsive, SVG-powered ranking visual for Power BI tables that combines Pareto (80/20) analysis with dynamic ranking badges.


### 📊 Overview
This visual transforms a standard Power BI table into an intelligent ranking dashboard that:

- Displays dynamic rank numbers with visual badges (#1, #2, #3...).
- Highlights the Pareto principle (80/20 rule) by color-coding the top contributors.
- Shows cumulative percentage in a clean, responsive pill design.
- Automatically adapts to filters and slicers.


### 💡 Pro Tips
1. Column Width: Ensure the table column is wide enough for the pill to display properly (recommended: 120–200px).
2. Data Type: The measure returns a string (URL-encoded SVG). Set the column to "Image URL" data type.
3. Performance: This measure uses ALLSELECTED and RANKX, which are optimized for performance. For very large datasets (100K+ rows), consider adding filters.
4. Totals: The measure returns nothing for totals rows (when multiple sub-categories are selected).
