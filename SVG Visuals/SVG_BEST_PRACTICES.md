# The Ultimate Guide to SVG Measures in Power BI DAX (v2.1)

This guide consolidates everything you need to write bulletproof, maintainable SVG visuals in Power BI. The rules are ordered by severity so you can troubleshoot in the right sequence.

---

## 1. Executive Summary (The Golden Rules)
- **Start** your RETURN with `"data:image/svg+xml;charset=utf-8,"`.
- **Set** the measure's Data Category to **"Image URL"** in the Power BI model.
- **Encode** every `#` as `%23` and every `%` as `%25`.
- **Always** include a `viewBox` and pair it with `overflow="visible"`.
- **Use** single quotes (`'`) for SVG attributes, and splice variables with `attr='" & Var & "'`.

---

## 2. The Definitive 17-Point Checklist

### 🔴 CRITICAL (Skipping these breaks the measure entirely)

#### 1. The Mandatory Data URI Prefix
**Action:** Every RETURN must start with:
"data:image/svg+xml;charset=utf-8," & <Your SVG>

**Caution:** The trailing comma (`,`) is non-negotiable. Omitting it breaks the image.

---

#### 2. The One-Pass Percent-Encoding Rule
**Why:** The URI is decoded *before* SVG parsing. One bad `%` crashes the whole string.
**Action:**
- Every literal `#` → `%23` (e.g., `fill='%230000FF'`).
- Every literal `%` → `%25` (e.g., `width="100%25"`, `"72%25"`).
**Self-Check:** Scan your final string for *every* `%` and confirm each is followed by exactly two hex digits (0-9, A-F).

---

#### 3. The `viewBox` is Non-Negotiable
**Action:** Always declare `viewBox="0 0 W H"` (where `W` and `H` are your drawing's logical size). Without it, the browser guesses the coordinate space.

---

#### 4. Power BI Data Category Setting (UI Critical)
**Action:** In the Power BI model view, select your measure. Under "Properties" / "Formatting", set the **Data category** to **"Image URL"**.
**Why:** Without this, Power BI renders the DAX string as plain text, not an image.

---

#### 5. DAX String Construction (Single Quotes & Splicing)
**Rule:** DAX uses double-quotes (`"`) for strings. To avoid messy escaping:
- Use **single quotes** (`'`) for *all* SVG attribute values.
- Splice variables consistently:

"<svg attr='" & VariableName & "' />"

**Bad (avoid):** `"<svg attr=""" & Var & """>"` — this is error-prone and unreadable.

---

### 🟡 IMPORTANT (Skipping these causes visual glitches)

#### 6. The Padding + Overflow Pair (Prevents Clipped Edges)
**Action:** Always use these together, never one without the other:

viewBox="-2 -2 W+2 H+2"
overflow="visible"
*(Where `W` and `H` are your original dimensions). This handles stroke overhang and markers.*

---

#### 7. `width` and `height` Strategy
**Default:** Set `width="100%25"` and `height="100%25"` to fill the container responsively.
**Opt-in Fixed:** If you rely on Power BI's "Image size" format pane instead, add a comment in DAX: `-- Assumes Image Size = 100x20 in Format pane`.

---

#### 8. Remove the Inline Baseline Gap
**Action:** Add `display="block"` to the root `<svg>` to remove the small text-baseline gap.

---

#### 9. `preserveAspectRatio` Restrictions
- Use `preserveAspectRatio="none"` **ONLY** for simple bars/lines/progress tracks.
- **Never** use it for icons, logos, circles, maps, or text (it distorts them).

---

### 🔵 BEST PRACTICE (Ensures maintainability & performance)

#### 10. The `HASONEVALUE` Wrapper (For Totals/Subtotals)
**Action:** Wrap your RETURN to prevent broken images in aggregates:
IF(
HASONEVALUE( 'Table'[Column] ),
<svg_string>,
BLANK()
)
*(Replace `'Table'[Column]` with the column your visual is grouped by).*

---

#### 11. Consistent Variable Interpolation (No Mixing)
**Action:** Stick to exactly one pattern everywhere:
attr='" & VariableName & "' -- Correct
**Avoid this legacy mess:** `"&"'"&Var&"'"&"` — it confuses both humans and AI tools.

---

#### 12. Color Variables (Encoding + Comments)
**Action:** 
- Store every color as a `VAR`.
- Encode the hex immediately: `VAR _FillColor = "%231F3A2E"`.
- Add a comment: `-- Charcoal / Dark Green`.

---

#### 13. Logical DAX Structure
**Action:** Order your measure strictly as:
`Configuration (Inputs)` → `Calculations` → `Colors` → `Geometry (SVG fragments)` → `RETURN`.

---

#### 14. Sorting by Underlying Value (Tables/Matrices)
**Why:** Power BI sorts image columns alphabetically by the SVG string, not the numeric value.
**Action:** Insert a zero-padded `<desc>` tag as the **first child** after `<svg>`:

<desc>FORMAT([Value], "000000000000")</desc>
*(Works for non-negative values; offset negatives into a positive range first).*

---

#### 15. Performance Minification
**Action:** 
- No XML prolog (`<?xml version="1.0"?>`).
- No unused namespaces (only `xmlns:xlink` if used).
- Remove all unnecessary whitespace and comments (except your color annotations).

---

#### 16. Cross-Renderer Compatibility & Phantom Tooltips
**Avoid:** SVG filters, embedded rasters, external `xlink:href` refs, and `foreignObject`+CSS tricks (unless tested everywhere).
**🛠️ Phantom Tooltip Fix:** If a default tooltip pops up even after disabling tooltips in the Matrix/Table settings, go to the visual's Format pane, find **"Image size"**, and tweak the height/width slightly. This forces a re-render and clears the cached hover artifact.

---

#### 17. The Final Pre-Flight Scan
Before publishing, manually check:
- [ ] Does it start with `data:image/svg+xml;charset=utf-8,`?
- [ ] Is the Data Category set to **"Image URL"**?
- [ ] Are all `#` replaced with `%23`?
- [ ] Are all `%` followed by exactly two hex digits (including `%25`)?

---
