# SVG Visuals for Power BI: Dynamic Slicer Pills

This folder contains DAX measures and UDFs that generate **dynamic SVG pill visuals** directly inside Power BI visuals. These pills are designed to highlight products, categories, brands, or any dimension value using a clean, modern badge-style design.

<img width="1419" height="724" alt="Image" src="https://github.com/user-attachments/assets/3f601fe2-f4f4-4691-a8bc-f1e8dcdcd895" />

## ⚙️ Parameters

The UDF accepts:

| Parameter | Description |
|------------|-------------|
| `Dimension_Column` | The text value to display inside the pill. |
| `Color` | Hex color used for the pill background (e.g. `"#2A6FDB"`). |

### Example

```DAX
ProductPill(
    Products[Product Name],
    "#2A6FDB"
)
```

---

## 📊 Usage

1. Create a measure using the UDF.
2. Add the measure to button slicer visual's image section.
3. Set the measure's **Data Category** to **Image URL**.
4. Adjust row height if needed for optimal display.

---

## 💡 Common Use Cases

* Product Names
* Categories
* Brands
* Regions
* Status Labels
* Customer Segments
* Any categorical dimension

---

## 🎨 Styling Notes

The SVG automatically:

* Calculates width from the text length.
* Applies padding around the text.
* Centers the text horizontally and vertically.
* Uses fully rounded corners for a pill appearance.

You can customize:

* Font size
* Font weight
* SVG height
* Character width multiplier
* Border styling
* Corner radius

by modifying the UDF configuration section.
