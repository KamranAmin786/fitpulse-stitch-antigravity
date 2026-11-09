---
name: Kinetic Performance
colors:
  surface: '#101417'
  surface-dim: '#101417'
  surface-bright: '#363a3d'
  surface-container-lowest: '#0b0f12'
  surface-container-low: '#181c1f'
  surface-container: '#1c2023'
  surface-container-high: '#262a2e'
  surface-container-highest: '#313539'
  on-surface: '#e0e3e7'
  on-surface-variant: '#c4c9ac'
  inverse-surface: '#e0e3e7'
  inverse-on-surface: '#2d3134'
  outline: '#8e9379'
  outline-variant: '#444933'
  surface-tint: '#abd600'
  primary: '#ffffff'
  on-primary: '#283500'
  primary-container: '#c3f400'
  on-primary-container: '#556d00'
  inverse-primary: '#506600'
  secondary: '#bdf4ff'
  on-secondary: '#00363d'
  secondary-container: '#00e3fd'
  on-secondary-container: '#00616d'
  tertiary: '#ffffff'
  on-tertiary: '#003824'
  tertiary-container: '#6ffbbe'
  on-tertiary-container: '#00734e'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#c3f400'
  primary-fixed-dim: '#abd600'
  on-primary-fixed: '#161e00'
  on-primary-fixed-variant: '#3c4d00'
  secondary-fixed: '#9cf0ff'
  secondary-fixed-dim: '#00daf3'
  on-secondary-fixed: '#001f24'
  on-secondary-fixed-variant: '#004f58'
  tertiary-fixed: '#6ffbbe'
  tertiary-fixed-dim: '#4edea3'
  on-tertiary-fixed: '#002113'
  on-tertiary-fixed-variant: '#005236'
  background: '#101417'
  on-background: '#e0e3e7'
  surface-variant: '#313539'
typography:
  display-hero:
    fontFamily: Lexend
    fontSize: 56px
    fontWeight: '800'
    lineHeight: 60px
    letterSpacing: -0.03em
  display-hero-mobile:
    fontFamily: Lexend
    fontSize: 40px
    fontWeight: '800'
    lineHeight: 44px
    letterSpacing: -0.03em
  headline-lg:
    fontFamily: Lexend
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 38px
    letterSpacing: -0.02em
  headline-lg-mobile:
    fontFamily: Lexend
    fontSize: 26px
    fontWeight: '700'
    lineHeight: 32px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Lexend
    fontSize: 22px
    fontWeight: '600'
    lineHeight: 28px
    letterSpacing: -0.01em
  headline-sm:
    fontFamily: Lexend
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
    letterSpacing: 0em
  metric-lg:
    fontFamily: Lexend
    fontSize: 36px
    fontWeight: '800'
    lineHeight: 40px
    letterSpacing: -0.02em
  metric-md:
    fontFamily: Lexend
    fontSize: 24px
    fontWeight: '700'
    lineHeight: 28px
    letterSpacing: -0.01em
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
    letterSpacing: 0em
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
    letterSpacing: 0em
  body-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 16px
    letterSpacing: 0.01em
  label-lg:
    fontFamily: Lexend
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 18px
    letterSpacing: 0.02em
  label-md:
    fontFamily: Lexend
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.04em
  label-sm:
    fontFamily: Lexend
    fontSize: 10px
    fontWeight: '700'
    lineHeight: 12px
    letterSpacing: 0.06em
rounded:
  sm: 0.5rem
  DEFAULT: 1rem
  md: 1.5rem
  lg: 2rem
  xl: 3rem
  full: 9999px
spacing:
  gutter: 1rem
  gutter-mobile: 0.75rem
  margin: 1.5rem
  margin-mobile: 1rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 1rem
  space-lg: 1.5rem
  space-xl: 2rem
---

## Brand & Style

This design system expresses a high-performance athletic intelligence. It bridges high-readability sports typography with technical metric clarity, engineered for high-cadence environments such as weight rooms, sprint tracks, and endurance courses.

