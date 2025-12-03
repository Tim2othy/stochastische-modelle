
#let project(
  title: "",
  subtitle: "",
  semester: "",
  body,
) = {
  // Set the document's basic properties.
  set page(margin: (x: 2cm, y: 3cm), numbering: "1")
  set text(font: "ETbookOT", size: 12pt, lang: "de")
  set par(justify: true)
  set enum(numbering: "(a)", spacing: 3em, indent: 1em)
  set heading(numbering: "1.1")
  show outline.entry.where(level: 1): set block(above: 1.5em)
  show outline.entry.where(level: 2): set block(above: 0.8em)

  show ref: it => {
    let el = it.element
    if el == none or el.func() != block { return it }
    link(el.location(), "irgendeinem Satz (todo: fix this)")
  }

  // Title row.
  align(center)[
    #text(2em)[*#title*]

    #text(1.6em)[\- #subtitle -]

    #text(1.4em)[#semester]
  ]

  pagebreak()
  outline()
  pagebreak()

  body
}
