# Radar Chart

<img width="1094" height="800" alt="Image" src="https://github.com/user-attachments/assets/e0b7d7b6-f9b4-4bdf-9662-f105563c9349" />

## Radar Chart for Power BI – Implementation Guide
This guide covers two proven approaches for rendering a dynamic, responsive radar chart (11 metrics) in Power BI using DAX-generated code. Both methods use identical coordinate logic (CX=90, CY=90, viewBox="-25 -10 230 200"), meaning they swap seamlessly into the same screen space.

### Approach 1: DAX SVG (Native Image Visual)
Best for: Tables, matrices, or when you need a lightweight, portable solution without custom visuals.
How it works: The DAX measure returns a data:image/svg+xml;utf8 URI. Power BI renders it as an image.

### Approach 2: HTML Viewer (Custom Visual)
Best for: Interactive reports requiring hover tooltips, data point details, or smooth transitions.
How it works: The DAX measure returns pure HTML/SVG markup embedded inside a <div>. The custom visual renders it natively in a Chromium-based frame, supporting full CSS.
