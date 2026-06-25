// Professional Resume Template with YAML Integration
// Designed for data engineering and renewable energy roles

#import "@preview/fontawesome:0.5.0": *

// Color palette (coordinated with brand.yml)
#let colors = (
  primary: rgb("#3498DB"),     // Ocean blue
  secondary: rgb("#27AE60"),   // Emerald green  
  accent: rgb("#F39C12"),      // Gold
  text: rgb("#2C3E50"),        // Navy/charcoal
  light: rgb("#ECF0F1"),       // Light gray
  white: rgb("#FFFFFF")
)

// Typography settings
#let fonts = (
  main: "Inter",
  heading: "Inter", 
  mono: "JetBrains Mono"
)

// Helper function to create skill tags
#let skill_tag(skill, level: "primary") = {
  let bg_color = if level == "primary" { colors.primary } else { colors.secondary }
  box(
    fill: bg_color.lighten(85%),
    outset: (x: 4pt, y: 2pt),
    radius: 3pt,
    text(
      size: 8pt,
      fill: bg_color.darken(20%),
      weight: "medium",
      skill
    )
  )
}

// Header section with contact information
#let header(personal, position_title) = {
  // Name and title
  align(center)[
    #text(
      size: 24pt,
      weight: "bold",
      fill: colors.text,
      font: fonts.heading,
      personal.firstname + " " + personal.lastname
    )
    
    #v(4pt)
    
    #text(
      size: 14pt,
      weight: "medium", 
      fill: colors.primary,
      font: fonts.main,
      position_title
    )
  ]
  
  #v(8pt)
  
  // Contact information
  align(center)[
    #grid(
      columns: (1fr, 1fr, 1fr),
      column-gutter: 12pt,
      [#fa-envelope() #link("mailto:" + personal.email, personal.email)],
      [#fa-phone() #personal.phone],
      [#fa-map-marker-alt() #personal.address]
    )
    
    #v(4pt)
    
    #grid(
      columns: (1fr, 1fr),
      column-gutter: 20pt,
      [#fa-github() #link("https://github.com/" + personal.github, personal.github)],
      [#fa-linkedin() #link("https://linkedin.com/in/" + personal.linkedin, personal.linkedin)]
    )
  ]
}

// Professional summary section
#let summary_section(summary_text) = {
  text(
    size: 11pt,
    font: fonts.main,
    summary_text
  )
}

// Section header with styling
#let section_header(title) = {
  v(12pt)
  box(
    width: 100%,
    fill: colors.primary.lighten(90%),
    outset: (x: 8pt, y: 4pt),
    radius: 2pt,
    text(
      size: 14pt,
      weight: "bold",
      fill: colors.primary.darken(20%),
      font: fonts.heading,
      upper(title)
    )
  )
  v(8pt)
}

// Experience entry
#let experience_entry(entry) = {
  // Job title and company
  grid(
    columns: (1fr, auto),
    text(
      size: 12pt,
      weight: "bold",
      fill: colors.text,
      entry.title
    ),
    text(
      size: 10pt,
      weight: "medium",
      fill: colors.secondary,
      entry.date
    )
  )
  
  // Company and location
  text(
    size: 11pt,
    weight: "medium",
    fill: colors.primary,
    entry.company + " • " + entry.location
  )
  
  v(4pt)
  
  // Bullet points
  for bullet in entry.bullets {
    [• #text(size: 10pt, bullet.text)]
    v(2pt)
  }
}

// Education entry
#let education_entry(entry) = {
  grid(
    columns: (1fr, auto),
    [
      #text(size: 11pt, weight: "bold", entry.degree) \
      #text(size: 10pt, fill: colors.primary, entry.school) \
      #text(size: 9pt, fill: colors.text.lighten(30%), entry.location)
    ],
    text(size: 10pt, weight: "medium", fill: colors.secondary, entry.date)
  )
  
  if "notes" in entry {
    v(2pt)
    for note in entry.notes {
      text(size: 9pt, fill: colors.text.lighten(20%), "• " + note)
      linebreak()
    }
  }
}

