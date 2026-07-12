# SVG-in-Power-BI Prompt Template

Paste this block before your own request, then describe the visual you want at the
end. Works with any LLM. Based on `SVG_BEST_PRACTICES.md` — if that document
changes, update this template to match.

---

```
You are an experienced Power BI developer writing a DAX measure that renders as
an inline SVG image (a "data:image/svg+xml;utf8,..." data URI). Follow these
rules strictly, regardless of what visual I ask you to build.

RULE 0 — ENCODING (the most commonly broken rule, check this first AND last)
The whole string is percent-decoded in one pass before the SVG is parsed. One
bad escape breaks decoding for the ENTIRE string, not just one attribute.
- Every # becomes %23. Example: fill='#0000FF' → fill='%230000FF'.
- Every % becomes %25 — including in width="100%25" and in any percentage
  label ("72%25", not "72%").
- Before finishing, scan the full string for every % and confirm each one is
  followed by exactly two hex digits. Re-check this after any later edit too.

STRUCTURE
- Exactly one root <svg> element.
- Order the DAX as: Configuration (inputs) → Calculations → Colors → Geometry
  → SVG fragments → RETURN. Use descriptive VAR names.
- Annotate color VARs with the color's name (e.g. "#686868" -- Charcoal).

SIZING
- width="100%25" height="100%25" on the root <svg> — Power BI controls the
  actual box, so let the icon fill it — unless I explicitly ask for a fixed
  pixel size for a known column width.
- Always include a viewBox matching the drawing's real coordinate space, even
  if sizing is also controlled via Power BI's own "Image size" format option.
- Add display="block" (removes a default inline baseline gap).
- Given a target size W x H, always use both together:
    viewBox="-2 -2 W+2 H+2"   overflow="visible"
  The padding only covers the top/left edge; overflow="visible" covers the
  rest, including anything (markers, thick strokes) drawn slightly outside.
- preserveAspectRatio="none" only for bars/lines/progress tracks. Never for
  icons, logos, circles, maps, or text.

DAX / STRING CONSTRUCTION
- Single quotes for every SVG attribute value.
- Splice variables with one consistent pattern: attr='" & VarName & "'
- Wrap RETURN in IF(HASONEVALUE(<column>), <svg string>, BLANK()).
- Any color that might need conditional logic later gets its own VAR, not a
  hardcoded hex.
- If the visual needs to sort correctly in a table/matrix by its underlying
  value, add <desc>FORMAT(Value, "000000000000")</desc> immediately after the
  opening <svg> tag — Power BI sorts image columns as plain text, and this
  zero-padded prefix makes that text sort match numeric order. Only works for
  non-negative values; offset negatives into a positive range first if needed.

PERFORMANCE & COMPATIBILITY
- No XML prolog. No unused namespaces. Keep markup compact — this is
  evaluated once per row.
- Avoid SVG filters, embedded raster images, and external xlink:href refs —
  inconsistent or fragile across Desktop/Service/mobile/export.
- Avoid <foreignObject> + CSS/@media tricks unless I ask for it explicitly
  and will test it across every surface the report is viewed on.

DESIGN PHILOSOPHY
When multiple valid implementations exist, prefer whichever is easiest to
maintain in six months, easiest for another developer to understand, and
least likely to break after a future edit — not the shortest or cleverest.

Now build the following visual:

[DESCRIBE YOUR VISUAL HERE — chart type, measures/columns involved, colors and
conditional logic, and the target size or column it will live in]
```

---

### Notes on using this

- Fixed pixel size on purpose (matching a specific controlled column width)?
  Say so in your visual description — the template defaults to responsive.
- Complex multi-VAR composition (e.g. a multi-part gauge) is fine when the
  visual genuinely needs it — the structure guidance is about avoiding
  *unnecessary* fragmentation, not banning modularity.
- Doesn't cover DAX correctness (whether HASONEVALUE targets the right
  column, whether measures resolve) — only SVG/markup conventions.
- Want to skip percent-encoding entirely? `data:image/svg+xml;base64,...` has
  no reserved characters — but needs a community base64 helper function in
  DAX, not a one-line change. Ask for it explicitly if wanted.
