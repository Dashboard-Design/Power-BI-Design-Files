# CountryFlag

Returns a country flag image URL from a country name using one of five available flag styles.

<img width="1343" height="736" alt="Image" src="https://github.com/user-attachments/assets/a1af2478-13fd-4489-ab83-a46ff2a36bc3" />

## Parameters

| Parameter | Description |
|------------|------------|
| `Country_dimensionColumn` | Country name column or expression (e.g. `Customer[Country]`) |
| `Style` | Flag style number (1–5) |

## Available Styles

| Style | Description |
|---------|------------|
| 1 | Circular Flags |
| 2 | Rectangle Flags (3:2) |
| 3 | Square Flags (1:1) |
| 4 | Square Flags (Alternative Design) |
| 5 | Round Flags |

## Example

```DAX
Country Flag =
CountryFlag(
    Customer[Country],
    1
)
```

## Important

After creating the measure:

1. Select the measure in Power BI.
2. Set **Data Category** to **Image URL**.
3. Use the measure in a Table, Matrix, or any visual that supports image URLs.

## Returns

A URL pointing to an SVG flag image based on the supplied country name and selected style.

Returns `BLANK()` when no matching country is found.
