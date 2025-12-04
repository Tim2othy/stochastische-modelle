#import "@preview/gentle-clues:1.2.0": *

#let fonts = (
  text: "Libertinus Serif",
  sans: "Noto Sans",
  mono: "Inconsolata",
)
#let colors = (
  title: eastern,
  headers: maroon,
  partfill: rgb("#002299"),
  label: red,
  hyperlink: blue,
  strong: rgb("#000055"),
)
#let toc = {
  show outline.entry.where(level: 1): it => {
    v(1.6em)
    text(weight: "bold", font: fonts.sans, it)
  }
  show outline.entry.where(level: 2): it => {
    v(0.9em, weak: true)
    text(font: fonts.sans, it)
  }
  text(fill: colors.title, size: 1.4em, font: fonts.sans, [Inhaltsverzeichnis])
  v(0.1em)
  outline(
    title: none,
    indent: 2em,
  )
}

// Main entry point to use in a global show rule
#let project(
  title: none,
  author: none,
  subtitle: none,
  date: datetime.today(),
  maketitle: true,
  report-style: false,
  body,
) = {
  // Set the document's basic properties.
  if (title != none) {
    set document(title: title)
  }
  if (author != none) {
    set document(author: author)
  }

  // Figures formatting
  show figure.caption: cap => context {
    set text(0.95em)
    block(inset: (x: 5em), [
      #set align(left)
      #text(weight: "bold")[#cap.supplement #cap.counter.display(cap.numbering)]#cap.separator#cap.body
    ])
  }

  // Table formatting
  show figure.where(kind: table): fig => {
    // Auto emphasize the table headers
    show table.cell.where(y: 0): set text(weight: "bold")
    let tableframe(stroke) = (x, y) => (
      left: 0pt,
      right: 0pt,
      top: if y <= 1 { stroke } else { 0pt },
      bottom: stroke,
    )
    set table(
      stroke: tableframe(rgb("#21222c")),
      fill: (_, y) => if (y == 0) { rgb("#ffeeff") } else if calc.even(y) { rgb("#eaf2f5") },
    )
    fig
  }

  // General settings
  set page(
    paper: "a4",
    margin: (x: 3cm, y: 3cm),
    header: context {
      set align(right)
      set text(size: 0.8em)
      if (not maketitle or counter(page).get().first() > 1) {
        text(weight: "bold", title)
        if (author != none) {
          h(0.2em)
          sym.dash.em
          h(0.2em)
          text(style: "italic", author)
        }
      }
    },
    numbering: "1",
  )
  set text(font: fonts.text, size: 11pt, lang: "de")
  set par(justify: true)

  // For bold elements, use sans font
  show strong: set text(font: fonts.sans, size: 0.9em)

  // Theorem environments
  //show: thm-rules.with(qed-symbol: $square$)

  // Change quote display
  set quote(block: true)
  show quote: set pad(x: 2em, y: 0em)
  show quote: it => {
    set text(style: "italic")
    v(-1em)
    it
    v(-0.5em)
  }

  // Indent lists
  set enum(numbering: "(a)", spacing: 3em, indent: 1em)
  set list(indent: 1em)

  // Section headers
  set heading(numbering: "1.1")
  show heading: it => {
    block([
      #if (it.numbering != none) [
        #text(
          fill: colors.headers,
          (if (report-style and it.level == 1) { "Chapter " } else { "§" })
            + counter(heading).display()
            + (if (report-style and it.level == 1) { "." } else { "" }),
        )
        #h(0.2em)
      ]
      #it.body
      #v(0.4em)
    ])
  }
  show heading: set text(font: fonts.sans, size: 11pt)
  show heading.where(level: 1): set text(size: 14pt)
  show heading.where(level: 2): set text(size: 12pt)

  // Hyperlinks should be pretty
  show link: it => {
    set text(fill: if (type(it.dest) == label) { colors.label } else { colors.hyperlink })
    it
  }
  show ref: it => {
    link(it.target, it)
  }
  // Report parameters

  show ref: it => {
    let el = it.element
    if el != none and el.func() == block { return link(el.location(), "irgendeinem Satz (todo: fix this)") }
    if el != none and el.func() == heading and el.level == 1 and it.supplement == auto and report-style {
      ref(it.target, supplement: "Chapter")
    } else {
      it
    }
  }

  // Title page, if maketitle is true
  if maketitle {
    v(2.5em)
    set align(center)
    set block(spacing: 2em)
    block(text(fill: colors.title, size: 2em, font: fonts.sans, weight: "bold", title))
    if (subtitle != none) {
      text(size: 1.5em, font: fonts.sans)[\- #subtitle -]
    }
    if (author != none) {
      block(smallcaps(text(size: 1.7em, author)))
    }
    if (type(date) == datetime) {
      block(text(size: 1.2em, date.display("[day] [month repr:long] [year]")))
    } else if (date != none) {
      block(text(size: 1.2em, date))
    }
    v(1.5em)
  }
  v(1fr)
  toc
  v(1fr)
  pagebreak()

  body
}
