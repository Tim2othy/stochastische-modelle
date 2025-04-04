#import "@preview/theorion:0.3.3": *

#let make-frame(
  identifier,
  supplement,
  counter: none,
  inherited-levels: 0,
  inherited-from: heading,
  numbering: get-theorion-numbering,
  render: (prefix: none, title: "", full-title: "", body) => block[*#full-title*: #body],
) = {
  let get-numbering = if type(numbering) != function { (..args) => numbering } else { numbering }
  /// Counter for the frame.
  let frame-counter = if counter != none { counter } else {
    richer-counter(
      identifier: identifier,
      inherited-levels: inherited-levels,
      inherited-from: inherited-from,
    )
  }
  let supplement-i18n = theorion-i18n(supplement)
  let display-number(get-loc: here, counter: frame-counter, ..args) = context {
    let loc = get-loc()
    // We need to add 1 to the counter value.
    let counter-value = if type(counter) == dictionary {
      (counter.at)(loc)
    } else {
      counter.at(loc)
    }
    counter-value = counter-value.slice(0, -1) + (counter-value.at(-1) + 1,)
    std.numbering(get-numbering(get-loc()), ..counter-value)
  }

  /// Useful functions for the frame.
  let get-prefix(get-loc) = [#supplement-i18n #display-number(get-loc: get-loc)]
  let get-full-title(get-loc, title) = [#get-prefix(get-loc)#{ if title != "" [, #title] }]
  /// Frame with the counter.
  let frame(
    title: "",
    outlined: true,
    numbering: display-number,
    get-prefix: get-prefix,
    get-full-title: get-full-title,
    ..args,
    body,
  ) = figure(
    kind: identifier,
    supplement: supplement-i18n,
    caption: title,
    outlined: outlined,
    numbering: numbering,
    {
      [#metadata((
          identifier: identifier,
          supplement: supplement,
          supplement-i18n: supplement-i18n,
          kind: identifier,
          counter: frame-counter,
          title: title,
          numbering: numbering,
          outlined: outlined,
          get-prefix: get-prefix,
          get-full-title: get-full-title,
          render: render,
          args: args,
          body: body,
        )) <theorion-frame-metadata>]
      render(
        prefix: get-prefix(here),
        title: title,
        full-title: get-full-title(here, title),
        ..args,
        body,
      )
      // Update the counter.
      if numbering != none {
        (frame-counter.step)()
      }
    },
  )
  /// Frame without the counter.
  let frame-box = frame.with(
    numbering: none,
    outlined: false,
    get-prefix: get-loc => none,
    get-full-title: (get-loc, title) => title,
  )
  /// Show rule for the frame.
  let show-frame(body) = {
    // skip the default figure style.
    show figure.where(kind: identifier): set align(start)
    show figure.where(kind: identifier): set block(breakable: true)
    show figure.where(kind: identifier): it => it.body
    // Custom outline for the theorem environment.
    show outline.where(target: figure.where(kind: identifier)): it => {
      show outline.entry: entry => {
        let el = entry.element
        block(
          link(
            el.location(),
            entry.indented(
              [#el.supplement #context theorion-display-number(el)],
              {
                entry.body()
                box(width: 1fr, inset: (x: .25em), entry.fill)
                entry.page()
              },
              gap: .5em,
            ),
          ),
        )
      }
      it
    }
    // Custom reference for the theorem environment.
    show ref: it => {
      let el = it.element
      if el != none and el.func() == figure and el.kind == identifier {
        link(
          el.location(),
          {
            if it.supplement == auto { el.supplement } else { it.supplement }
            " "
            context theorion-display-number(el)
          },
        )
      } else {
        it
      }
    }
    body
  }
  return (frame-counter, frame-box, frame, show-frame)
}
