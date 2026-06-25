// One-Page Resume — Thandolwethu (Shakes) Dlamini
// Reads from assets/content YAML files

#import "@preview/fontawesome:0.5.0": *

// Colors
#let accent = rgb("#2C3E50")
#let gray-text = rgb("#555555")
#let light-gray = rgb("#999999")
#let rule-color = rgb("#cccccc")

// Load data
#let work = yaml("../../assets/content/work-public.yml")
#let education = yaml("../../assets/content/education.yml")
#let skills = yaml("../../assets/content/skill-public.yml")

#set document(
  title: "Thandolwethu Shakes Dlamini - Resume",
  author: "Thandolwethu Shakes Dlamini",
)

#set page(
  paper: "us-letter",
  margin: (left: 16mm, right: 16mm, top: 12mm, bottom: 10mm),
)

#set text(
  font: ("Source Sans 3", "Arial", "Helvetica"),
  size: 10.5pt,
  fill: rgb("#333333"),
)

#set par(leading: 0.6em, spacing: 0.65em, justify: true)
#set list(indent: 0.6em, spacing: 0.35em, body-indent: 0.4em)

// ── Header ──
#align(center)[
  #text(size: 22pt, weight: "bold", fill: accent)[Thandolwethu (Shakes) Dlamini]
  #v(2pt)
  #text(size: 11pt, fill: gray-text, tracking: 0.5pt)[
    #smallcaps[Data & AI Engineer]
  ]
  #v(5pt)
  #text(size: 9pt, fill: gray-text)[
    #fa-icon("location-crosshairs", size: 7.5pt) Durham, NC
    #h(10pt) #sym.bar.v #h(10pt)
    #fa-icon("envelope", size: 7.5pt) #link("mailto:shakestzd@gmail.com")[shakestzd\@gmail.com]
    #h(10pt) #sym.bar.v #h(10pt)
    #fa-icon("phone", size: 7.5pt) (+1) 984-329-6458
    #h(10pt) #sym.bar.v #h(10pt)
    #fa-icon("github", font: "Font Awesome 6 Brands", size: 7.5pt) #link("https://github.com/shakestzd")[shakestzd]
    #h(10pt) #sym.bar.v #h(10pt)
    #fa-icon("linkedin", font: "Font Awesome 6 Brands", size: 7.5pt) #link("https://linkedin.com/in/shakestzd")[shakestzd]
  ]
]

#v(6pt)

// ── Section header helper ──
#let section(title) = {
  v(5pt)
  text(size: 11pt, weight: "bold", fill: accent, tracking: 0.5pt)[#upper(title)]
  v(-2pt)
  line(length: 100%, stroke: 0.5pt + rule-color)
  v(2pt)
}

// ── Work entry helper ──
#let work-entry(title, company, location, date, bullets) = {
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    [#text(weight: "bold", size: 10.5pt)[#title] #sym.bar.v #text(fill: gray-text)[#company] #sym.bar.v #text(fill: light-gray)[#location]],
    text(weight: "semibold", size: 9.5pt, fill: accent)[#date],
  )
  v(2pt)
  for bullet in bullets [
    - #bullet
  ]
}

// ── Education entry helper ──
#let edu-entry(degree, school, location, date, details) = {
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    [#text(weight: "bold", size: 10.5pt)[#degree] #sym.bar.v #text(fill: gray-text)[#school] #sym.bar.v #text(fill: light-gray)[#location]],
    text(weight: "semibold", size: 9.5pt, fill: accent)[#date],
  )
  if details.len() > 0 {
    v(2pt)
    text(size: 9pt, fill: gray-text)[#details.join("  |  ")]
  }
}

// ══════════════════════════════════════════════
// EXPERIENCE
// ══════════════════════════════════════════════
#section("Experience")

#for (i, job) in work.enumerate() {
  work-entry(
    job.title,
    job.location,
    job.at("description", default: ""),
    job.date,
    job.details,
  )
  if i < work.len() - 1 { v(4pt) }
}

// ══════════════════════════════════════════════
// SELECTED PROJECTS
// ══════════════════════════════════════════════
#section("Selected Projects")

#let project-entry(name, date, description) = {
  grid(
    columns: (1fr, auto),
    column-gutter: 8pt,
    [#text(weight: "bold", size: 10.5pt)[#name] — #text(fill: gray-text)[#description]],
    text(weight: "semibold", size: 9.5pt, fill: accent)[#date],
  )
}

#project-entry(
  "AI Systematic Review Pipeline",
  "2024–Present",
  [LangGraph multi-agent pipeline achieving 99.3% recall on 6,673 clinical papers at \$1.16/review. Co-authored with Johns Hopkins. In peer review at _PRS_.]
)
#v(3pt)
#project-entry(
  "wipnote",
  "2024–Present",
  [Graph database and multi-agent coordination framework using HTML as a knowledge representation layer. Published on PyPI.]
)
#v(3pt)
#project-entry(
  "InkBrief",
  "2025–Present",
  [Executive-ready PDF briefing generator. React 19 visual editor with BlockNote, Typst WASM compiler, Python CLI, PocketBase.]
)
#v(3pt)
#project-entry(
  "TiltHQ",
  "2025–Present",
  [Political media analytics in Elixir/Phoenix. OTP supervision, Oban background jobs, LiveView dashboard with bias scoring.]
)
#v(3pt)
#project-entry(
  "Skhiya",
  "2025–Present",
  [Desktop environment manager (Rust/Tauri + React). Manages .env files, SSH keys, and shell configs across projects.]
)

// ══════════════════════════════════════════════
// EDUCATION
// ══════════════════════════════════════════════
#section("Education")

#for (i, edu) in education.enumerate() {
  edu-entry(
    edu.description,
    edu.title,
    edu.location,
    edu.date,
    edu.at("details", default: ()),
  )
  if i < education.len() - 1 { v(4pt) }
}

// ══════════════════════════════════════════════
// SKILLS
// ══════════════════════════════════════════════
#section("Technical Skills")

#for cat in skills {
  grid(
    columns: (100pt, 1fr),
    column-gutter: 10pt,
    text(weight: "semibold", size: 9.5pt)[#cat.title],
    text(size: 9.5pt, fill: gray-text)[#cat.description],
  )
  v(3pt)
}