// Skills section with categorization
#let skills_section(skills, emphasized: ()) = {
  // Function to sort skills with emphasized ones first
  let sort_skills(skill_list) = {
    let emphasized_skills = skill_list.filter(s => s in emphasized)
    let other_skills = skill_list.filter(s => s not in emphasized)
    emphasized_skills + other_skills
  }
  
  [
    *Programming Languages:* #sort_skills(skills.programming.primary + skills.programming.secondary).map(s => 
      if s in emphasized { skill_tag(s, level: "primary") } else { skill_tag(s, level: "secondary") }
    ).join([ ])
    
    #v(6pt)
    
    *Data & Analytics:* #sort_skills(skills.data_tools.primary + skills.data_tools.secondary).map(s => 
      if s in emphasized { skill_tag(s, level: "primary") } else { skill_tag(s, level: "secondary") }
    ).join([ ])
    
    #v(6pt)
    
    *Infrastructure & DevOps:* #sort_skills(skills.infrastructure.primary + skills.infrastructure.secondary).map(s => 
      if s in emphasized { skill_tag(s, level: "primary") } else { skill_tag(s, level: "secondary") }
    ).join([ ])
    
    #v(6pt)
    
    *Cloud & Enterprise:* #sort_skills(skills.cloud.primary + skills.cloud.secondary).map(s => 
      if s in emphasized { skill_tag(s, level: "primary") } else { skill_tag(s, level: "secondary") }
    ).join([ ])
  ]
}

// Main resume template function
#let resume(
  // Data from YAML files
  personal: (:),
  summary: "",
  position_title: "",
  experience: (),
  education: (),
  skills: (:),
  
  // Customization options
  emphasized_skills: (),
  prioritized_experience: (),
  max_experience_entries: 5,
  
  // Optional sections
  achievements: none,
  certifications: none
) = {
  
  // Document setup
  set document(
    title: personal.firstname + " " + personal.lastname + " - Resume",
    author: personal.firstname + " " + personal.lastname
  )
  
  set page(
    paper: "us-letter",
    margin: (x: 0.7in, y: 0.8in),
    background: none,
    foreground: none
  )
  
  set text(
    font: fonts.main,
    size: 10pt,
    fill: colors.text,
    lang: "en"
  )
  
  set par(
    justify: true,
    leading: 0.55em,
    spacing: 0.65em
  )
  
  // Header
  header(personal, position_title)
  
  // Professional Summary
  section_header("Professional Summary")
  summary_section(summary)
  
  // Experience Section
  section_header("Professional Experience")
  
  // Sort experience based on prioritized list
  let sorted_experience = ()
  
  // Add prioritized entries first
  for exp_id in prioritized_experience {
    let matching_exp = experience.filter(e => e.id == exp_id)
    if matching_exp.len() > 0 {
      sorted_experience.push(matching_exp.first())
    }
  }
  
  // Add remaining entries
  let remaining_experience = experience.filter(e => e.id not in prioritized_experience)
  sorted_experience = sorted_experience + remaining_experience
  
  // Limit to max entries
  if sorted_experience.len() > max_experience_entries {
    sorted_experience = sorted_experience.slice(0, max_experience_entries)
  }
  
  for entry in sorted_experience {
    experience_entry(entry)
    v(8pt)
  }
  
  // Skills Section
  section_header("Technical Skills")
  skills_section(skills, emphasized: emphasized_skills)
  
  // Education Section
  section_header("Education")
  for entry in education {
    education_entry(entry)
    if entry != education.last() { v(6pt) }
  }
  
  // Optional Achievements Section
  if achievements != none {
    section_header("Key Achievements")
    for achievement in achievements.financial_impact {
      let value_str = if achievement.value >= 1000000 {
        "$" + str(calc.round(achievement.value / 1000000)) + "M"
      } else if achievement.value >= 1000 {
        "$" + str(calc.round(achievement.value / 1000)) + "K"  
      } else {
        "$" + str(achievement.value)
      }
      
      [• #text(weight: "bold", value_str) #achievement.description - #achievement.context]
      v(2pt)
    }
  }
}

// Export the template
#resume