The visual style pairs deep, light-absorbing onyx and charcoal canvas tones with a hyper-vibrant electric lime accent. The UI avoids skeuomorphic excess in favor of a precision-engineered, dark-mode-first aesthetic: semi-translucent charcoal containers, crisp architectural strokes, high-contrast metric callouts, and restrained neon energy states that direct focus to critical biometric and performance data without inducing visual fatigue.

## Colors

The palette is engineered for high legibility in low-light and outdoor training environments.

### Core Hierarchy
- **Canvas Base (`#0B0F12`)**: Ultra-deep onyx base canvas minimizing battery consumption on OLED displays and creating maximum dynamic range.
- **Surface Elevation 1 (`#141A1F`)**: Deep charcoal container tone for cards, interactive sheets, and list backgrounds.
- **Surface Elevation 2 (`#1C242C`)**: Elevated hover, active, or secondary container state with subtle neutral warmth.
- **Primary Accent (`#CCFF00`)**: Electric lime green. Strictly reserved for primary calls-to-action, active status indicators, key metric readouts, and active bottom navigation indicators. Must maintain high-contrast black typography (`#0B0F12`) when used as a fill.
- **Secondary Accent (`#00E5FF`)**: High-contrast electric cyan for pacing, cadence, and secondary telemetry data.
- **Tertiary Accent (`#10B981`)**: Performance emerald for recovery, heart rate zones, and completed set confirmations.

### Typography & Structure Neutrals
- **High-Emphasis Text (`#FFFFFF`)**: Primary metrics, headlines, and data values.
- **Medium-Emphasis Labels (`#8E9BAE`)**: Metadata, units of measurement, and inactive navigation items.
- **Subtle / Borders (`#1F2933`)**: Structural perimeter boundaries, non-distracting dividers, and neutral progress tracks.

## Typography

The type scale combines `Lexend` for aggressive legibility across all data, numerals, and structural headings, with `Inter` handling explanatory, narrative, and operational body copy.

- **Lexend**: Designed to reduce visual stress and accelerate character recognition. Used for high-priority numbers, timer displays, heart-rate counters, set repetitions, labels, and all headline scales.
- **Inter**: Neutral, utilitarian workhorse providing uniform readability in multi-line instructions, workout summaries, and system configuration notes.
- **Numerals & Metrics**: All numerical counters (e.g., pace, BPM, rep counters) must use tabular numbers (`font-variant-numeric: tabular-nums`) to prevent horizontal jitter during real-time tracking updates.

## Layout & Spacing

The layout is built upon an 8pt base grid system designed for mobile-first sports interfaces.

- **Mobile Viewports (< 600px)**: A 4-column fluid layout with `margin-mobile` (16px) canvas boundaries and `gutter-mobile` (12px) horizontal spacing between interactive cards and stat panels.
- **Tablet / Expanded Viewports (>= 600px)**: An 8-column layout with 24px margins and 16px gutters, allowing side-by-side telemetry grids and split-view exercise execution logs.
- **Rhythm & Touch Targets**: Spacing within interactive workout flows enforces minimum touch zones of 48px by 48px to accommodate users with elevated heart rates and diminished fine-motor precision. Use `space-sm` for metric-to-label vertical relationships, `space-md` for internal card padding, and `space-lg` to separate distinct workout blocks.

## Elevation & Depth

Depth is established through dark-mode surface stacking and localized energetic illumination, entirely eliminating soft standard drop shadows.

- **Base Layer (0dp)**: Surface `#0B0F12`. The main screen floor.
- **Card & Tile Layer (1dp)**: Surface `#141A1F` framed by a 1px solid stroke in `#1F2933`. Under active or recording states, the border shifts to a 1px stroke of `rgba(204, 255, 0, 0.4)` accompanied by a subtle bloom: `0 0 16px rgba(204, 255, 0, 0.15)`.
- **Floating Modals & Sheets (2dp)**: Surface `#1C242C` with a 1px perimeter border of `rgba(255, 255, 255, 0.08)` and ambient back-surface darkening.
- **Bottom Navigation Bar**: Fixed surface `#141A1F` featuring a 1px top stroke of `rgba(255, 255, 255, 0.06)`, with active items projecting an omnidirectional lime glow (`0 0 12px rgba(204, 255, 0, 0.35)`).

