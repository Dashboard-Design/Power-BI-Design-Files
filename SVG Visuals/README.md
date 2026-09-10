# 🎨 Power BI SVG Toolkit

**Write bulletproof, dynamic, and pixel‑perfect SVG measures in Power BI DAX.**

This folder contains the definitive, best practices and an AI‑ready prompt template to help you build scalable, responsive, and high‑performance SVG visuals directly inside Power BI.

---

##  Visual Gallery

### 1. Dynamic Bullet Points
<img src="./Dynamic Bullet Points/Dynamic Bullet Points.png" alt="Dynamic Bullet Points" width="400"/>

**What it does:** Creates interactive, conditional bullet point lists that adapt based on your data values. Perfect for executive summaries and automated insights.

**Use cases:**
- Automated commentary generation
- Dynamic KPI summaries
- Conditional text formatting with icons

---

### 2. Matrix Bubble Chart
<img src="./Matrix Bubble Chart/Matrix Bubble Chart.png" alt="Matrix Bubble Chart" width="400"/>

**What it does:** Transforms matrix visuals into interactive bubble charts where size and color represent different metrics simultaneously.

**Use cases:**
- Portfolio analysis
- Market segmentation
- Multi-dimensional performance tracking

---

### 3. Pill Slicer
<img src="./Pill Slicer/Pill Slicer.png" alt="Pill Slicer" width="400"/>

**What it does:** Modern, pill-shaped slicer buttons that provide a sleek alternative to standard Power BI slicers with custom styling and states.

**Use cases:**
- Category filtering
- Time period selection
- Multi-select options with visual feedback

---

### 4. Pill Status Visual
<img src="./Pill Status Visual/Pill Status Visual.png" alt="Pill Status Visual" width="400"/>

**What it does:** Status indicators in pill/badge format showing real-time metrics with conditional coloring and dynamic text.

**Use cases:**
- Status badges (Active/Inactive/Pending)
- Performance indicators
- Workflow stage visualization

---

### 5. Radar Chart
<img src="./Radar Chart/Radar Chart.png" alt="Radar Chart" width="400"/>

**What it does:** Multi-dimensional radar/spider charts built entirely with SVG in DAX, perfect for competency assessments and comparative analysis.

**Use cases:**
- Skills assessment
- Product comparison
- Performance profiling across multiple dimensions

---

### 6. Ranking Styles
<img src="./Ranking Styles/Ranking Styles.png" alt="Ranking Styles" width="400"/>

**What it does:** Creative ranking visualizations with custom icons, medals, and positional indicators that go beyond simple numbers.

**Use cases:**
- Leaderboards
- Top N analysis
- Competitive positioning

---

### 7. Scatter Plot with Images
<img src="./Scatter Plot with Images/Scatter Plot with Images.png" alt="Scatter Plot with Images" width="400"/>

**What it does:** Enhanced scatter plots using SVG images as data points, allowing for rich visual encoding and brand integration.

**Use cases:**
- Quadrant analysis (BCG matrix, risk vs reward)
- Correlation studies with visual context
- Custom marker designs

---

### 8. Target Line Bar Chart
<img src="./Target Line Bar Chart/Target Line Bar Chart.png" alt="Target Line Bar Chart" width="400"/>

**What it does:** Bar charts with integrated target/goal lines and variance indicators, all rendered in SVG for maximum customization.

**Use cases:**
- Budget vs actual comparisons
- KPI tracking against targets
- Performance gap analysis

---

### 9. Variance Chart, IBCS Style
<img src="./Variance Chart, IBCS Style/Variance Chart, IBCS Style.png" alt="Variance Chart, IBCS Style" width="400"/>

**What it does:** Professional variance charts following IBCS (International Business Communication Standards) for clear, standardized business reporting.

**Use cases:**
- Financial variance analysis
- Month-over-month comparisons
- Executive reporting with IBCS compliance

---


## 🚀 Why Use SVG in Power BI?

Leveraging inline SVG images (via DAX measures) is the **best way to customize Power BI visuals** without sacrificing performance or maintainability.

- **Unmatched Customization**  
  Native Power BI visuals are rigid. SVG unlocks infinite design possibilities—from custom KPI cards and traffic lights to complex bar charts and gauges, all tailored to your exact brand and logic.

- **Lightning-Fast Performance**  
  Unlike third‑party custom visuals (which rely on JavaScript and external APIs), inline SVGs are **native to the browser**. They are rendered as vector text, requiring no extra downloads, no dependency delays, and no performance overhead—even across thousands of rows.

- **Resolution‑Independent**  
  SVGs scale to any screen size or zoom level.

---

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

---

## 📂 Repository Contents

### 1. [SVG_BEST_PRACTICES.md](SVG_BEST_PRACTICES.md)
The **definitive 17‑point checklist**.  
This document is ordered by severity—**Critical**, **Important**, and **Best Practice**—so you can troubleshoot broken measures instantly. It covers:

### 2. [SVG_PROMPT_TEMPLATE.md](SVG_PROMPT_TEMPLATE.md)
An **AI prompt template** (compatible with ChatGPT, Claude, etc.).  
Paste this into your preferred LLM, describe the visual you want at the end, and the AI will generate a DAX measure that adheres strictly to all the rules in the Best Practices guide—saving you hours of debugging.

---

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

---

## 🛠️ Troubleshooting (Quick Wins)

- **Black box / broken icon?** → Check the Data Category. It must be **"Image URL"**.  
- **SVG renders as black lines?** → You missed a `%23` in a color. Scan for `#`.  
- **Shapes are cut off?** → You forgot `overflow="visible"` or the `viewBox` padding (`-2 -2`).  
- **Tooltip still appears after disabling it?** → Adjust the `Image Size` (height/width) in the visual's Format pane (Table / Matrix visual) to force a re‑render (Phantom Tooltip fix).


**Happy Visualizing!**  🚀
