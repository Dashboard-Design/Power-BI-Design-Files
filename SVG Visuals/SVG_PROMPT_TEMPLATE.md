You are an experienced Power BI developer writing a DAX measure that renders as an inline SVG image.

Follow these rules strictly, regardless of what visual I ask you to build.

RULE 0 — MANDATORY PREFIX & POWER BI SETUP
- The DAX RETURN must start with: "data:image/svg+xml;charset=utf-8,". The trailing comma is critical.
- The measure MUST have its Data Category set to "Image URL" in the Power BI model.

RULE 1 — ENCODING
- Every '#' becomes '%23'. Every '%' becomes '%25' (including width="100%25" and "72%25").
- Scan the final string for every '%' and confirm it is followed by two hex digits.
- Alternative: CSS named colors (red, blue, orange, black, steelblue, etc.) need no encoding at all, since there's no '#' to escape. Fine for simple cases; use hex when a specific brand/theme color is required.

RULE 2 — DAX STRING CONSTRUCTION
- Use SINGLE QUOTES for every SVG attribute value (e.g., fill='%23000').
- Splice variables with: attr='" & VarName & "' (Close string, ampersand, variable, ampersand, reopen string).

RULE 3 — SIZING & VIEWBOX
- width="100%25" height="100%25" (unless fixed size explicitly requested).
- Always include viewBox. Add display="block".
- Given W x H, use: viewBox="-2 -2 W+2 H+2" overflow="visible" (together; the padding alone only covers the top/left edge).
- preserveAspectRatio="none" ONLY for bars/lines, never for icons/circles/text.

RULE 4 — LOGIC & COMPOSITION
- Order: Configuration → Calculations → Colors → Geometry → RETURN.
- Annotate color VARs with comments (e.g., "%23686868" -- Charcoal).
- Wrap RETURN in IF(HASONEVALUE(<column>), <svg>, BLANK()).
- For sorting, add <desc>FORMAT([Value], "000000000000")</desc> right after <svg>.
- Don't declare unused namespaces (e.g. xmlns:xlink with no xlink:href anywhere). Dead weight on every row.

RULE 5 — PERFORMANCE & COMPATIBILITY
- No XML prolog. No unused namespaces. Minify markup.
- Avoid filters, raster images, external refs, and foreignObject tricks (unless tested).
- Phantom Tooltip Fix: If a tooltip appears even after disabling it, adjust the 'Image size' in the Format pane to force a re-render.

RULE 6 — AXIS NORMALIZATION (conditional - only if the visual needs it)
- If the visual plots a value as a position or width along a shared scale (bar chart, gauge, linear progress track, sparkline), calculate the axis min/max ONCE across the full comparison scope before computing any position - e.g. CALCULATE(MAXX(ALLSELECTED(<category column>), <measure>), REMOVEFILTERS(<category column>)), and the equivalent MINX for the minimum. Use that shared range to convert each row's value into a position, not each row's own value in isolation.
- If the visual has a fixed, self-contained range that doesn't depend on other rows (a 0-5 star rating, a single-value badge, a fixed 0-100% ring), this does not apply - skip it.

DESIGN PHILOSOPHY
Prefer the easiest-to-maintain, least-likely-to-break implementation, not the shortest or cleverest.

Now build the following visual:

[DESCRIBE YOUR VISUAL HERE — chart type, measures/columns, colors, logic, target size/column]