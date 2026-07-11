# Best Practices: Writing SVGs in Power BI DAX Measures

This is the consolidated rule set behind SVG Cleaner and the SVG prompt template.
Every rule here is either a **default** (apply unless there's a stated reason not
to) or a **caution** (situational — flag it, don't silently apply or silently
ignore it).

---

## 1. Sizing & responsiveness

**Default: fill the container, don't hardcode pixels.**

- `width="100%25"` and `height="100%25"` on the root `<svg>` — Power BI controls the
  actual render box (table cell, column, card slot) and no DAX measure can read its
  live pixel size, so the icon should always be told to fill whatever it's given.
  (Note the `%25`, not `%` — see Section 2, "Encoding," for why this matters.)
- Always include a `viewBox` that matches the drawing's real coordinate space. If
  a fixed pixel size is used instead of `viewBox`, derive one from it.
- A genuinely fixed pixel size (e.g. Kerry Kolosko's `width='100' height='20'`) is
  a legitimate, deliberate choice when the target column width is known and
  controlled — it's not automatically wrong, just a different design decision.
  State it explicitly rather than defaulting to it.
- `display="block"` on the root `<svg>` — by default an inline SVG behaves like
  inline text and reserves a small baseline gap below it, which can throw off
  vertical centering by a few pixels. There is no downside to setting this.
- Only use `preserveAspectRatio="none"` for simple linear shapes (bars, lines,
  progress tracks) where non-uniform stretching doesn't visually break the shape.
  Never use it for icons, logos, circles, maps, or text.

**Default: pad the viewBox and pair it with `overflow="visible"`.**

Given a drawing designed for a target size of `W` × `H`:

```
viewBox="-2 -2 W+2 H+2"
overflow="visible"
```

Both parts together, always — not either alone:

- The `-2 -2` origin shift and `W+2 H+2` size protect the **top and left** edges
  from stroke overhang (strokes are centered on their path, so a 2px stroke spills
  1px outside its nominal bounding box) and from markers that intentionally sit
  just outside the main track.
- This formula does **not** add any margin on the bottom or right edge — the
  bottom/right boundary lands exactly at the original `W`/`H`. `overflow="visible"`
  is what actually protects that side, and any content deliberately drawn slightly
  outside bounds (e.g. a target-line marker), from being clipped. The two rules
  are a pair; padding alone does not fully contain typical chart artwork.
- Honest trade-off: `overflow="visible"` also removes SVG's own safety net against
  a genuinely broken calculation (e.g. a data outlier making a computed width far
  exceed the expected range) — such a bug would spill into a neighboring cell's
  visual space instead of clipping quietly. Accepted trade-off, not a hidden one.

**Opt-in: rescaling to a known target size.**

- If a specific target width/height is known, rescale the artwork into it by
  wrapping the existing content in one `<g transform="translate(...) scale(...)">`
  and setting the viewBox to the target size — never by just changing the
  `viewBox` declaration and leaving the content's coordinates untouched, which
  only shrinks the drawing into a corner of the new canvas.

---

## 2. Encoding — the single most common way these measures break

`data:image/svg+xml;utf8,...` is decoded in **one pass over the entire string**
before the SVG is parsed at all. Any `%` not immediately followed by two valid hex
digits is an invalid escape sequence, and most decoders **abort the whole decode**
on the first invalid one — not just the one attribute it appeared in.

- **Every literal `#` must be written as `%23`** (raw `#` can be read as a URL
  fragment delimiter, truncating the string).
- **Every literal `%` must be written as `%25`** — including the one in
  `width="100%"` / `height="100%"` (→ `width="100%25"`), and the one in a
  formatted percentage label (`"72%"` → `"72%25"`).
- **One missed instance anywhere breaks decoding for the entire SVG, not just that
  attribute.** The observed symptom is specific and easy to recognize: every color
  silently renders as SVG's default fill (black), and any percent sign in text
  prints literally as `%` or `%25` instead of being interpreted — because none of
  the string decoded correctly past the first bad escape.
- **Self-check before shipping a measure:** search the full returned string for
  any `%` character and confirm every single one is followed by exactly two hex
  digits. This includes ones introduced by editing an existing working measure —
  it's easy to add `width="100%"` to fix sizing and reintroduce this bug in the
  same edit.
- **To sidestep this class of bug entirely:** switch to
  `data:image/svg+xml;base64,<base64-encoded SVG>` instead of `;utf8,`. Base64 has
  no reserved characters to escape, so there's nothing to get wrong — but DAX has
  no built-in base64 encoder, so this requires a community-built helper function
  rather than a one-line change.

---

## 3. DAX / string construction hygiene

- Use **single quotes** for SVG attribute values throughout. This avoids DAX's
  `""`-escaping entirely for the SVG's own markup, since only the outer DAX string
  boundary needs double quotes.
- Splice DAX variables into the string with **one consistent pattern**:
  `attr='" & VariableName & "'` — not a mix of styles in the same measure (e.g.
  avoid the double-nested `"&"'"&Var&"'"&"` variant appearing alongside the
  cleaner form in the same file).
- Wrap the final `RETURN` in `IF(HASONEVALUE(<column>), <svg string>, BLANK())` so
  the measure doesn't render a misleading or broken icon when multiple values are
  in the current filter context.
- Any color that might reasonably need conditional formatting later (status
  colors, thresholds, above/below-target coloring) should be its own `VAR`, not a
  hardcoded hex value — this is what makes an icon governable later rather than
  requiring a hand-edit of the SVG markup.

---

## 4. Performance

The SVG string is evaluated once per row/cell — bloat here has a real, measurable
rendering cost at scale, not just a tidiness cost.

- No XML prolog (`<?xml version="1.0"?>`).
- No unused namespaces — only include `xmlns:xlink` if `xlink:href` is actually used.
- Minify: no unnecessary whitespace, no leftover editor/generator comments.

---

## 5. Compatibility across renderers

Power BI reports render across genuinely different engines: Desktop's internal
browser control, the Service's browser, native mobile webviews, and the PDF/export
pipeline. Anything relying on subtle CSS/rendering behavior should be treated with
extra caution.

- **Avoid SVG filters** (`feGaussianBlur`, `feDropShadow`, etc.) — support is
  inconsistent across these engines.
- **Avoid embedded raster images** or external `xlink:href` references — both
  bloat the measure or are fragile outside the authoring environment.
- **`<foreignObject>` with embedded CSS custom properties / `@media` queries** is
  a genuinely clever way to get threshold-based responsive behavior (e.g.
  reacting to a `max-height` breakpoint), but it reacts at discrete breakpoints
  rather than continuously scaling, and its cross-renderer behavior is not
  guaranteed. Treat this as an advanced, opt-in technique for someone who has
  tested it across every surface the report will actually be viewed on — not a
  default recommendation.

---

## 6. Structure

- Prefer building the SVG as one string-literal-and-splice chain (a single `VAR`
  or a simple concatenation) over spreading it across many separate VARs with
  real DAX logic in between, when the complexity of the visual allows it. This
  isn't just a style preference — highly modular composition is also what makes a
  measure hard for any tool (including SVG Cleaner) to safely analyze.
- For genuinely data-driven, complex visuals (bar/gauge charts with computed
  geometry), modular VARs are appropriate and expected — the guidance above is
  about not introducing unnecessary fragmentation, not banning it outright.