## Shapes

The design system employs a Level 3 (Pill-shaped) geometry, delivering an athletic, modern silhouette that softens mechanical numbers while conveying agility.

- **Badges, Tags, and Primary Buttons**: Rendered as true full pills (`border-radius: 9999px` or `rounded-full`), providing ergonomic targets that feel natural to tap.
- **Cards & Data Modules**: Utilize standard `rounded-lg` (20px to 24px / `1.5rem` to `2rem`) corners to retain unified structural symmetry without clipping numerical contents.
- **Progress Trackers & Rings**: Semicircular and radial meters use rounded end-caps (`stroke-linecap: round`) to echo the pill-shaped design language across circular workout visualizations.

## Components

### Buttons
- **Primary Athletic Button**: Full pill geometry (`rounded-full`), solid `#CCFF00` fill, `#0B0F12` text set in `Lexend` SemiBold. Hover and tap states apply a subtle inner brightness scale and an outer neon glow (`box-shadow: 0 0 20px rgba(204, 255, 0, 0.4)`).
- **Secondary Action Button**: Full pill geometry, background `#1C242C`, 1px stroke in `#2E3A46`, with `#FFFFFF` text.
- **Ghost / Utility Button**: Full pill geometry, transparent background, `#8E9BAE` text, transitioning to white on press.

### Pill Badges & Chips
- **Status Badges**: Full pill container with `0.25rem` vertical and `0.75rem` horizontal padding. Rendered with low-opacity accent fills (e.g., `rgba(204, 255, 0, 0.12)`) and matching solid foreground labels (`#CCFF00`) in `label-sm` uppercase.
- **Filter Chips**: Dark charcoal container (`#141A1F`), pill geometry, 1px perimeter border. When selected, border and text flip to `#CCFF00` with an active background glow.

### Cards & Workout Containers
- **Metric Cards**: Background `#141A1F`, border-radius 24px, 1px border `#1F2933`. Internal padding set to `space-md` (16px). Data displays pair high-contrast `metric-lg` white text with `label-md` uppercase `#8E9BAE` labels placed directly beneath.
- **Live Workout Card**: Same as Metric Card, but enhanced with an active left indicator border or ring stroke in `#CCFF00` to indicate in-progress state.

### Lists & Set Tables
- **Exercise Set Rows**: Contained within rounded parent modules. Divided by clean 1px hairline rules in `#1C242C`. Left-aligned set counter in `#8E9BAE`, center-aligned rep/weight inputs, and right-aligned completion controls.

### Checkboxes & Check Rings
- **Set Completion Toggles**: Custom circular pill check controls (32px diameter). Incomplete: 2px hollow ring in `#2E3A46`. Complete: Filled `#CCFF00` background with a centered, bold `#0B0F12` checkmark icon.

### Form & Metric Input Fields
- **Data Log Inputs**: Height 48px, background `#0B0F12`, border-radius 16px, 1px stroke `#2E3A46`. Typography uses `Lexend` Bold with tabular numbers. Active focus state elevates border to `#CCFF00` with zero blur displacement.

### Bottom Navigation Bar
- **Mobile Action Bar**: Docked to base, 64px height with safe area inset. Surface `#141A1F` with 1px top stroke `#1F2933`. Inactive icons render in `#5C6878`. Active tab features icon tinting in `#CCFF00`, accompanied by an immediate `4px` diameter glowing lime dot indicator positioned below the icon.

### Radial Telemetry Rings
- **Progress Ring Rings**: Track background rendered in `#1C242C` with a 6px stroke. Active progress drawn in `#CCFF00` (or `#00E5FF` for pace targets), featuring rounded line ends and a gentle 8px drop glow along the moving vertex.