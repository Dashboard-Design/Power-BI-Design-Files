# Interactive Dashboard Walkthrough — HTML Content Secure

Create a guided, game-like walkthrough for your Power BI report using **HTML Content Secure (the certified HTML Content custom visual)**.

<img width="1920" height="1080" alt="Walkthrough Project" src="https://github.com/user-attachments/assets/0aee2401-b131-418c-b889-86ce5ca3b676" />

## How to Use

1. Install the **HTML Content Secure** certified custom visual in Power BI.
2. Identify the dashboard sections you want to explain, such as KPI cards, line charts, tables, and other visuals.
3. Provide your AI agent with the section names, their purposes, and their exact positions and dimensions. If measuring manually, specify each visual's horizontal position, vertical position, width, and height in pixels.
4. Add the generated HTML measure to the visual and align it with the report canvas.

The walkthrough should use a spotlight overlay to highlight one section at a time, with explanatory text, animated arrows, and navigation controls such as **Next**, **Back**, **Skip**, and **Finish**.

## Limitations

HTML Content Secure sanitizes HTML, CSS, attributes, and SVG according to its supported allowlists.

- JavaScript, `<script>` elements, form controls, unsupported HTML tags, and inline event handlers cannot be relied upon.
- External scripts, web fonts, stylesheets, and other external resources are restricted.
- Animations and interactions must use techniques supported by the certified visual, such as CSS animations and permitted native HTML elements.
- Not every interaction available in a standalone web page will work inside Power BI.

Read the [official sanitization documentation](https://html-content.com/docs/sanitization) and [accepted-tags reference](https://html-content.com/docs/accepted-tags) before developing the walkthrough.

## What to Ask Your AI Agent

Use the following prompt as a starting point:

> Build an interactive, game-like walkthrough for my Power BI dashboard using HTML Content Secure, the certified HTML Content custom visual.
>
> The walkthrough must be implemented with self-contained HTML and CSS, without JavaScript, external dependencies, unsupported tags, form controls, or inline event handlers.
>
> Use only HTML elements, attributes, CSS features, and SVG features supported by the certified visual. Check the official documentation before choosing an implementation.
>
> Create a guided walkthrough with multiple steps. Each step should highlight a specified dashboard section using a spotlight overlay, explain its purpose, and provide navigation controls wherever the certified visual permits. Use CSS-driven state changes and supported native HTML interactions rather than JavaScript.
>
> Use the provided coordinates and dimensions to position the spotlight accurately. Keep the overlay transparent except for the opaque white veil outside the highlighted region. Follow my dashboard's design system and use smooth transitions, animated arrows, readable typography, and clear progress indicators.
>
> Do not create a mock dashboard. Produce code specifically for rendering inside the certified Power BI visual. Explain any requirements that cannot be met under its restrictions, and validate the markup against the accepted tags and attributes. Include a testing checklist for Power BI Desktop.

**Important:** Test the result inside the actual certified visual, not just in a browser. Use its diagnostics to identify content removed by the sanitizer and revise the implementation accordingly.
