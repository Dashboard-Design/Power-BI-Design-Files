# SVG Visuals for Power BI: Target Line Bar Chart

This folder contains DAX measures that generate **dynamic SVG bar charts with a target line** directly in your Power BI reports. They are ideal for comparing actual performance against goals across categories, with a clean, professional design.

![Image](https://github.com/user-attachments/assets/80763a20-939a-4996-988c-2963de3ff22d)


## ✨ Features

- **Actual vs. Target Comparison** – Each bar represents an actual value, with a dashed vertical line the target.
- **Automatic Global Scaling** – All bars share the same axis scale based on the maximum value across selected categories (plus headroom), ensuring fair visual comparison.
- **Clean Visual Design** – Light grey background track, rounded bars, and a distinctive dashed target line.
- **Conditional Colors** – Bars turn red when below target, green when at or above target (colors are fully customizable).
- **Easy to Use** – Two versions are provided:
    1.  **Template Measure**: Just change the measure and column references.
    2.  **User‑Defined Function (UDF)**: A reusable function (once enabled) that accepts actual/target measures and a dimension column as parameters.
- **Highly Customizable** – Chart dimensions, axis margins, colors, and target marker can all be tweaked.

## ⚙️ Customization Options

In the template measure, look for the "CONFIGURATION" section (near the top). In the UDF, these become optional parameters:

| Parameter | Description | Default |
| :--- | :--- | :--- |
| `chartHeight` | Total height of the chart area (pixels) | `35` |
| `barHeight` | Height of the actual bar (pixels) | `28` |
| `axisMinValue` | Left margin (start of axis) | `20` |
| `axisMaxValue` | Right margin (end of axis) | `130` |
| `belowColor` | Bar color when actual < target | `"#e74c3c"` (soft red) |
| `aboveColor` | Bar color when actual ≥ target | `"#2ecc71"` (soft green) |

## 💡 Tips

- The chart works best with **categorical data** where each row represents a distinct category (e.g., product, region, month).
- The `HASONEVALUE` check ensures the SVG only renders when a single dimension value is in context – important for totals or subtotals where a chart wouldn't make sense.
- The global axis maximum is calculated across **all selected dimension values** (using `ALLSELECTED`), so the scale stays consistent even when you filter other columns.
- To add **data labels** (e.g., show the actual number at the end of the bar), you can extend the measure by adding a `<text>` element – similar to how it was done in the Status Pill UDF.

