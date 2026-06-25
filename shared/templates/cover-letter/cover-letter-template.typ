// Professional Cover Letter Template with YAML Integration
// Designed for data engineering and renewable energy roles

#import "@preview/fontawesome:0.5.0": *

// Color palette (coordinated with brand.yml and resume)
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

// Header with personal contact information
#let header(personal) = {
  align(center)[
    #text(
      size: 20pt,
      weight: "bold",
      fill: colors.text,
      font: fonts.heading,
      personal.firstname + " " + personal.lastname
    )
    
    #v(6pt)
    
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
  
  v(20pt)
}

// Recipient and date section
#let recipient_section(company, position, date, hiring_manager: none) = {
  text(size: 10pt, fill: colors.text)[
    #datetime.today().display("[month repr:long] [day], [year]")
  ]
  
  v(12pt)
  
  if hiring_manager != none {
    text(size: 11pt, fill: colors.text)[
      #hiring_manager.name \
      #if "title" in hiring_manager { hiring_manager.title + [ \] }
      #company \
      #if "address" in hiring_manager { hiring_manager.address }
    ]
  } else {
    text(size: 11pt, fill: colors.text)[
      Hiring Manager \
      #company
    ]
  }
  
  v(12pt)
  
  text(size: 11pt, fill: colors.text)[
    *Re: Application for #position Position*
  ]
  
  v(12pt)
}

// Opening paragraph template
#let opening_paragraph(company, position, how_learned) = [
  Dear Hiring Manager,
  
  I am writing to express my strong interest in the #position position at #company. #how_learned I am excited about the opportunity to bring my expertise in data engineering, renewable energy analytics, and financial modeling to contribute to #company's mission of advancing clean energy solutions.
]

// Experience highlight with specific metrics
#let highlight_achievement(achievement, context: "") = {
  let value_display = if achievement.impact_value != none {
    if achievement.impact_value >= 1000000 {
      "$" + str(calc.round(achievement.impact_value / 1000000)) + "M"
    } else if achievement.impact_value >= 1000 {
      "$" + str(calc.round(achievement.impact_value / 1000)) + "K"
    } else {
      "$" + str(achievement.impact_value)
    }
  } else { "" }
  
  if value_display != "" {
    [delivering #text(weight: "bold", fill: colors.primary, value_display) in value through #achievement.text.split(" by ").last()]
  } else {
    [#achievement.text]
  }
  
  if context != "" {
    [, which directly aligns with #context]
  }
}

// Skills alignment paragraph
#let skills_alignment(job_keywords, emphasized_skills) = {
  let matching_skills = emphasized_skills.filter(skill => 
    job_keywords.any(keyword => keyword.lower() in skill.lower() or skill.lower() in keyword.lower())
  )
  
  if matching_skills.len() > 0 {
    [
      My technical expertise in #matching_skills.slice(0, calc.min(3, matching_skills.len())).join(", ")
      #if matching_skills.len() > 3 { [, and other advanced technologies] }
      positions me well to excel in this role.
    ]
  } else {
    [
      My comprehensive technical skill set, including #emphasized_skills.slice(0, 3).join(", "), 
      directly supports the requirements outlined in your job posting.
    ]
  }
}

// Company research paragraph
#let company_paragraph(company_research) = [
  I am particularly drawn to #company_research.why_interested 
  #if "recent_news" in company_research and company_research.recent_news != "" {
    [ Your recent #company_research.recent_news demonstrates the innovative approach that aligns with my passion for leveraging data to drive sustainable energy solutions.]
  }
]

// Closing paragraph
#let closing_paragraph(company, position) = [
  I would welcome the opportunity to discuss how my proven track record of delivering substantial business value through data-driven solutions can contribute to #company's continued success. Thank you for considering my application for the #position position. I look forward to hearing from you soon.
  
  Sincerely, \
  Thandolwethu Shakes Dlamini
]

// Main cover letter template function
#let cover_letter(
  // Personal information
  personal: (:),
  
  // Job information
  company: "",
  position: "",
  
  // Customization data
  company_research: (:),
  key_selling_points: (),
  highlighted_achievements: (),
  job_keywords: (),
  emphasized_skills: (),
  
  // Optional parameters
  hiring_manager: none,
  how_learned: "Through my research into leading renewable energy companies,",
  custom_opening: none,
  custom_closing: none
) = {
  
  // Document setup
  set document(
    title: personal.firstname + " " + personal.lastname + " - Cover Letter - " + company,
    author: personal.firstname + " " + personal.lastname
  )
  
  set page(
    paper: "us-letter",
    margin: (x: 0.8in, y: 0.9in)
  )
  
  set text(
    font: fonts.main,
    size: 11pt,
    fill: colors.text,
    lang: "en"
  )
  
  set par(
    justify: true,
    leading: 0.6em,
    spacing: 0.8em,
    first-line-indent: 0pt
  )
  
  // Header
  header(personal)
  
  // Recipient information
  recipient_section(company, position, datetime.today(), hiring_manager: hiring_manager)
  
  // Opening paragraph
  if custom_opening != none {
    custom_opening
  } else {
    opening_paragraph(company, position, how_learned)
  }
  
  v(8pt)
  
  // Experience and achievement highlights
  [
    In my current role as Senior Data Analyst at Sunnova Energy, I have developed deep expertise in renewable energy data analytics and financial modeling. 
    #if highlighted_achievements.len() > 0 {
      let primary_achievement = highlighted_achievements.first()
      [Most notably, I #highlight_achievement(
        primary_achievement.achievement,
        context: primary_achievement.get("customization", "")
      ).]
    }
    
    #if highlighted_achievements.len() > 1 {
      let secondary_achievement = highlighted_achievements.at(1)
      [ Additionally, I have #highlight_achievement(
        secondary_achievement.achievement,
        context: secondary_achievement.get("customization", "")
      ).]
    }
  ]
  
  v(8pt)
  
  // Technical skills alignment
  skills_alignment(job_keywords, emphasized_skills)
  
  v(8pt)
  
  // Company-specific paragraph
  if "why_interested" in company_research {
    company_paragraph(company_research)
    v(8pt)
  }
  
  // Key selling points
  if key_selling_points.len() > 0 {
    [
      My unique combination of #key_selling_points.join(", ") makes me an ideal candidate for this position. 
      I bring both the technical depth and industry knowledge necessary to make an immediate impact on your team.
    ]
    v(8pt)
  }
  
  // Closing
  if custom_closing != none {
    custom_closing
  } else {
    closing_paragraph(company, position)
  }
}

// Export the template
#cover_letter