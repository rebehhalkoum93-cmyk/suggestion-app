# Comprehensive UI/UX Specification Document

**Project:** Questionnaire-Based Media Recommendation App  
**Target Audience:** Frontend Developers / UI Engineers  
**Design Philosophy:** Component-Driven Architecture (Atomic Design) / Multi-Theme Layout Reuse  

---

## 1. Global Design System & Design Tokens

The application utilizes a shared structural template system. Layout structural architectures remain identical across category flows, but visual style variables change dynamically based on the current active application state (Music, Movie, or Series).

### 1.1 Color Systems & Theme Mapping
* **Base Core Background:** Black (`#000000`), uniform across all screens.
* **Ambient Lighting Effect:** Blurred background radial mesh spots positioned dynamically to add depth.
* **Dynamic Theme States:**
  * **Music Flow:** Electric Blue (`#0000FF` / Light Neon Accents)
  * **Movie Flow:** Vibrant Cyan (`#00D2FF` / Aqua Marine)
  * **Series Flow:** Crimson Red (`#E50914` / Pure Red)

### 1.2 Typography & Alignment Tokens
* **Primary System Font:** Geometric Sans-Serif (e.g., Poppins, Inter, or Montserrat).
* **Case Standards:**
  * Context Prompts & Header Strings: Sentence case (*"Please answer the following questions"*).
  * Navigation Controls & Core Buttons: Title case (*"Home Page"*, *"Next"*).
  * System Metadata, Labels & Content Descriptions: Lowercase (*"suggested movies"*, *"regenerate"*, *"starboy"*, *"movie1"*, *"answer"*).

---

## 2. Reusable Modular Component Architecture

### Component A: `AmbientGlowBackground`
* **Purpose:** Provides a deep, luminous background visual layer under content views.
* **Properties (Props):**
  * `theme`: `'music' | 'movie' | 'series'` (maps to specific accent hex colors).
  * `glowPositions`: Array of coordinates defining where the light blobs center.
* **Style Spec:** Layered elements with a CSS backdrop/filter blur between `60px` and `120px` to create soft organic lighting halos.

### Component B: `CategorySelectionPill`
* **Purpose:** Large interactive navigation links on the landing/onboarding page.
* **Internal Structure:**
  * **Outer Box Container:** Fully rounded pill-shaped frame (`border-radius: 999px`), deep semi-transparent black background, with an outer accent border outline (`border: 1px solid`).
  * **Left Component Slot:** Circular container displaying a crisp center-aligned vector asset/icon (Music Note, Movie Film Reel, or Platform Logo).
  * **Right Component Slot:** High-contrast white label text matching the selection title.
* **Interactive Interaction States:** Hover or active focus triggers an inner glow and outer drop-shadow mapping to the component's category color token.

### Component C: `QuestionnaireBoxWrapper`
* **Purpose:** Standard centralized block hosting questionnaires.
* **Sub-Components:**
  * `QuestionTextContainer`: Rounded rect rectangle container (`border-radius: 12px`), thin crisp boundary stroke line, housing the active survey question string.
  * `RadioSelectionGroup`: Vertical flex-stack listing selection rows with proportional padding gaps.
* **Interactive Individual Item Row (`RadioOptionItem`):**
  * *Default Unselected:* Deep gray subtle outline frame, empty unselected circle vector indicator icon, flat dim-white label text.
  * *Selected State:* Active theme-colored outline frame, fully illuminated radio button icon filled with the active theme color, colored or highlighted option text.

### Component D: `SystemNavigationButton`
* **Purpose:** Directs structural step-by-step layout traversal.
* **Configuration Variant "Next":** Fixed bottom-right anchors. Filled rounded pill structure utilizing a background gradient matching the theme. Includes text left-aligned to an explicit rightward inline chevron arrow indicator (`→`).
* **Configuration Variant "Home Page":** Centered absolute bottom anchors. Rectangular form with standard rounded block corners (`border-radius: 8px`). Semi-glossy glass or saturated gradient background fill matching the theme color token.

---

## 3. Standard Layout Template Rules

### Template 1: Welcome & Primary Category Gate (`iPhone Air - 1`)
* **Layout Tree:** Full-height vertical flex-column with horizontal centering parameters.
* **Visual Layer:** Two large ambient background glow fields (one localized top-right, one bottom-left).
* **Main Screen Canvas:**
  * Top area left uninhibited for system layouts.
  * Centered group stack hosting three sequential `CategorySelectionPill` elements:
    1. **Music Selection Pill:** Tinted with Blue theme values.
    2. **Movie Selection Pill:** Tinted with Cyan theme values.
    3. **Series Selection Pill:** Tinted with Red theme values.
* **Page Footer Anchor:** Discrete branding copy text pinned to the bottom page margin boundary (`created by rebeh`).

---

### Template 2: Linear Multistep Survey System (`iPhone Air - 2, 3, Red Questionnaire`)
* **Layout Tree:** Standard viewport form tracking application progression.
* **Visual Layer:** Multi-directional background glow spots that dynamically swap hex values to track the actively processing selection category type.
* **Top Screen Canvas:** Fixed instructional static section label tracking: *"Please answer the following questions"*.
* **Middle Screen Canvas:** * Centered positioning for the active `QuestionTextContainer`.
  * The vertical layout array containing 4 automated choice variants of `RadioOptionItem`.
* **Bottom Screen Canvas:** Flushed bottom right actions frame displaying the contextual `SystemNavigationButton` (Variant: "Next").

---

### Template 3: Discrete Matrix Grid Recommendation Layout (`iPhone Air - 5, 8`)
* **Layout Tree:** Adaptive dashboard panel displaying grouped item results (Used for Movies & Series).
* **Header Structural Control Row:** Horizontal flex-row spanning the width container. Renders a left-justified label (`suggested movies` or `suggested series`) matching a right-aligned action element (`regenerate`). The action element background block and typography match the theme color category token.
* **Result Visual Grid Spec:**
  * Structured 2x2 multi-row content column.
  * **Matrix Media Block:** Card units comprising a rounded image card element (`border-radius: 12px`) wrapping structural display posters, combined with an underlying text block printing standard metadata references (`movie1`).
* **Bottom Structural Control Row:** Standardized bottom center alignment displaying the layout's primary interactive control target: `SystemNavigationButton` (Variant: "Home Page").

---

### Template 4: Linear Component Recommendation Row List (`iPhone Air - 6`)
* **Layout Tree:** Continuous list dashboard layout (Used exclusively for Music content items).
* **Header Structural Control Row:** Identical layout design schema to Template 3 header (`suggested music` left-side text title component backed by a small right-side blue colored `regenerate` structural component tag).
* **Result Visual List Spec:**
  * Single column flex vertical layout tree array.
  * **Horizontal Media Strip Component:** Long rounded pill layout elements with a thin, low-opacity framing border outline.
  * **Left Side Element:** Square crop media cover image bounding block containing track album art. Matches the host container's left border curvature.
  * **Right Side Element:** Vertical centered text group formatting stack printing double-tier content descriptors (`starboy` track header stacked on top of `the weekend` artist details).
* **Bottom Structural Control Row:** Central absolute bottom orientation outputting `SystemNavigationButton` (Variant: "Home Page" with blue styling configurations).
