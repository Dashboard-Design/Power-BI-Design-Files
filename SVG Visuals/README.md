# 🎨 Power BI SVG Toolkit

**Write bulletproof, dynamic, and pixel‑perfect SVG measures in Power BI DAX.**

This folder contains the definitive, best practices and an AI‑ready prompt template to help you build scalable, responsive, and high‑performance SVG visuals directly inside Power BI.

***

##  Visual Gallery

### 1. Dynamic Bullet Points
<p align="center">
<img width="700" alt="Dynamic Bullet Points" src="https://github.com/user-attachments/assets/f001cc26-356f-4f51-974f-cff5d8171848" />
</p>

***

### 2. Matrix Bubble Chart
<p align="center">
<img width="700" alt="Matrix Bubble Chart" src="https://github.com/user-attachments/assets/9f47f0dc-0c4c-406c-9e33-6d410d7ea803" />
</p>

***

### 3. Pill Slicer
<p align="center">
<img width="700" alt="pill-slicer-SVG" src="https://github.com/user-attachments/assets/9ae0bb73-c952-4849-a4b7-ed57995c454b" />
</p>

***

### 4. Pill Status Visual
<p align="center">
<img width="700" alt="text-highlight-SVG" src="https://github.com/user-attachments/assets/bdca86dc-8c93-4f32-908f-1354416634aa" />
</p>

***

### 5. Radar Chart
<p align="center">
<img width="700" alt="Radar Chart" src="https://github.com/user-attachments/assets/2de73903-26b5-4271-a09e-108cf61e20fe" />
</p>

***

### 6. Ranking Styles
<p align="center">
<img width="700" alt="Dynamic Ranking + Pareto Analysis" src="https://github.com/user-attachments/assets/35323fbe-be80-43e4-999f-cf80759b294a" />
</p>

***

### 7. Scatter Plot with Images
<p align="center">
<img width="700" alt="Cars Sales" src="https://github.com/user-attachments/assets/c4a546ad-8611-46f5-aaff-f025e9f733e3" />
</p>

***

### 8. Target Line Bar Chart
<p align="center">
<img width="700" alt="Target Line Bar Chart SVG" src="https://github.com/user-attachments/assets/f8528282-72f9-40e3-b87c-f1cda6eb6fca" />
</p>

***

## 🚀 Why Use SVG in Power BI?

Leveraging inline SVG images (via DAX measures) is the **best way to customize Power BI visuals** without sacrificing performance or maintainability.

- **Unmatched Customization**  
  Native Power BI visuals are rigid. SVG unlocks infinite design possibilities—from custom KPI cards and traffic lights to complex bar charts and gauges, all tailored to your exact brand and logic.

- **Lightning-Fast Performance**  
  Unlike third‑party custom visuals (which rely on JavaScript and external APIs), inline SVGs are **native to the browser**. They are rendered as vector text, requiring no extra downloads, no dependency delays, and no performance overhead—even across thousands of rows.

- **Resolution‑Independent**  
  SVGs scale to any screen size or zoom level.

***

## 📍 Where Can You Use SVGs in Power BI?

I have mapped out all **7 entry points** where you can leverage SVG images inside Power BI:

<img width="1080" height="1350" alt="7-places-where-you-can-use-svg-images-in-power-bi" src="https://github.com/user-attachments/assets/525e8d5d-b181-473d-9a5a-0c95779f4514" />


1.  **Table Visual** – Mini bar charts, KPI traffic lights, and trend arrows right inside your rows.
2.  **Matrix Visual** – Hierarchical icons that auto‑scale across collapsible rows and columns.
3.  **Button Slicer & List Slicer** – Turn boring dropdowns into sleek, interactive tab‑like toggle controls.
4.  **New Card Visual** – Retina‑ready KPI accents, sparklines, and branded overlays.
5.  **Azure Map Visual Markers** – Custom geo‑pins that stay sharp at every zoom level.
6.  **Image Visual** – Standalone vector illustrations that scale infinitely (PDF exports love this).
7.  **SVG Icon Theme.json Injection** – The hidden gem: manage global icon libraries directly in your Theme file for enterprise‑wide branding.

***

## 📂 Repository Contents

### 1. [SVG_BEST_PRACTICES.md](SVG_BEST_PRACTICES.md)
The **definitive 17‑point checklist**.  
This document is ordered by severity—**Critical**, **Important**, and **Best Practice**—so you can troubleshoot broken measures instantly. It covers:

### 2. [SVG_PROMPT_TEMPLATE.md](SVG_PROMPT_TEMPLATE.md)
An **AI prompt template** (compatible with ChatGPT, Claude, etc.).  
Paste this into your preferred LLM, describe the visual you want at the end, and the AI will generate a DAX measure that adheres strictly to all the rules in the Best Practices guide—saving you hours of debugging.

***

## ⚡ Quick Start (How to Use This Repository)

1.  **Copy the AI Prompt Template**  
    - Go to [SVG_PROMPT_TEMPLATE.md](SVG_PROMPT_TEMPLATE.md).  
    - Copy the entire block and paste it into your AI chat.  
    - Append a description of your visual (e.g., *"A green checkmark for values > 100, red cross for values < 100"*).

2.  **Validate with the Checklist**  
    - Take the AI‑generated DAX code and run it against the **"Final Pre‑Flight Scan"** in the [SVG_BEST_PRACTICES.md](SVG_BEST_PRACTICES.md).  
    - Ensure the measure starts with the correct data URI, all `#` are `%23`, and all `%` are `%25`.

3.  **Set up Power BI**  
    - Create a new DAX measure.
    - Paste the AI DAX-SVG result.  
    - In the Power BI model view, set the measure's **Data category** to **"Image URL"** (otherwise it renders as plain text).

4.  **Drop it into your report** – Add the measure to a Table, Matrix, Card, or any of the 7 places listed above.

***

## 🛠️ Troubleshooting (Quick Wins)

- **Black box / broken icon?** → Check the Data Category. It must be **"Image URL"**.  
- **SVG renders as black lines?** → You missed a `%23` in a color. Scan for `#`.  
- **Shapes are cut off?** → You forgot `overflow="visible"` or the `viewBox` padding (`-2 -2`).  
- **Tooltip still appears after disabling it?** → Adjust the `Image Size` (height/width) in the visual's Format pane (Table / Matrix visual) to force a re‑render (Phantom Tooltip fix).


**Happy Visualizing!**  🚀
