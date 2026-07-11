# SVG-in-Power-BI Prompt Template

Paste this block before your own request, then describe the visual you want at the
end. Works with any LLM. Based on `SVG_BEST_PRACTICES.md` — if that document
changes, update this template to match.

---

```
You are generating a DAX measure for Power BI that renders as an inline SVG image
(a "data:image/svg+xml;utf8,..." data URI). Follow these rules strictly, regardless
of what specific visual I ask you to build:

SIZING
- Set width="100%25" and height="100%25" on the root <svg> (note: %25, not a raw
  %, per the ENCODING rules below), so it fills whatever cell, column, or card
  slot Power BI gives it — unless I explicitly ask for a fixed pixel size for a
  specific known column width.
- Always include a viewBox that matches the actual coordinate space of the
  drawing.
- Add display="block" to the root <svg> to remove the default inline baseline
  gap that can throw off vertical centering.
- Given a target drawing size of W x H, always pad the viewBox and pair it with
  overflow="visible" together, both at once:
      viewBox="-2 -2 W+2 H+2"
      overflow="visible"
  The padding alone only protects the top/left edges (the bottom/right boundary
  lands exactly at the original W/H with no margin) — overflow="visible" is what
  protects the rest, including any marker or stroke that deliberately sits just
  outside the main shape. Always include both together, never just one.
- Only use preserveAspectRatio="none" for simple linear shapes (bars, lines,
  progress tracks) where stretching doesn't visually break the shape. Never use
  it for icons, logos, circles, maps, or text.

ENCODING — check this last, it is the most common way these measures break
- This is a data:image/svg+xml;utf8,... URI: the ENTIRE string is percent-decoded
  in one pass before the SVG is parsed. A single invalid escape sequence (a %
  not followed by two hex digits) breaks decoding for the WHOLE string, not just
  one attribute.
- Every literal # must be written as %23. Every literal % must be written as
  %25 — including inside width="100%" (write width="100%25") and inside any
  formatted percentage label (write "72%25", not "72%").
- Before finishing, re-scan the entire returned string for any % character and
  confirm every single one is immediately followed by exactly two hex digits.
  This check applies even when only editing one part of an existing measure —
  adding width="100%" while fixing something else is enough to reintroduce this
  bug elsewhere in the same string.

DAX / STRING CONSTRUCTION
- Use single quotes for every SVG attribute value, so the DAX string only needs
  double quotes at its own outer boundary.
- Splice DAX variables into the string using this one pattern, consistently:
  attr='" & VariableName & "'
  Do not mix in other nested-quote styles within the same measure.
- Wrap the final RETURN in IF(HASONEVALUE(<the relevant column>), <svg string>,
  BLANK()), so the measure doesn't render a misleading icon when multiple values
  are in the current filter context.
- Give any color that might reasonably need conditional formatting later
  (status colors, above/below-target coloring, thresholds) its own VAR rather
  than hardcoding the hex value directly in the markup.

PERFORMANCE
- No XML prolog (no <?xml version="1.0"?>).
- No unused namespaces — only include xmlns:xlink if xlink:href is actually used.
- Keep the markup compact: no unnecessary whitespace, no leftover comments. This
  string gets evaluated once per row, so bloat has a real rendering cost at scale.

COMPATIBILITY
- Do not use SVG filters (feGaussianBlur, feDropShadow, etc.) — rendering
  support is inconsistent across Power BI Desktop, the Service, mobile, and
  PDF/export.
- Do not embed raster images or reference external files via xlink:href.
- Do not use <foreignObject> with embedded CSS/@media queries unless I
  specifically ask for that technique and confirm I'll test it across every
  surface I plan to view the report on — its behavior is not guaranteed to be
  consistent across renderers.

Now build the following visual:

[DESCRIBE YOUR VISUAL HERE — chart type, the measures/columns involved, colors
and conditional logic, and the approximate target size or column it will live in]
```

---

### Notes on using this

- If you *want* a fixed pixel size on purpose (matching a specific, controlled
  column width), say so explicitly in your visual description — the template
  defaults to responsive sizing otherwise.
- If your visual genuinely needs complex, modular VAR composition (e.g. a
  multi-part gauge chart with computed geometry), that's expected and fine — the
  "keep it simple" structure guidance in the best-practices doc is about avoiding
  *unnecessary* fragmentation, not banning modularity outright.
- This template doesn't cover DAX correctness (whether `HASONEVALUE` targets the
  right column, whether your measures resolve correctly) — it only covers the
  SVG/markup conventions. You still need to check the generated DAX logic itself.
- If you'd rather avoid percent-encoding entirely, `data:image/svg+xml;base64,...`
  has no reserved characters to escape — but DAX has no built-in base64 encoder,
  so this needs a community helper function rather than a one-line swap. Ask for
  this explicitly if you want it; the template defaults to the `;utf8,` form.
