#import "@preview/theorion:0.3.3": *
#import cosmos.clouds: *
#import "settings.typ": make-frame
#show: show-theorion

#let title = [Stochastische Modelle]
#let subtitle = [Vorlesung]
#let semester = [Wintersemester 2024/25]

// Theorion Settings
#let (theorem-counter, theorem-box, theorem, show-theorem) = make-frame(
  "theorem",
  "Satz",
  counter: none,
  render: render-fn.with(fill: olive.lighten(85%)),
)
#let (example-counter, example-box, example, show-example) = make-frame(
  "corollary",
  "Beispiel",
  counter: none,
  render: render-fn.with(fill: blue.lighten(85%)),
)
#let (definition-counter, definition-box, definition, show-definition) = make-frame(
  "definition",
  "Definition",
  counter: none,
  render: render-fn.with(fill: red.lighten(85%)),
)
#let proof(
  title: theorion-i18n-map.at("proof"),
  qed: auto,
  body,
) = context if get-result(here()) == "noanswer" { none } else {
  let qed-symbol = if qed == auto { get-qed-symbol(here()) } else { qed }
  [#emph(strong(theorion-i18n(title)))#sym.space#body#box(width: 0em)#h(1fr)#sym.wj#sym.space.nobreak$#qed-symbol$]
}
#let (lemma-counter, lemma-box, lemma, show-lemma) = make-frame(
  "lemma",
  "Lemma",
  counter: none,
  render: render-fn.with(fill: yellow.lighten(85%)),
)

// Normal Settings
#set text(font: "New Computer Modern", lang: "DE", size: 13pt)
#set heading(numbering: "1.1")
#set page(margin: (x: 2.5cm, y: 3cm), numbering: "1")
#show outline.entry.where(level: 1): set block(above: 1.2em)

#align(
  center,
  text(2em)[*#title*],
)
#align(
  center,
  text(1.6em)[\- #subtitle -],
)
#align(
  center,
  text(1.4em)[#semester],
)

#pagebreak()
#outline()
#pagebreak()

= Wahrscheinlichkeitstheorie

== Wahrscheinlichkeitsmaße


Bezeichne $Omega$ die Menge aller möglichen Ergebnisse eines Zufallsexperiments und $A in Omega$ ein Ereignis. Ein
Wahrscheinlichkeitsmaß ist eine Abbildung, die jedem $A$ eine Zahl
$P(A) in [0, 1]$ zuordnet. Es gilt:

- $P(Omega) = 1$ (Normierung)

- $P(A_1 ∪ A_2 ∪...) = P(A_1) + P(A_2) +...$ falls
  $(A_i ∩ A_j) = nothing$ für alle $i != j$ ($sigma$-Additivität)

Aus den Axiomen folgt

- $P(A^C) = 1 - P(A)$

- $P(A ∪ B) = P(A) + P(B) - P(A ∩ B)$

- $P(B without A) = P(B) - P(A ∩ B)$

Ist $A$ eine echte Teilmenge von $B$ ($A ⊂ B$) gilt

- $P(B without A) = P(B) - P(A)$

- $P(A) subset.eq P(B)$

#theorem[

  Für Ereignisse $A_1, ..., A_n$ gilt
  $ P(⋃_(i = 1)^n A_i) <= sum_(i = 1)^n P(A_i) . $ (a) Sind
  $A, A_1, A_2, ... ⊃ Omega$ eine Folge von nicht disjunkten Ereignissen mit $A_1 ⊂ A_2 ⊂... ⊂ A$ //TODO Maybe the last A should be A_n
  und $⋃_(n = 1)^oo A_n = A$, dann ist
  $ lim_(n -> oo) P(A_n) = P(A) = P(⋃_(n = 1)^oo A_n). $
  (b) Sind $A, A_1, A_2, ... ⊂ Omega$ eine Folge von nicht disjunkten Ereignissen mit
  $A_1 ⊃ A_2 ⊃ ... ⊃ A$ //TODO Maybe the last A should be A_n
  und $⋂_(n = 1)^oo A_n = A$, dann gilt
  $ lim_(n -> oo) P(A_n) = P(A) = P(⋂_(n = 1)^oo A_n). $
] <thm:lim-sets>
#proof(title: [Beweis von @thm:lim-sets])[

  (a) lässt sich folgendermaßen zeigen:\
  Seien

  - $B_1 := A_1$

  - $B_2 := A_2 without A_1$

  - …

  - $B_n := A_n without A_(n - 1)$

  Mit der $sigma$-Additivität ist dann
  $
    P(A) = P(⋃_(k = 1)^oo B_k) = sum_(k = 1)^oo P(B_k) = lim_(n -> oo) sum_(i = 1)^n P(B_k) = lim_(n -> oo) P(⋃_(k = 1)^n B_k) = lim_(n -> oo) P(A_n)
  $
  (b) lässt sich folgendermaßen zeigen:\
  Aus $A_1 ⊃ A_2 ⊃ ... ⊃ A_n$ folgt $A_1^C ⊂ A_2^C ⊂... ⊂ A_n^C$. Sei nun

  - $B_1 := A_1^C$

  - $B_2 := A_2^C without A_1^C$

  - …

  - $A_n^C without A_(n - 1)^C$

  Mit der $sigma$-Additivität ist dann
  $
    P(⋃_(n = 1)^oo A_n^C) = P(A^C) = P(⋃_(k = 1)^oo B_k) = sum_(k = 1)^oo P(B_k) = lim_(n -> oo) sum_(i = 1)^n P(B_k) lim_(n -> oo) P(⋃_(k = 1)^n B_k) = lim_(n -> oo) P(A_n^C)
  $
  und folglich
  $
    lim_(n -> oo) P(A_n) = 1 - lim_(n -> oo) P(A_n^C) = 1 - P(⋃ n = 1^oo A_n^C) = 1 - P([⋂_(n = 1)^oo A_n]^C) = P(⋂_(n = 1)^oo A_n) = P(A)
  $
]
== Zufallsvariablen

Eine Zufallsvariable ist eine Abbildung $X : Omega -> bb(R)$. Für
$A ⊂ bb(R)$ gilt
$ { X in A } = { omega in Omega : X (omega) in A } $ und
$ P(X in A) = P({ omega in Omega : X (omega) in A }) . $ Für
$a in bb(R)$ ist $ { X = a } = { omega in Omega : X (omega) = a } $ und
$ P(X = a) = P({ omega in Omega : X (omega) = a }) . $ Die Verteilungsfunktion $F = F_X$ der Zufallsvariablen $X$ ist
definiert durch $F (x) = P(X in x)$ mit $x in bb(R)$ und
$ P \( X in (a, b \]) = P(a < X <= b) = F (b) - F (a) "für alle" a < b . $
Zudem gilt
$ P(Y = a) = F (a) - F (b_(-)) = F (a) - lim_(epsilon -> 0) F (a - epsilon) . $
Ist ${ epsilon_n }_(n = 1)^oo$ eine fallende Folge mit $epsilon_1 ⊃ epsilon_2 ⊃ ... ⊃ 0$ und $lim_(n -> oo) epsilon_n = 0$,
dann gilt für die Ereignisse
$A_n := { a - epsilon_n < X < a }$ $A_1 ⊃ A_2 ⊃ ...$ und $⋂_(n = 1)^oo A_n = { X = a } = A$ gemäß Lemma 1b)
$
  P(Y = a) = P(⋂_(n = 1)^oo A_n) = P(A) = lim_(n -> oo) P(A_n) = lim_(n -> oo) P(a - epsilon_n < X <= a) = F (a) - lim_(n -> oo) F (a - epsilon_n)
$
Eine Zufallsvariable heißt diskret, falls ...

- ... sie (un)endlich viele abzählbare Werte hat.

- ... $f (x) = P(X = x)$ gilt (Wahrscheinlichkeitsfunktion).

- ... für $A in bb(R)$ $P(X in A) = sum_(X in A) f (x)$ gilt.

Eine Zufallsvariable heißt stetig, falls es eine nicht negative Funktion $f$ gibt, sodass
$ P(a <= X <= b) = integral_a^b f (x) thin d x "für alle" a < b $
$f$ heißt Dichte von $X$. Die Verteilungsfunktion ist dann
$
  F (x) = integral_(- oo)^x f (t) thin d t
$ Die gemeinsame Verteilungsfunktion $F = F_(X_1, ..., X_n)$ von $n$ Zufallsvariablen
$X_1, ..., X_n$ ist definiert durch
$ F (x_1, ..., x_n) = P(X_1 <= x_1, ..., X_n <= x_n) "für alle" x_1, ..., x_n in bb(R) $
Für die Randverteilungsfunktion $F_(X_1), ..., F_(X_n)$ gilt
$ F_(X_i) (x_i) = lim_(x_j -> oo) F (x_1, ..., x_n) "für" i != j $
Sind $X_1, ..., X_n$ diskrete Zufallsvariablen, so ist ihre gemeinsame Wahrscheinlichkeitsfunktion gegeben durch
$ f (x_1, ..., x_n) = P(X_1 = x_1, ..., X_n = x_n) . $
$X_1, ..., X_n$ sind gemeinsam stetig verteilt, falls es eine gemeinsame Dichte $f (x_1, ..., x_n) >= 0$ gibt, sodass
$
  F (x_1, ..., x_n) = integral_(- oo)^(x_1) dots.h integral_(- oo)^(x_n) f (t_1, ..., t_n) thin d t_n dots.h thin d t_1 "für alle" x_1, ..., x_n in bb(R)
$
Für $B_1, ..., B_n in bb(R)$ gilt dann
$ P(X_1 in B_1, ..., X_n in B_n) = integral_(B_1)... integral_(B_n) f (t_1, ..., t_n) thin d t_n... thin d t_1 $
Für $B in bb(R)^n$ ist
$ P({ X_1, ..., X_n } in B) = integral dots.h integral_B f (t_1, ..., t_n) thin d t_n... thin d t_1 $
und die Randdichte ist
$
  f_(X_i) = integral_(- oo)^oo... integral_(- oo)^oo f (x_1, ..., x_n) thin d x_1... thin d x_(i - 1) thin d x_(i + 1)... thin d x_n
$
Ist zum Beispiel $f$ eine gemeinsame Dichte von $X$ und $Y$, dann gilt
$ P(X < Y) = integral_(- oo)^oo integral_x^oo f (x, y) thin d y thin d x $
und $ f_Y (y) = integral_(- oo)^oo f (x, y) d x . $


#theorem[Placeholder]
#theorem[Placeholder]
#theorem[Placeholder]

== Erwartungswert und Varianz

Ist $X$ eine diskrete Zufallsvariable und $g : bb(R) -> bb(R)$, so ist $ E [g (X)] = sum_X g (x) P(X = x) $ wobei die
Summe über alle $X$
mit $P(X = x) > 0$ läuft.\
Nimmt X nur Werte in ${ 0, 1, 2, ... }$ an, dann gilt
$ E [X] = sum_(n = 0)^oo P(X > n), $ denn
$
  E [X] & = sum_(n = 0)^oo n P(X = n) =\
  & P(X = 1) +\
  & P(X = 2) + P(X = 2) +\
  & P(X = 3) + P(X = 3) + P(X = 3) +\
  & dots.h\
  & P(X = n) + P(X = n) + P(X = n) + dots.h\
  & = P(X > 0) + P(X > 1) + P(X > 2) + dots.h + P(X > n)
$ Hat $X$
eine Dichte $f$, so ist
$ E [g (X)] = integral_(- oo)^oo g (x) f (x) thin d x $ Für jede nichtnegative Zufallsvariable $X$ gilt
$ E [X] = integral_0^oo P(X > x) thin d x = integral_0^oo P(X >= x) thin d x $
Allgemein gilt
$ E [a X + b Y] = a E [X] + b E [Y] "für" a, b in bb(R) $
Die Varianz der Zufallsvariable $X$ ist
$ V a r [X] = E [(X - E [X])^2] = E [X^2] - E [X]^2 $ Die Kovarianz von Zufallsvariablen X und Y ist
$ C o v [X, Y] = E [(X - E [X]) (Y - E [Y])] = E [X Y] - E [X] E [Y] $
Es gilt

+ $V a r [a X + b] = a^2 V a r [X]$ für $a, b in bb(R)$

+ $V a r [a X + b Y] = a^2 V a r [X] + b^2 V a r [Y] + 2 a b C o v [X, Y]$
  oder allgemein
  $V a r [sum X_i] = sum V a r [X_i] + 2 sum_(i < j) C o v [X_i, X_j]$

+ $C o v [a X + b, c Y + d] = a c C o v [X, Y]$ für
  $a, b, c, d in bb(R)$

+ $C o v [sum_(i = 1)^n X_i, sum_(j = 1)^m Y_j] = sum_(i = 1)^n sum_(j = 1)^m C o v [X_i, Y_j]$

== Unabhängigkeit

Ereignisse $A_1, A_2, ...$ heißen unabhängig, falls für jede endliche Auswahl von verschiedenen Indizes $i_1, ..., i_n$ gilt
$ P(A_(i_1) ∩... ∩ A_(i_n)) = P(A_(i_1)... P(A_(i_n))) $
Sind $A_1, A_2, ...$ unabhängige Ereignisse und ist für jedes i
$B_i = A_i$ oder $B_i = A_i^C$, dann sind auch $B_1, B_2, ...$
unabhängig.\
Zufallsvariablen $X_1, ..., X_n$ heißen unabhängig, falls für alle
$x_1, ..., x_n in bb(R)$
$ F_(X_1, ..., X_n) (x_1, ..., x_n) = F_(X_1) (x_1) F_(X_2) (x_2)... F_(X_n) (x_n) $
Für eine unendliche Folge von Zufallsvariablen $X_1, X_2, ...$
bedeutet Unabhängigkeit, dass für jedes $n$ $X_1, ..., X_n$
unabhängig sind.\
Für unabhängige Zufallsvariablen $X_1, ..., X_n$ gilt

+ ${ X_1 in B_1 }, ..., { X_n in B_n }$ sind unabhängige Ereignisse für alle $B_1, ..., B_n in bb(R)$

+ $E [product_(i = 1)^n X_i] = product_(i = 1)^n E [X_i]$

+ $C o v [X_i, X_j] = 0$ für alle $i != j$
  $-> V a r [X_1, ..., X_n] = sum_(i = 1)^n V a r [X_i]$

+ $h_1 (X_1, ..., X_(n_1)), h_2 (X_(n_1 + 1), ... X_(n_2)), ..., h_n (X_(n_(k - 1) + 1), ... X_(n_k))$
  sind unabhängige Zufallsvariablen, wobei
  $0 = n_0 < n_1 <... < n_k <= n$, wobei
  $h_i : bb(R)^(n_i - n_(i - 1)) -> bb(R)$ \
  ${ (X_1, ..., X_(n_1)) in B_1 }$,\
  ${ (X_(n_1 + 1), ..., X_(n_2)) in B_2 }$,\
  ... \
  ${ (X_(n_(k - 1) + 1), ..., X_(n_k)) in B_k }$,\
  sind somit unabhängige Ereignisse für alle $B_1, ..., B_k$.

Für den Spezialfall diskreter Zufallsvariablen $X_1, ..., X_n$ gilt
$
  X_1, ..., X_n "unabhängig" <=> P(X_1 = x_1, ..., X_n = x_n) = P(X_1 = x_1)... P(X_n = x_n) "für alle" x_1, ..., x_n in bb(R)
$
Sind $X_1, ..., X_n$ stetige Zufallsvariablen mit gemeinsamer Dichte f und
$ f (x_1, ..., x_n) = f_(X_1) (x_1)... f_((X_n)) (x_n) "für alle" x_1, ..., x_n in bb(R), $
dann sind $X_1, ..., X_n$ unabhängig. In diesem Fall ist
$ f_(X_1) (x_1)... f_(X_n) (x_n) $ eine gemeinsame Dichte von
$X_1, ..., X_n$.

== Bedingte Wahrscheinlichkeiten und Erwartungswerte

Für $A, B in Omega$ mit $P(B) > 0$ ist die bedingte Wahrscheinlichkeit von A gegeben B $ P(A \| B) = frac(P(A ∩ B), P(B)) $

- Bei festem $B in Omega$ mit $P(B) > 0$ ist $P(dot(\|) B)$ ein Wahrscheinlichkeitsmaß: $P(Omega \| B) = 1$ und für
  disjunkte Ereignisse $A_1, A_2, ...$ ist
  $P(A_1 ∪ A_2 ∪... \| B) = sum_i P(A_i \| B)$

- Sind A und B unabhängig, dann ist $P(A \| B) = P(A)$ (falls
  $P(B) > 0$)

- Bilden $A_1, A_2, ...$ eine Zerlegung von $Omega$, also
  $A_i ∩ A_j = nothing$ für alle $i != j$ und
  $⋃_i A_i = Omega$, dann gilt ür jedes $A in Omega$
  $ P(A) = sum_i P(A ∩ A_i) = sum_(i : P(A_i) > 0) P(A \| A_i) P(A_i) "(Satz der totalen Wahrscheinlichkeit)" $

- Für beliebige Ereignisse $A_1, ... A_n$ gilt
  $ P(A_1 ∩ A_2 ∩...) = P(A_1) P(A_2 \| A_1) P(A_3 \| A_1 ∩ A_2)... P(A_n \| A_1 ∩... ∩ A_(n - 1)), $falls
  $ P(A_1 ∩... ∩ A_(n - 1)) > 0 "(Multiplikationssatz für bedingte Wahrscheinlichkeiten)" $

Für diskrete Zufallsvariablen $X$ und $Y$ ist die bedingte Wahrscheinlichkeitsfunktion $f_(X \| Y) (x \| y)$ ($X$,
gegeben $Y = y$) definiert durch
$ f_(X \| Y) = P(X = x \| Y = y), "falls" P(Y = y) > 0 $
Nach dem Satz der totalen Wahrscheinlichkeit ist dann
$ P(X = x) = sum_(Y : P(Y = y) > 0) f_(X \| Y) (x \| y) P(Y = y) $

#example[
  $X$ und $Y$ seien diskrete Zufallsvariablen mit Wahrscheinlichkeitsfunktionen $f_X$ und $f_Y$. Für die
  Wahrscheinlichkeitsfunktion $f_(X + Y)$ von $X + Y$ gilt
  $ f_(X + Y) (z) = P(X + Y = z) = sum_(Y : f_Y (y) > 0) P(X + Y = z \| Y = y) f_Y (y) $
  $ = sum_Y f_(X \| Y) (z - y \| y) f_Y (y) $

]
Seien $X$ und $Y$ unabhängige diskrete Zufallsvariablen, dann gilt
$f_(X \| Y) (x \| y) = f_X (x)$ und
$ f_(X + Y) (z) = sum_Y f_X (z - y) f_Y (y) . $ Diese Funktion heißt Faltung von $f_X$ und $f_Y$.\
Analog ist für unabhängige stetige Zufallsvariablen $X$ und $Y$ mit zugehörigen Dichten $f_X (x)$ und $f_Y (y)$ die
Dichte von $X + Y$
gegeben durch die Faltung
$ f_(X + Y) (z) = integral_(- oo)^oo f_X (z - y) f_Y (y) thin d y, $
denn für alle $t in bb(R)$ ist
$ P(X + Y + t) = integral_(- oo)^oo integral_(- y)^(t - y) f_X (x) f_Y (y) thin d x thin d y = $
$
  integral_(- oo)^oo integral_(- oo)^t f_X (z - y) f_Y (y) thin d z thin d y = integral_(- oo)^t integral_(- oo)^oo f_X (z - y) f_Y (y) thin d y thin d z
$
Seien $X$ und $Y$ diskrete ZUfallsvariablen und gilt
$g : bb(R) -> bb(R)$. Der bedingte Erwartungswert von $g (X)$
gegeben $Y = y$ ist
$ E [g (X) \| Y = y] = sum_X g (x) f_(X \| Y) (x \| y), "falls" P(Y = y) > 0 $
Zudem gilt
$ E [g (X)] = sum_(Y : P(Y = y) > 0) E [g (X) \| Y = y] P(Y = y), "denn" $
$ E [g (X)] = sum_X g (x) P(X = x) = sum_X g (x) sum_Y f_(X \| Y) (x \| y) P(Y = y) $
$
  = sum_Y P(Y = y) sum_X g (x) f_(X \| Y) (x \| y)
$ Im Falle diskreter Zufallsvariablen $X, X_1, X_2, Y$ und $y in bb(R)$ gelten
folgende Rechenregeln für bedingte Erwartungswerte:

+ $E [a X_1 + b X_2 \| Y = y] = a E [X_1 \| Y = y] + b E [X_2 \| Y = y]$

+ $E [h (X, Y) \| Y = y] = E [h (X, y) \| Y = y]$ für
  $h : bb(R)^2 -> bb(R)$

+ $E [g (X) \| Y = y] = E [g (X)]$ falls $X tack.t Y$

+ $E [g (X) h (Y) \| Y = y] = h (y) E [g (X) \| Y = y]$ für
  $h : bb(R) -> bb(R)$

Ist Y diskret und X stetig mit bedingter Dichte $f_(X \| Y) (x \| y)$, also
$ P(a < X < b \| Y = y) = integral_a^b f_(X \| Y) (x \| y) "für alle" a < b "und" P(Y = y) > 0, $
dann gilt für die Randdichte $f_X (x)$ von $X$
$ f_X (x) = sum_(Y : P(Y = y) > 0) f_(X \| Y) (x \| y) P(Y = y) $ und für $g : bb(R) -> bb(R)$
$ E [g (X) \| Y = y] := integral g (x) f_(X \| Y) (x \| y) thin d x "falls" P(Y = y) > 0 $
Die Rechenregeln für bedingte Erwartungswerte gelten wie im diskreten Fall, wie zum Beispiel
$ E [g (X)] = sum_(Y : P(Y = y) > 0) E [g (X) \| Y = y] P(Y = y) . $

= Markovketten

== Markov-Eigenschaft

#definition(title: "Stochastischer Prozess")[

  Ein stochastischer Prozess ist eine Familie von Zufallsvariablen $X_t$, wobei der Parameter $t$ eine Indexmenge $T$ durchläuft.
  Oft ist
  $T in \[ o, oo \)$ oder $T = { 0, 1, 2, ... }$ und $t in T$ wird als Zeitpunkt interpretiert.\
  Der Zustandsraum eines stochastischen Prozesses ${ X_t : t in T }$ ist die Menge aller möglichen Werte der $X_t$. Man
  sagt der Prozess ist zur Zeit $t$ in Zustand $x$, falls $X_t = x$.
]

#definition(title: "Markov-Kette")[

  Eine diskrete Markov-Kette ist ein stochastischer Prozess mit diskreter Zeit und diskretem Zustandsraum, sodass zu
  jeder Zeit die Verteilung des nächsten Zustands nur vom aktuellen Zustand abhängt aber nicht von den vorherigen. Formal
  bedeutet dies:\
  Sei $S != nothing$ eine endliche oder abzählbar unendliche Menge. Sei $(P_(i j))_(i, j in S)$ eine stochastische Matrix,
  also
  $p_(i j) >= 0$ für alle $i, j in S$ und $sum_(j in S) p_(i j) = 1$
  für alle $i in S$.\
]
#theorem[

  Eine Folge ${ X_n : n in bb(N) }$ von Zufallsvariablen mit Werten in $S$
  heißt Markovkette mit Zustandsraum $S$ und Übergangsmatrix
  $(P_(i j))_(i, j in S) \)$, falls für alle $n >= 0$ und alle möglichen $i_0, i_1, ..., i_(n + 1) in S$ gilt
  $ (star) P(X_(n + 1) = i_(n + 1) \| X_0 = i_0, ..., X_n = i_n) = p_(i_n i_(n + 1)), $
  sofern $P(X_0 = i_o, ..., X_n = i_n) > 0$. Die Verteilung von $X_0$
  heißt Anfangsverteilung der Markov-Kette. \

]<thm:markov-kette>
$(star)$ beinhaltet zwei Aussagen:

+ Die Bedingte Verteilung von $X_(n + 1)$ für eine gegebene Vorgeschichte $i_0, i_1, ..., i_n$ hängt nur von der
  Gegenwart ab, aber nicht von der Vergangenheit. Dies ist die Markov-Eigenschaft.

+ Die bedingte Verteilung hängt nicht vom Zeitpunkt $n$ ab. Die Übergangswahrscheinlichkeiten sind stationär.

Die i-te Zeile der Übergangsmatrix beschreibt die bedingte Verteilung des nächsten Zustands $X_(n + 1)$ gegeben $X_n = i$ (und
$X_0 = i_0, ...$).

#example[

  Seien $X_0, X_1, ...$ unabhängige und identisch verteilte
  $bb(N)_0$-wertige Zufallsvariablen mit $P(X_0 = i) = a_i$,
  $i = 0, 1, ...$. Dann ist ${ X_n : n in bb(N) }$ eine Markov-Kette mit Zustandsraum $bb(N)_0$ und Übergangsmatrix
  $(P_(i j))_(i, j in bb(N)_0)$ mit $p_(i j) = a_j$ für alle
  $i, j in bb(N)_0$.
  $
    (P_(i j))_(i, j = 0)^a = mat(
      a_0, a_1, a_2, dots.h.c;a_0, a_1, a_2, dots.h.c;a_0, a_1, a_2, dots.h.c;dots.v, dots.v, dots.v, dots.down
    )
  $
  Denn für alle $n >= 0$ und alle $i_0, ..., i_(n + 1) in bb(N)_0$
  mit $P(X_0 = i_0, ..., X_n = i_n) > 0$ gilt:
  $
    P(X_(n + 1) = i_(n + 1) \| X_0 = i_0, ..., X_n = i_n) = P(X_(n + 1) = i_(n + 1)) = a_(i_(n + 1)) = p_(i_n i_(n + 1))
  $
  In Worten: Die Wahrscheinlichkeit von Zustand $i$ in Zustand $j$ zu gehen wird nur durch die Wahrscheinlichkeit in
  Zustand $j$ zu sein bestimmt, oder anders gesagt $X_(n + 1)$ und $X_n$ sind unabhängig.

]
#example(title: [Irrfahrt auf $bb(Z)$])[

  Seien $Y_1, Y_2, dots.h$ unabhängige, identisch verteilte
  $bb(Z)$-wertige Zufallsvariablen mit $P(Y_1 = i)$, $i in bb(Z)$. Sei
  $X_(0 i) := 0$ und $X_n := Y_1 + dots.h + Y_n$, $n in bb(N)$. In Worten:
  $X_n$ springt zufällig von
  $X_(n - 1) = i_(n - 1) = i_(n - 2) + Y_(n - 1)$ zu
  $i_n = i_(n - 1) + Y_n$ auf den ganzen Zahlen $bb(Z)$. Damit gilt offensichtlich für jedes $n >= 1$, dass
  $X_n = i_(n - 1) + Y_n <=> Y_n = i_n - i_(n - 1)$. \
  Für alle $n >= 0$ und alle $i_0, dots.h, i_(n + 1) in bb(Z)$ mit
  $P(X_0 = i_0, dots.h, X_n = i_n) > 0$ ist
  $
    & P(X_(n + 1) = i_(n + 1) \| X_0 = i_0, dots.h, X_n = i_n)\
    = & P(X_n + Y_(n + 1) = i_(n + 1) \| X_0 = i_0, dots.h, X_n = i_n)\
    = & P(i_n + Y_(n + 1) = i_(n + 1) \| X_0 = i_0, dots.h, X_n = i_n)\
    = & P(Y_(n + 1) = i_(n + 1) - i_n \| X_0 = i_0, dots.h, X_n = i_n)\
    = & P(Y_(n + 1) = i_(n + 1) - i_n \| Y_1 = i_1, Y_2 = i_2 - i_1, dots.h, Y_n = i_n - i_(n - 1))\
    = & P(Y_(n + 1) = i_(n + 1) - i_n) = a_(i_(n + 1) - i_n) .
  $
  $=> { X_n : n in bb(N) }$ ist eine Markov-Kette mit Zustandsraum $bb(Z)$ und Übergangswahrscheinlichkeit
  $p_(i j) = a_(j - 1)$, $i, j in bb(Z)$.
  $
    (P_(i j)) = mat(

      dots.h, a_(- 2), a_(- 1), a_0, a_1, a_2, dots.h;
      dots.h, a_(- 3), a_(- 2), a_(- 1), a_0, a_1, dots.h;
      dots.h, a_(- 4), a_(- 3), a_(- 2), a_(- 1), a_0, dots.h;
      dots.h, a_(- 5), a_(- 4), a_(- 3), a_(- 2), a_(- 1), dots.h;
      dots.h, a_(- 6), a_(- 5), a_(- 4), a_(- 3), a_(- 2), dots.h;
      dots.up, dots.v, dots.v, dots.v, dots.v, dots.v, dots.down

    )
  $
  Ein Spezialfall wäre die einfache Irrfahrt auf $bb(Z)$ bei der
  $P(Y_n = 1) = p$ und $P(Y_n = - 1) = 1 - p$ für alle $n in bb(N)$. Interpretation: Die Markov-Kette beschreibt die
  Position eines Teilchens, das sich auf $bb(Z)$ bewegt. Es startet im Ursprung $X_0 = 0$
  und springt zu jedem Zeitpunkt $1, 2, ...$ zufällig eine Einheit nach links oder rechts.

]
#example(title: [Sukzessive Maxima])[

  Seien $Y_1, Y_2, ...$ unabhängig und identisch verteilte
  $bb(N)_0$-wertige Zufallsvariablen mit $P(Y_1 = c) = a_i$, $i in N_0$,
  $X_0 : = 0$ und $X_n : = m a x (Y_1, ..., Y_n)$. In Worten: Die Kette nimmt zu jeden Zeitpunkt $n$ den größten
  zufälligen Wert aus
  ${ 0, Y_1, ..., Y_n }$, bzw. wegen der sukzessiven Natur des Prozesses aus ${ i_(n - 1), Y_n }$, an. \
  Für alle $n >= 0$ und alle $i_0, ..., i_(n + 1) in bb(N)_0$ mit
  $P(X_0 = i_0, ..., X_n = i_n) > 0$ ist
  $
    & P(X_(n + 1) = i_(n + 1) \| X_0 = i_0, dots.h, X_n = i_n)\
    & = P(max (Y_1, dots.h, Y_(n + 1)) = i_(n + 1) divides X_0 = i_0, dots.h, X_n = i_n)\
    & = P(max (X_n, Y_(n + 1)) = i_(n + 1) divides X_0 = i_0, dots.h, X_n = i_n)\
    & = P(max (i_n, Y_(n + 1)) = i_(n + 1) divides X_0 = i_0, dots.h, X_n = i_n)\
    & = P(max (i_n, Y_(n + 1)) = i_(n + 1) divides Y_1 = i_1, max (Y_1, Y_2) = i_2, dots.h, max (Y_1, dots.h, Y_n) = i_n)\
    & = P(max (i_n, Y_(n + 1)) = i_(n + 1))
  $ Diese Wahrscheinlichkeit hängt nun vom Verhältnis von $i_n$ zu $i_(n + 1)$ ab. Per Konstruktion kann $i_(n + 1)$ nicht
  kleiner sein als $i_n$. Ist $i_(n + 1) < i_n$, dann ist $Y_(n + 1)$ das Maximum und folglich auch
  $P(max (i_n, Y_(n + 1)) = i_(n + 1)) = P(Y_(n + 1) = i_(n + 1)) = a_(i_(n + 1))$. Für den Fall, dass $i_(n + 1) = i_n$ ist,
  betrachten wir sowohl die Fälle, für die $Y_(n + 1) < i_n$ ist als auch den Fall
  $Y_(n + 1) = i_n$. Daraus folgt
  $P(max (i_n, Y_(n + 1)) = i_(n + 1)) = P(Y_(n + 1) <= i_n) = sum_(k = 0)^n a_k$.
  $
    P(max (i_n, Y_(n + 1)) = i_(n + 1)) = cases(
      P(Y_(n + 1) = i_(n + 1)) = a_(i_(n + 1)) & text(", falls ") i_(n + 1) > i_n,
      P(Y_(n + 1) <= i_n) = sum_(k = o)^n a_k & text(", falls ") i_(n  + 1) = i_n,
      0 & text(", falls ") i_(n + 1) < i_n,

    )
  $
  $=> { X_n : n in N_0 }$ ist eine Markovkette mit Zustandsraum $bb(N)_0$ und Übergangsmatrix
  $
    p_(i j) = cases(
      a_j & text(", falls ") j > i,
      sum_(k = 0)^i a_k & text(", falls ") j = i,
      0 & text(", falls ") j < i,

    )
  $

]
#example(title: [Rekursive Darstellung einer Markovkette mittels zufälliger Funktionen])[

  Sei $X_0$ eine $S$-wertige Zufallsvariable
  und $S$ endlich oder abzählbar unendlich. Setze für $n >= 0$ rekursiv
  $ X_(n + 1) = f (X_n, Y_(n + 1)) $ Dabei sei
  $f : S times bb(R) -> S$, $Y_1, ..., Y_n$ seien identisch verteilte Zufallsvariablen und $Y_0, Y_1, ...$ seien
  unabhängig. \
  $=> { X_n : n in bb(N)_0 }$ ist eine Markovkette mit Übergangswahrscheinlichkeiten $p_(i j) = P(f (i, Y_1) = j)$, denn
  für
  $n >= 1$ und $i_0, ..., i_(n + 1) in S$ mit
  $P(X_0 = i_0, ..., X_n = i_n) > 0$ gilt
  $
    & P(X_(n + 1) = i_(n + 1) \| X_0 = i_0, ..., X_n = i_n)\
    & = P(f (X_n, Y_(n + 1)) = i_(n + 1) \| X_0 = i_0, ..., X_n = i_n)\
    & = P(f (i_n, Y_(n + 1)) = i_(n + 1) \| X_0 = i_0, ..., X_n = i_n)\
    & =^star P(f (i_n, Y_(n + 1)) = i_(n + 1))\
    & =^(star star) P(f (i_n, Y_1) = i_(n + 1))\
    & = p_(i_n i_(n + 1))
  $ $star$ Hinweis: Das Ereignis
  ${ X_(n + 1) = f (i_n, Y_(n + 1)) I i_(n + 1) }$ hängt von einem festen Wert $i_n$ und der Zufallsvariablen $Y_(n + 1)$ ab.
  Das gleiche gilt natürlich auch für $X_0, ..., X_n$. Deswegen liegt hier Unabhängigkeit vor. \
  $star star$ Hinweis: $Y_1, Y_2, ...$ i.i.d

]

#example[Placeholder so numbering matches up]

Bemerkung zum Beispiel: In Beispiel 3 war $f (x, y) = x + y$ und in Beispiel 4 war $f (x, y) = m a x (x, y)$.

== Mehrschritt-Übergangswahrscheinlichkeiten

Sei ${ X_n : n in bb(N)_0 }$ eine Markovkette mit Zustandsraum S, Übergangsmatrix $(P_(i j))_(i, j in S)$ und
Anfangsverteilung
$p_i = P(X_0 = i)$ ($i in S$). Bestimme die gemeinsame Verteilung von
$X_0, ..., X_n$:\
Für $n >= 1$ und $i_0, ..., i_n in S$ gilt
$
  & P(X_0 = i_0, X_1 = i_1, ..., X_n = i_n)\
  = & P(X_0 = i_0, ..., X_(n - 1) = i_(n - 1)) p_(i_(n - 1) i_n)\
  = & P(X_0 = i_0, ..., X_(n - 2) = i_(n - 2)) p_(i_(n - 2) i_(n - 1)) p_(i_(n - 1) i_n)\
  = & dots.h\
  = & P(X_0 = i_0) p_(i_0 i_1)... p_(i_(n - 2) i_(n - 1)) p_(i_(n - 1) i_n)
$

#theorem[
  Für jede Folge von Zuständen $i_0, ..., i_n in S$ gilt:
  $ P(X_0 = i_0, ..., X_n = i_n) = p_(i_0 i_1)... p_(i_(n - 1) i_n) $
  Insbesondere ist für jedes $n$ die Verteilung von $X_0, ..., X_n$
  durch die Anfangsverteilung ($p_i$) und die Übergangsmatrix
  $(P_(i j))_(i, j in S)$ eindeutig festgelegt.

]<thm:markov-trans>
#example[

  Betrachte eine Markovkette ${ X_n : n in bb(N)_0 }$ mit Zustandsraum
  $S = { 0, 1, 2, 3, 4 }$, $X_0 : = 0$, also $p_0 = P(X_0 = 0) = 1$. \
  Sei $X_n = m a x (Y_1, ..., Y_n)$, $n in bb(N)$, wobei
  $Y_1, ..., Y_n$ unabhängig und gleichverteilt ($P(Y_n = j) = 1 / 5$
  für alle $j in S$ und $n in bb(N)_0$). \
  In Worten: Die Markovkette nimmt zu jedem Zeitpunkt $n$ das Maximum aus dem bisherigen Maximum $i_(n - 1)$ und dem
  zufälligen Wert $Y_n$ an, welcher mit gleicher Wahrscheinlichkeit Werte zwischen 0 und 4 annimmt. Aus Beispiel 4 folgt
  diese Übergangsmatrix:
  $
    (P_(i j))_(i, j = 0)^n =
    mat(
      1 / 5, 1 / 5, 1 / 5, 1 / 5, 1 / 5;
      0, 2 / 5, 1 / 5, 1 / 5, 1 / 5;
      0, 0, 3 / 5, 1 / 5, 1 / 5;
      0, 0, 0, 4 / 5, 1 / 5;
      0, 0, 0, 0, 1;

    )
  $
  Was wäre die Wahrscheinlichkeit, dass $X_0 = 0$, $X_1 = 2$ und
  $X_3 = 4$? $   & P(X_0 = 0, X_1 = 2, X_2 = 2, X_3 = 4)\
    & = p_0 p_02 p_22 p_24\
    & = 1 dot.op 1 / 5 dot.op 3 / 5 dot.op 1 / 5 = 3 / 125 $ Was wäre die Wahrscheinlichkeit, dass $X_1 >= 2$ und $X_2 <= X_1$?
  \
  Da es nicht möglich ist, dass $i_(n + 1) < i_n$, können wir auf 3 mögliche Pfade mit $X_1 = X_2 = 2$, $X_1 = X_2 = 3$ und $X_1 = X_2 = 4$
  schließen. $   & P(X_1 >= 2, X_2 <= X_1)\
    & = P(X_1 >= 2, X_1 = X_2)\
    & = P(X_0 = 0, X_1 = 2, X_2 = 2) + P(X_0 = 0, X_1 = 3, X_2 = 3) + dots.h\
    & = 12 / 25 $

]
Die Markov-Eigenschaft lässt sich auf allgemeinere Ereignisse in Zukunft und Vergangenheit erweitern:\

#theorem[

  Für alle $n, m >= 1$, $Z ⊂ S^m$, $V ⊂ S^n$, $i in S$ mit
  $P((X_0, ..., X_(n - 1)) in V, X_n = i) > 0$ gilt
  $
    P((X_(n + 1), ..., X_(n + m)) in Z \| (X_0, ..., X_(n - 1)) in V, X_n = i) = \
    sum_(j_1, ..., j_m in Z) p_(i j_1) p_(j_1 j_2)... p_(j_(m - 1) j_m)
  $
  In Worten: Die Wahrscheinlichkeit, dass
  ${ X_n + 1 = i_(n + 1), ..., X_(n + m) = i_(n + m) } in Z$, hängt nur von $X_n = i$ und nicht von ${ X_0, ..., X_(n - 1) } in V$.
  Die Wahrscheinlichkeit
  $P({ X_n + 1 = i_(n + 1), ..., X_(n + m) = i_(n + m) } in Z \| X_n = i)$
  ist dann die Summe über alle (disjunkten) Pfad-Wahrscheinlichkeiten in
  $Z$ (mit Start in $X_n = i$ und daraus resultierender Anfangsverteilung
  $p_i$). \
  Sofern $P(X_0 = i) > 0$ können wir die aufgrund der Zeithomogenität der Markovkette auch folgen:
  $
    P((X_(n + 1), ..., X_(n + 1)) in Z \| (X_0, ..., X_(n - 1)) in V, X_n = i) = \ P((X_1, ..., X_m) in Z \| X_0 = i)
  $
] <thm:med_markov>
#proof(title: [Beweis von @thm:med_markov])[

  Für alle $(j_1, ..., j_m) in Z$ und $(i_0, ..., i_(n - 1)) in V$
  mit $P(X_0 = i_0, ..., X_(n - 1) = i_(n - 1), X_n = i) > 0$ gilt
  $
    & P((X_(n + 1), ..., X_(n + m)) = (j_1, ..., j_m) \| (X_0, ..., X_(n - 1)) = (i_0, ..., i_(n - 1)), X_n = i)\
    = & frac(
    P((X_(n + 1), ..., X_(n + m)) = (j_1, ..., j_m), (X_0, ..., X_(n - 1)) = (i_0, ..., i_(n - 1)), X_n = i),
    P((X_0, ..., X_(n - 1)) = (i_0, ..., i_(n - 1)), X_n = i),

  )\
    = & frac(p_(i_0) p_(i_0 i_1)... p_(i_(n - 1) i) p_(i j_1)... p_(j_(m - 1) j_m), p_(i_0) p_(i_0 i_1)... p_(i_(n - 1) i))\
    = & p_(i j_1) p_(j_1 j_2)... p_(j_(m - 1) j_m)
  $
]

Oft werden für eine Markovkette ${ X_n }$ bei fester Übergangsmatrix
$(P_(i j))$ verschiedene Anfangszustände betrachtet. Bezeichne mit
$p_i (dot.op)$ die bedingte Verteilung $P(X_n = j \| X_0 = i)$ und mit
$E_i (dot.op)$ den Erwartungswert für den Anfangszustand $i$, das heißt
$P_i (X_0 = i) = 1$. Dann gilt
$
  & P((X_(n + 1), ..., X_(n + m)) in Z \| (X_0, ..., X_(n - 1)) in V, X_n = i)\
  & = P((X_1, ..., X_m) in Z \| X_0 = i)\
  & = P_i ((X_1, ..., X_m) in Z)
$ und für $f : f^m -> bb(R)$
$
  & E [f (X_(n + 1, ..., X_(n + m))) \| (X_0, ..., X_(n - 1)) in V, X_n = i]\
  & = E [f (X_(n + 1), ..., X_(n + m)) \| X_0 = i]\
  & = E_i [f (X_1, ..., X_m)] .
$ Beide Größen hängen vom gegenwärtigen Zustand $i$ ab und weder von $V$ noch von $n$.\
Die Aussagen lassen sich mit einem unendlichen Zeithorizont erweitern:\
Für die Menge $Z ⊂ S^oo$ und $f : S^oo -> bb(R)$ gilt
$ P((X_(n + 1), X_(n + 2), ...) in Z \| (X_0, ..., X_(n - 1) in V), X_n = i) = P_i ((X_1, ...) in Z) $
und
$ E [f (X_(n + 1), X_(n + 2), ...) \| (X_0, ..., X_(n - 1) in V, X_n = i)] = E_i [f (X_(n + 1), X_(n + 2), ...)] . $

Die $n$-Schritt Übergangswahrscheinlichkeit ist
$ p_(i j)^n : = P(X_(n + m) = j \| X_m = i) $ mit $i, j in S$,
$n >= 0$, $P(X_m = i) > 0$. Diese Wahrscheinlichkeit hängt nicht von
$m$ ab (Zeithomogenität).\
Es gilt
$ p_(i j)^0 = P(X_m = j \| X_m = i) = , 1 & ", falls" i = j, 0 & ", falls" i != j) $
und $ P_(i j)^1 = P(X_(m + 1) = j \| X_m = i) = p_(i j) $

#theorem(title: [Satz von Chapman-Kolmogorow])[

  Für alle $i, j in S$ und
  $m, n in bb(N)_0$ ist die Wahrscheinlichkeit, von Zustand $i$ in
  $m + n$ Schritten zu Zustand $j$ zu gelangen gegeben durch:
  $ p_(i j)^((m + n)) = sum_(k in S) p_(i k)^((m)) p_(k j)^((n)) $

]<thm:chapman-kolmogorow>
#proof(title: [Beweis von Satz 8:])[

  Die Behauptung ist für $m = 0$, $n = 0$ oder
  $n = m = 0$ klar, da
  $ p_(i j)^((n)) = sum_(k in S) p_(i k)^0 p_(k j)^((n)) = p_(i j)^((n)) $

  $ p_(i j)^((m)) = sum_(k in S) p_(i k)^((m)) p_(k j)^0 = p_(i j)^((m)) $

  $
    p_(i j)^0 = sum_(k in S) p_(i k)^0 p_(k j)^0 =
    cases(1 & ", falls" i = j, 0 & ", falls" i != j)
  $
  Für $m, n >= 1$ und $P(X_0 = 1) > 0$ ist
  $
    & p_(i j)^(m + n) = P(X_(m + n) = j \| X_0 = i)\
    = & sum_(k in S) P(X_(m + n) = j, X_m = k \| X_0 = i)\
    = & sum_(k in S) frac(P(X_(m + n) = j, X_m = k, X_0 = i), P(X_0 = i)) dot frac(P(X_m = k, X_0 = i), P(X_m = k, X_0 = i))\
    = & sum_(k in S) P(X_(m + n) = j \| X_m = k, X_0 = i) P(X_m = k \| X_0 = i)\
    = & sum_(k in S) P(X_m = k \| X_0 = i) P(X_(m + n) = j \| X_m = k)\
    = & sum_(k in S) p_(i k)^m p_(k j)^n
  $]

Für einen Übergang von $i$ nach
$j$ in $m + n$ Schritten muss die Markovkette in $m$ Schritten von $i$
zu einem beliebigen Zustand $k$ gehen und dann von $k$ in $n$ Schritten zu $j$.\
Die $n$-Schritt Übergangsmatrix ist definiert als
$ Pi^((n)) : = (P_(i j))^((n)) $ mit
$ Pi = Pi^((1)) : = (P_(i j))_(i, j in S)^((1)) = (P_(i j))_(i, j in S) $
Die $n$-Schritt Übergangsmatrix $Pi^((n))$ ist die $n$-te Potenz der Übergangsmatrix $Pi^((1))$.\
Somit besagt der Satz von Chapman-Kolmogorow, dass
$ Pi^(m + n) = Pi^m Pi^n $ Alternativ kann auch für einen Start bei
$X_n = i$ mit korrespondierender Verteilung, welche dem Zeilenvektor
$ (p_i^((n)))_(i in S) $ der Übergangsmatrix mit
$p_i^((n)) = P(X_n = i)$ und $n in bb(N)_0$ entspricht, die Wahrscheinlichkeit in weiteren $m in bb(N)_0$ Schritten ein
beliebiges
$j in S$ zu erreichen folgendermaßen erfasst werden:
$
  p_j^((n + m)) = P(X_(n + m) = j) = sum_(i in S) P(X_(n + m) = j \| X_n = i) P(X_n = i) = sum_(i in S) p_i^((n)) p_(i j)^((m))
$
Daraus folgt wiederum: $ p^((n + m)) = p^((n)) Pi^m $ Letzteres kann genutzt werden, um die Verteilung $X_n$ zu jeden
Zeitpunkt zu berechnen:

#theorem[

  Die Verteilung von $X_n$ zu einem beliebigen Zeitpunkt $n >= 0$
  ergibt sich aus dem Produkt der Anfangsverteilung und der $n$-ten Potenz der Übergangsmatrix. $ p^((n)) = p^((0)) Pi^n $
]<thm:markov-trans-matrix>
#example[

  Betrachte eine Markovkette $X_n : n in bb(N)_0$ mit $S = { 1, 2, 3 }$, Übergangsmatrix
  $
    Pi = 1 / 3 mat(
      1, 0, 2;
      0, 2, 1;
      1, 1, 1
      )
  $ und Anfangsverteilung $p^((0)) = P(X_0 = i) = (1 / 4, 1 / 2, 1 / 4)$.
  \
  Berechne die bedingte Verteilung von $X_2$ gegeben $X_0 = 3$.
  $
    Pi^2 = Pi Pi = 1 / 9 mat(
    3, 2, 4;
    1, 5, 3;
    2, 3, 4)
  $

  $
    Pi^4 = Pi^2 Pi^2 = 1 / 81 mat(
    19, 28, 34;
    14, 36, 31;
    17, 31, 33)
  $

  - $P(X_2 = 1 \| X_0 = 3) = p_31^((2)) = 2 / 9$

  - $P(X_2 = 2 \| X_0 = 3) = p_32^((2)) = 1 / 3$

  - $P(X_2 = 3 \| X_0 = 3) = p_33^((2)) = 4 / 9$

  Berechne zudem die Verteilung von $X_4$.
  $ p^((4)) = p^((0)) Pi^((4)) = (P(X_4 = 1), P(X_4 = 2), P(X_4 = 3)) = (16 / 81, 131 / 324, 43 / 108) $

]
== Absorptionswahrscheinlichkeiten und -zeiten

Sei ${ X_n : n in bb(N)_0 }$ eine Markovkette mit Zustandsraum S und Übergangsmatrix $(P_(i j))$.\
Sei $A ⊂ S$, $A != nothing$. Setze
$T_i = inf { n in bb(N)_0 : X_n in A }$, wobei $inf nothing = oo$. $T$
ist die Eintrittszeit in $A$, also der zufällige Zeitpunkt des ersten Besuchs der Menge $A$, falls es einen gibt.\
Ziel: Berechne für jeden Anfangszustand $i$ die Wahrscheinlichkeit, dass
$A$ in endlicher Zeit erreicht wird.
$ P(T < oo \| X_0 = i) = P(⋃_(n = 0)^oo { X_n in A } \| X_0 = i) = p_i (T < oo) $
Ein Zustand $z in S$ heißt absorbierend, falls $p_(z z) = 1$. In dem Spezialfall, dass $A$ nur aus absorbierenden
Zuständen besteht, heißt
$p_i (T < oo)$ Absorptionswahrscheinlichkeit bei Start in $i in S$ und
$T$ heißt Absorptionszeit.\
Folgender Satz gilt für beliebige $A$:\

#theorem[
  Sei ${ X_n : n in bb(N)_0 }$ eine Markovkette mit Zustandsraum $S$ und Übergangsmatrix $(P_(i j))$. Sei $A ⊂ S$, $A != nothing$ und
  $ T_i = inf { n in bb(N)_0 : X_n in A } $
  $ h_i = P(T < oo \| X_0 = i) $
  $
    => h_i = 1 "für alle" i in A "und" h_i = sum_(j in S) p_(i j) h_j "für alle" i in S without A
  $

]<thm:markov-absorption>
#proof(title: [Beweis Satz 10])[

  Für $i in A$ gilt $P(T = 0 \| X_0 = i) = 1$, also $h_1 = 0$.\
  Sei nun $i in S without A$. Der Beweisansatz ist die Einschritt-Analyse: Zerlege die gesuchte Wahrscheinlichkeit $h_i$ mit
  dem Satz der totalen Wahrscheinlichkeit danach, was im ersten Schritt der Markov-Kette passiert ist.
  $
    h_i & = P(T < oo \| X_0 = i)\
    & = sum_(j in S) P(T < oo, X_1 = j \| X_0 = i)\
    & = sum_(j in S) overbrace(P(X_1 = j \| X_0 = i), p_(i j)) P(T < oo \| X_1 = j, X_0 = i)\
  $
  Für $j in A$ ist
  $
    P(T < oo \| X_1 = j, X_0 = i) = 1,
  $
  und für $j in S without A$
  $
    P(T < oo \| X_1 = j, X_0 = i) = & P(⋃_(n = 2)^oo { X_n in A } \| X_1 = j, X_0 = i)\
    = & lim_(N -> oo) P(⋃_(n = 2)^N { X_n in A } \| X_1 = j, X_0 = i)\
    = & lim_(N -> oo) P(⋃_(n = 1)^(N - 1) { X_n in A } \| X_o = j)\
    = & P(⋃_(n = 1)^oo { X_n in A } \| X_0 = j)\
    = & P(T < oo \| X_0 = j)\
    = & h_j
  $ Damit folgt: $ h_i = sum_(j in S) p_(i j) h_j $
]
#example(title: [Ruinproblem])[

  In jeder Runde eines Spiels gewinnt eine Spieler 1€ mit Wahrscheinlichkeit $p in (0, 1)$ und verliert 1€ mit
  Wahrscheinlichkeit
  $(1 - p)$. Sein Anfangskapital sei i€. Er spielt so lange, bis er M€ hat
  $(M >= i)$ oder ruiniert ist (0€). \
  Berechne die Ruinwahrscheinlichkeit. \
  Betrachte hier für die Markovkette ${ X_n : n in bb(N)_0 }$ mit Zustandsraum $S = { 0, 1, 2, ..., M }$ und
  Übergangswahrscheinlichkeiten
  $
    p_(i j) = cases(
      1 & "falls" i = 0 "und" j = 0,
      p & "falls" i in { 1, ..., M - 1 } "und" j = i + 1,
      1 - p & "falls" i in { 1, ..., M - 1 } "und" j = i - 1,
      1 & "falls" i = M "und" j = M,
      0 & "sonst",

    )
  $
  Gesucht sind die Absorptionswahrscheinlichkeiten
  $ h_i = P(T < oo \| X_0 = i) $ mit $i = 0, ..., M$ und
  $T = inf { n in bb(N)_0 : X_n = 0 }$. \
  Es ist $h_0 = 1$ (sofort ruiniert), $h_M = 0$ (sofort Ende des Spiels wegen maximalem Gewinn) und nach Satz 10 ist die
  Wahrscheinlichkeit jemals ruiniert zu sein beim Start in Periode $i$ eine Gewichtung der Ruinwahrscheinlichkeit nach
  einer Aufwärtsbewegung (also ab $i + 1$) und einer Abwärtsbewegung (also ab $i - 1$).
  $
    h_i & = p h_(i + 1) + (1 - p) h_(i - 1) "für" i = 1, ..., M - 1\
    <=> h_(i + 1) - h_i & = frac(1 - p, p) (h_i - h_(i - 1))
  $
  Falls es sich um ein faires Spiel handelt, also $p = 1 / 2$, dann ist
  $h_(i + 1) - h_i = h_i - h_(i - 1)$ für $i = 1, ..., M - 1$. Die Änderung in der Ruinwahrscheinlichkeit ist also
  konstant für jedes der
  $i$, man kann $h_i$ also als lineare Funktion betrachten:
  $ h_i = h_0 + a dot i $ Da $h_0 = 1$ $ h_i = 1 + a dot i $ und
  $h_M = 0$ folgt für das $a$ aus der Gleichung $ 0     & = 1 + a dot M\
  <=> a & = - 1 / M $ und somit für die Ruinwahrscheinlichkeit $h_i$: $ h_i = 1 - i / M $ Sei nun
  $p != 1 / 2$ und setze $Theta = frac(1 - p, p)$. Durch rekursives Einsetzen erhält man
  $
    h_2 - h_1 & = Theta (h_1 - h_0) = Theta (h_1 - 1)\
    h_3 - h_2 & = Theta (h_2 - h_1) = Theta^2 (h_1 - 1)\
    dots.v & \
    h_(i + 1) - h_i & = Theta^i (h_1 - 1) "für alle" i = 0, ..., M - 1
  $
  Zunächst bildet man die Summe über $i = 0, ..., j - 1$ (über alle
  $j in S$) und nutzt die Eigenschaft der Teleskopsumme und der geometrischen Reihe aus:
  $
    sum_(i = 0)^(j - 1) h_(i + 1) - h_i & = sum_(i = 0)^(j - 1) Theta^i (h_1 - 1)\
    <=> sum_(i = 0)^(j - 1) h_i - h_(i + 1) & = sum_(i = 0)^(j - 1) Theta^i (1 - h_1)\
    <=> h_0 - h_j & = sum_(i = 0)^(j - 1) Theta^i (1 - h_1)\
    <=> 1 - h_j & = (1 - h_1) sum_(i = 0)^(j - 1) Theta^i\
    <=> 1 - h_j & = (1 - h_1) frac(1 - Theta^j, 1 - Theta)\
    <=> h_j & = (h_1 - 1) frac(1 - Theta^j, 1 - Theta) + 1 "für" j = 1, ..., M
  $
  Da diese Gleichung für alle $j$ gilt, gilt sie auch für $j = M$ und da
  $h_M = 0$ ist, ist $ 0           & = (h_1 - 1) frac(1 - Theta^M, 1 - Theta) + 1\
  <=> 1 - h_1 & = frac(1 - Theta, 1 - Theta^M) $ Damit ist
  $ 1 - h_j = frac(1 - Theta, 1 - Theta^M) dot frac(1 - Theta^j, 1 - Theta) $
  und folglich
  $ => h_j = 1 - frac(1 - Theta^j, 1 - Theta^M) "für" j = 0, ..., M $

]
#example(title: [Ruinproblem bei unendlich reichem Gegner/Einfache Irrfahrt mit absorbierender Schranke])[

  Betrachte die Markovkette ${ X_n : n in bb(N)_0 }$ mit Zustandsraum
  $S = bb(N)_0$ und
  $
    p_(i j) = cases(
      1 & "falls" i = 0 "und" j = 0,
      p & "falls" i in bb(N)_0 "und" j = i + 1,
      1 - p & "falls" i in bb(N)_0 "und" j = i - 1,
      0 & "sonst",

    )
  $
  Berechne die Absorptionswahrscheinlichkeiten. \
  $h_i = P(T < oo \| X_0 = i)$ mit $i in S$ und
  $T = inf { n in bb(N)_0 : X_n = 0 }$. \
  Es gilt $h_0 = 1$ und Nach Satz 10
  $ h_i = p h_(i + 1) + (1 - p) h_(i - 1) "für" i = 1, 2, ... $
  Mit $Theta = frac(1 - p, p)$ gilt somit (siehe Bsp. 9)
  $ h_(i + 1) - h_i = Theta (h_i - h_(i - 1)) "für" i = 1, 2, ... $
  und daher
  $ h_(i + 1) - h_i = Theta^i (h_1 - h_0) = Theta^i (h_1 - 1) "für" i = 0, 1, ...space (star) $
  Sei nun $p <= 1 / 2$, also $Theta >= 1$. \
  Dann gilt
  $ h_i - h_(i + 1) =^((star)) Theta^i (1 - h_1) >= 1 - h_1 $ also
  $ h_(i + 1) <= h_i - (1 - h_1) "für" i = 0, 1, ... $
  Angenommen $h_1 < 1$, dann würde daraus folgen, dass
  $h_(i + 1) - h_i <= 0$ und damit wäre
  $lim_(i -> oo) h_i = - oo$. Dies wäre offensichtlich ein Widerspruch! \
  Also muss $h_1 = 1$ sein.
  $ =>^((star)) h_(i + 1) - h_i = 0 "für" i = 0, 1, ... $
  $ => h_i = 1 "für alle" i = 0, 1, ..., "falls" p <= 1 / 2 $
  Insbesondere ist auch bei einem fairen Spiel ($p = 1 / 2$) die Ruinwahrscheinlichkeit $h_i = 1$ für jedes Anfangskapital $i$.
  \
  Sei nun $p > 1 / 2$ (nicht-faires Spiel mit höherer Wahrscheinlichkeit Geld zu verlieren), also $Theta < 1$. Aus $(star)$ folgt
  durch Summation (wie in Bsp. 9)
  $
    sum_(i = 0)^(j - 1) (h_(i + 1) - h_i) & = h_j - h_0\
    & = h_j - 1\
    & = (h_1 - 1) sum_(i = 0)^(j - 1) Theta^i\
    & = (h_1 - 1) frac(1 - Theta^j, 1 - Theta)
  $
  $ => h_i = 1 + (h_1 - 1) frac(1 - Theta^j, 1 - Theta) "für" j = 0, 1, ... $
  Für jedes $h_1 in [0, 1]$ erfüllt diese Gleichung die Gleichung
  $(star)$. \
  Wegen $0 <= lim_(j -> oo) h_i = 1 + frac((h_1 - 1), 1 - Theta)$
  $
    0 & <= 1 + frac(h_1 - 1, 1 - Theta)\
    Theta - 1 & <= h_1 - 1\
    h_1 & >= Theta
  $

  Welches $h_1 in [Theta, 1]$ liefert die gesuchten Wahrscheinlichkeiten? \
  Hinweis: Hier gibt es keine zweite Randbedingung, wie in Bsp. 9!

]
#theorem[
  Sei ${ X_n : n in bb(N)_0 }$ eine Markovkette mit Zustandsraum $S$ und Übergangsmatrix $(P_(i j))$. Sei zudem $A ⊂ S$ mit
  $A != nothing$. Seo $T_i = inf { n in N : X_n in A }$ und
  $h_i = P(T_i < oo \| X_0 = i)$. Dann ist $(h_i)_(i in S)$ die
  #strong[komponentenweise kleinste nicht-negative Lösung] des Gleichungssystems $   & x_i = 1 "für alle" i in A\
    & x_i = sum_(j in S) p_(i j) x_j "für alle" i in S without A $
  Das heißt

  + $(x_i) = (h_i)$ ist eine nicht-negative Lösung.

  + Für jede Lösung $(x_i)$ mit $x_i >= 0$, $i in S$ gilt
    $h_i <= x_i$.

] <thm:solution_markov>
#proof(title: [Beweis von @thm:solution_markov])[

  Die Behauptung ist klar, wenn $A = S$. Deswegen sei $A != S$:

  + $(h_i)$ ist eine nichtnegative Lösung nach Satz 10.

  + Sei $(x_i)$ eine Lösung mit $X_i >= 0$, $i in S$.
    $
      => x_i = overbrace(sum_(j in A) p_(i j), := r_i) dot 1 + overbrace(sum_(j in A^c) p_(i j), := Q) x_j, i in A^c
    $
    Für die Spaltenvektoren $x = (x_i)_(i in A^c)$, $r = (r_i)_(i in A^c)$
    und die Teilmatrix $Q = (p_(i j))_(i, j in A^c)$ gilt durch iteratives Einsetzen $ x & = r + Q x\
    & = r + Q (r + Q x)\
    & = r + Q r + Q^2 x\
    & = r + Q r + Q^2 (r + Q x)\
    & dots.v\
  x & = r + sum_(k = 1)^n Q^k r + Q^(n + 1) x, n >= 1 $

  Daraus folgt also für alle $i in A^c$, $j in A$ und $n >= 1$ durch Einsetzen, wobei $Q^k r = p_(i j_k)^k p_(j_k j)$ und $Q^(n + 1) x$ als
  strikt positiver Wert für die untere Schranke ausgelassen werden kann, folgendes:
  $
    x_i & >= p_(i j) + sum_(k = 1)^n sum_(j_1, ..., j_k in A^c, j in A) p_(i j_1) p_(j_1 j_2)... p_(j_k j)\
    <=> x_i & >= P_i (X_1 in A) + sum_(k = 1)^n P(X_1 in A^c, ..., X_k in A^c, X_(k + 1) in A)\
    <=> x_i & >= P_i (T <= n + 1)\
    => x_i & >= lim_(n -> oo) P_i (T <= n + 1) = lim_(n -> oo) P_i (T <= n) = h_i, i in A^c
  $
]

#block[
  Im Fall von $p > 1 / 2$ wurde gezeigt, dass die nichtnegativen Lösungen des Gleichungssystems (wie in Satz 11)
  charakterisiert sind durch
  $ x_i = 1 + (x_1 - 1) frac(1 - Theta^i, 1 - Theta) $ mit
  $x_1 in [Theta, 1]$. \
  Aus Satz 11 lässt sich nun folgern, dass die Komponentenweise kleinste Lösung gegeben ist bei $x_1 = Theta$ und damit
  $ h_i = 1 + (Theta - 1) frac(1 - Theta^i, 1 - Theta) = Theta^i = (frac(1 - p, p))^i $

]
Für die folgenden Schritte werden folgende Rechenregeln für
$bb(R)^(‾) = bb(R) ∪ { - oo, oo }$ benötigt:

- $- oo < a < oo quad forall a in bb(R)$

- $a + oo = oo + a = oo quad forall a in bb(R) ∪ { oo }$

- $a - oo = - oo + a = - oo quad forall a in bb(R) ∪ { - oo }$

- $a dot oo = oo dot a = oo quad forall a in bb(R)^(‾)^(+)$

- $a dot oo = oo dot a = - oo quad forall a in bb(R)^(‾)^(-)$

- $a dot (- oo) = (- oo) dot a = - oo quad forall a in bb(R)^(‾)^(+)$

- $a dot (- oo) = (- oo) dot a = oo quad forall a in bb(R)^(‾)^(-)$

- $0 dot oo = oo dot 0 = 0$ (spezielle Konnotation in diesem Kontext)

- Nicht definiert sind: $oo - oo$ und $- oo + oo$.

Ist $X$ eine Zufallsvariable mit Werten in $bb(N)_0 ∪ { oo }$, dann ist $ E [X] & = sum_(n = 0)^oo n P(X = n)\
      & = sum_(n = 0)^oo P(X > n)\
      & = sum_(n = 1)^n P(X >= n) $ Insbesondere ist also falls
$P(X = oo) > 0$ auch $E [X] = oo$.

#theorem[
  Sei ${ X_n : n in bb(N)_0 }$ eine Markovkette mit Zustandsraum $S$ und Übergangsmatrix $(P_(i j))$. Sei $A in S$ und $A != nothing$.
  Für
  $i in S$ sei $ T   & := inf { n in bb(N)_0 : X_n in A }\
  k_i & := E [T \| X_0 = i] $ $(k_i)_(i in S)$ ist die
  #strong[komponentenweise kleinste nichtnegative Lösung] des Gleichungssystems $(star)$

  $
    k_i & = 0, i in A\
    k_i & = 1 + sum_(j in S without A) p_(i j) k_j, "für alle" i in S without A
  $

  mit $k_i in [0, oo]$.

] <thm:solution_markov2>
#proof(title: [Beweis von @thm:solution_markov2])[

  Die Behauptung ist klar für $A = S$. Sei also $A != S$.

  - Für $(k_i)_(i in S)$ gilt $   & k_i in [0, oo] quad forall i in S\
    & k_i = 0 quad forall i in A $ Für $i in S without A$ gilt
    $
      k_i & = sum_(j in S) E [T \| X_0 = i, X_1 = j] p_(i j)\
      & = sum_(j in S) (1 + E [T \| Y_0 = j]) p_(i j) "(siehe Aufgaben)"\
      & = 1 + sum_(j in S without A) p_(i j) k_j
    $ $=> (k_i)$
    löst $(star)$.

  - Sie nun $(x_i)_(i in S)$ eine Lösung von $(star)$ mit
    $x_i in [0, oo]$. Zu zeigen ist, dass $x_i >= k_i quad forall i$. Für $i in A$ gilt $x_i = k_i = 0$. Für die
    Spaltenvektoren
    $ x = (x_i)_(i in A^c) "und" e = vec(1, dots.v, 1) $ und
    $ Q = (p_(i j))_(i, j in A^c) $ gilt (siehe auch Beweis Satz 11)
    $
      x & = e + Q x\
      & dots.v\
      & = e + sum_(k = 1)^n Q^k e + Q^(n + 1) x, "für" n >= 1
    $

    und somit für alle $i in A^c$ und $n >= 2$, wobei ... und
    $Q^(n + 1) x$ als strikt positiver Wert für die untere Schranke ausgelassen werden kann,

    $
      x_i & >= 1 + sum_(j in A^c) p_(i j) + sum_(k = 2)^n sum_(j_1, ..., j_k in A^c) p_(i j_1)... p_(j_(k - 1) j_k)\
      <=> x_i & >= P_i (T > 0) + P_i (X_1 in A^c) + sum_(k = 2)^n P - i (X_1 in A^c, X_2 in A^c, ..., X_k in A^c)\
      <=> x_i & >= P_i (T > 0) + P_i (T > 1) + sum_(k = 2)^n P_i (T > k)\
      <=> x_i & >= sum_(k = 0)^n P_i (T > k)\
      => x_i & >= sum_(k = 0)^oo P_i (T > k) = E_i [T] = k_i
    $
]
#block[
  Nun ist die erwartete Absorptionszeit $k_i = E_i [T]$ mit gesucht. \
  Offensichtlich ist $k_0 = 0$ und $k_M = 0$. Aus Satz 12 folgt hier
  $
    (star) quad k_i = 1 + (1 - p) k_(i - 1) + p k_(i + 1)
  $ Sei zunächst $p = 1 / 2$. $ k_i                 & = 1 + k_(i - 1) / 2 + k_(i + 1) / 2\
  <=> k_(i + 1) - k_i & = k_i - k_(i - 1) - 2 $

  Für steigende i fällt das das Wachstun von $k_i$ um den Faktor 2.
  $ => k_(i + 1) - k_i = k_1 - k_0 - 2 i = k_1 - 2 i quad i = 0, ..., M - 1 $

  Für $j = 1, ..., M$ ist
  $
    k_j - k_0 = k_j & = sum_(i = 0)^(j - 1) (k_(i + 1) - k_i)\
    & = j k_1 - 2 sum_(i = 0)^(j - 1) i\
    & = j k_1 - (j - 1) j
  $

  Wegen $k_M = 0$ folgt aus dieser Gleichung (durch einsetzen)
  $k_1 = M - 1$ und somit
  $ E [T \| X_0 = j] = k_j = j (M - j), j = 0, ..., M $

  Sei nun $p != 1 / 2$. \
  In diesem Fall lässt sich zeigen, dass $k_i$ als Lösung von $(star)$
  die Form
  $ k_i = frac(i, 1 - 2 p) + alpha + beta dot (frac(1 - p, p))^i "für" i = 0, ..., M $
  haben muss für gewisse $alpha, beta in bb(R)$. Mit $k_0 = k_m = 0$
  folgt $ 0                   & = alpha + beta\
  0                   & = frac(M, 1 - 2 p) + alpha + beta dot (frac(1 - p, p))^M\
  => alpha            & = - beta = frac(- frac(M, 1 - 2 p), 1 - (frac(1 - p, p))^M)\
  => E [T \| X_0 = i] & = frac(i, 1 - 2 p) - frac(M, 1 - 2 p) dot frac(1 - (frac(1 - p, p))^i, 1 - (frac(1 - p, p))^M), i = 0, ..., M $

]
== Konvergenzsätze

#theorem[
  Sei ${ X_n : n in bb(N)_0 }$ eine Markovkette mit Zustandsraum $S$ und Übergangsmatrix $(P_(i j))$. \
  Die stationäre Verteilung der Markovkette $(pi_i)$ mit

  - $pi_i >= 0 quad forall i in S$

  - $sum_(i in S) pi_i = 1$

  ist definiert durch $ pi_j = sum_(i in S) pi_i p_(i j) $ oder ausgedrückt in Matrix Schreibweise $       & pi = pi (P_(i j))\
  <=> & pi ((P_(i j)) - I) = 0 $

] <thm:markov-stationär>
#remark(title: [Bemerkung zu Satz 13])[

  - Für jede Markovkette mit endlichem Zustandsraum existiert eine stationäre Verteilung (s. Aufgaben).

  - Bezeichnet $p^((n)) = (P_i^((n)))_(i in S)$, $P_i^((n)) = P(X_n = i)$
    die Anfangsverteilung von $X_n$ und ist die Anfangsverteilung stationär, dann gilt
    $ P^((n)) = P^((0)) Pi^n = p^((0)) Pi Pi^(n - 1) =... = P^((0)), $
    d.h.
    $P(X_n = i) = P(X_0 = i) quad forall n >= 0 "und" i in S$.

  - Ist der Zustandsraum endlich und existiert für jedes $j in S$ der Grenzwert $ pi_j = lim_(n -> oo) P(X_n = j), $ dann
    muss
    $(pi_i)$ eine stationäre Verteilung sein, denn
    $
      & pi_i >= 0 quad forall i in S\
      & sum_(i in S) pi_i = lim_(n -> oo) sum_(i in S) P(X_n = i) = 1
    $
    und $ pi_j & = lim_(n -> oo) P(X_(n + 1) = j)\
       & = lim_(n -> oo) sum_(i in S) P(X_n = i) p_(i j)\
       & = sum_(i in S) lim_(n -> oo) P(X_n = i) p_(i j)\
       & = sum_(i in S) pi_i p_(i j) quad forall j in S $
]
#example[
  Gegeben sei eine Markovkette ${ X_n : n in bb(N)_0 }$ mit Zustandsraum
  $S = { 1, 2 }$ und Übergangsmatrix
  $Pi = mat( (1 - a), a;b, (1 - b))$ ($a, b in (0, 1)$) Es gilt
  $
    Pi^((n)) = frac(1, a + b) mat( b + (1 - a - b)^n a, a - (1 - a - b)^n a;b - (1 - a - b)^n b, b + (1 - a - b)^n b)
  $
  und da $lim_(n -> oo) (1 - a - b)^n = 0$ folgt
  $ lim_(n -> oo) Pi^((n)) = frac(1, a + b) mat( b, a;b, a) $
  Damit ist für $i in S$
  $ lim_(n -> oo) P_(i 1)^((n)) = frac(b, a + b) $ und
  $ lim_(n -> oo) P_(i 2)^((n)) = frac(a, a + b) $ Für jede Anfangsverteilung
  $mat( p_1, p_2) = (P(X_0 = 1), P(X_0 = 2))$ gilt
  $
    lim_(n -> oo) (P(X_n = 1), P(X_n = 2)) & = lim_(n -> oo) mat( p_1, p_2) Pi^n\
    & = frac(1, a + b) mat( p_1, 1 - p_1) mat( b, a;b, a)\
    & = mat( f r a c b a + b, frac(a, a + b)) //TODO correct this
  $ Die Grenzverteilung ist also unabhängig von der Anfangsverteilung. \
  Ist die Anfangsverteilung gleich der Grenzverteilung, also
  $p_1 = frac(b, a + b)$ und $p_2 = frac(a, a + b)$, dann gilt
  $
    mat( p_1, p_2) Pi = frac(1, a + b) mat( b, a) mat( 1 - a, a;b, 1 - b) = frac(1, a + b) mat( b, a) = mat( p_1, p_2)
  $
  und daher $mat( p_1, p_2) Pi^n = mat( p_1, p_2)$.

]
#theorem[

  Sei $Pi = (P_(i j))$ die Übergangsmatrix einer Markovkette
  ${ X_n : n in bb(N)_0 }$ mit stationäre Verteilung
  $pi = mat( pi_1, ..., pi_S)$. \
  $exists quad 0 < epsilon < 1$, sodass
  $
    p_(i j) & >= epsilon pi_j quad forall quad i, j = 1, ..., S\
    => sum_(j = 1)^S lr(|p_(i j)^n - pi_j|) & <= 2 (1 - epsilon)^n.
  $

] <thm:convergence_markov>
Aus dem Satz folgt also, dass eine Markovkette für steigende $n$
exponentiell zur stationären Verteilung konvergiert.\

#proof(title: [Beweis von @thm:convergence_markov])[

  Setze $M = vec(pi, dots.v, p i) in bb(R)^(S times S)$ und
  $Q : = frac(1, 1 - epsilon) (pi - epsilon M)$. $M$ und $Q$ sind positive stochastische Matrizen und
  $ pi = (1 - epsilon) Q + epsilon M $ Mit
  $e = vec(1, dots.v, 1) in bb(R)^S$ ist $M = e pi$ und
  $
    M^2 & = e overbrace(pi e, 1) pi = M\
    Pi M & = overbrace(Pi e, e) pi = e pi = M\
    M Pi & = e overbrace(pi Pi, pi) = M,
  $ da $pi$ stationär ist. Daraus folgt also $Q M = M$ und $M Q = M$.\
  Das Produkt einer endlichen Folge von $Q$s und $M$s, die mindestens ein
  $M$ enthält, ist gleich $M$.\
  Für jeden $n in bb(N)$ gilt:
  $
    pi^n & = [(1 - epsilon) Q + epsilon M]^n\
    & = (1 - epsilon)^n Q^n + sum_(l = 0)^(n - 1) vec(n, l) (1 - epsilon)^l epsilon^(n - l) M\
    & = (1 - epsilon)^n Q^n + (1 - (1 - epsilon)^n) M\
    => pi^n - M & = (1 - epsilon)^n (Q^n - M) quad forall quad n in bb(N)_0
  $
  Für jede Zeile $i = 1, ..., S$ folgt damit (unter Verwendung der Dreiecksungleichung):
  $
    sum_(j = 1)^S lr(|p_(i j)^n - pi_j|) & = (1 - epsilon)^n sum_(j = 1)^S lr(|{ Q_(i j)^n } - pi_j|)\
    & <= (1 - epsilon)^n sum_(j = 1)^S ({ Q_(i j)^n } + pi_j) = 2 (1 - epsilon)^n
  $
]
#theorem[

  Sei $Pi = (P_(i j))$ die Übergangsmatrix einer Markovkette mit Zustandsraum ${ 1, ..., S }$ und stationärer Verteilung
  $pi = mat( pi_1, ..., pi_S)$. \
  Es existiere $k in bb(N)$, $epsilon in (0, 1)$, sodass
  $
    p_(i j)^k & >= epsilon pi_j quad forall quad i, j = 1, ..., S\
    => sum_(j = 1)^S lr(|p_(i j)^n - pi_j|) <= 2 (1 - epsilon)^(⌊ n / k ⌋)
  $
] <thm:convergence_markov2>

#proof(title: [Beweis von @thm:convergence_markov2])[

  Wende hier @thm:convergence_markov auf $Pi^k$ an.\
  $pi$ ist auch eine stationäre Verteilung für $Pi^k$ und
  $ (Pi^k)^m = Pi^(k m) = (P_(i j)^(k m)) $ Damit liefer @thm:convergence_markov:
  $
    sum_(j = 1)^S lr(|P_(i j)^(k m) - pi_j|) <= 2 (1 - epsilon)^m quad forall quad i = 1, ..., S "und" m = 1, 2, 3, ...
  $
  Sei $n in bb(N)_0$, $m = ⌊ n / k ⌋$, $r = n - k m >= 0$.
  $
    => sum_(j = 1)^S lr(|p_(i j)^n - pi_j|) & = sum_(j = 1)^S lr(|sum_(l = 1)^S p_(i l)^r (p_(l j)^(k m) - pi_j)|)\
    & <= sum_(l = 1)^S p_(i l)^r sum_(j = 1)^S lr(|p_(l j)^(k m) - pi_j|)\
    & <= 2 (1 - epsilon)^m = 2 (1 - epsilon)^(⌊ n / k ⌋)
  $
]

Unter den Voraussetzungen von Satz 15 gilt:\
$lim_(n -> oo) P_(i j)^n$

- existiert für alle $i, j in S$,

- ist unabhängig von $i$,

- und ist gegeben durch die stationäre Verteilung.

Ist ${ X_n : n in bb(N)_0 }$ eine Markovkette mit Übergangsmatrix
$(P_(i j))$, dann
$
  sum_(j = 1)^S lr(|P(x_n = j) - pi_j|) & = sum_(j = 1)^S lr(|(sum_(i = 1)^S P(X_0) i) p_(i j)^n - pi_j|)\
  & = sum_(j = 1)^S lr(|sum_(i = 1)^S P(X_0 = i) (p_(i j)^n - pi_j)|)\
  & <= sum_(i = 1)^S P(X_0 = i) sum_(j = 1)^S lr(|p_(i j)^n - pi_j|)\
  & <= 2 (1 - epsilon)^(⌊ n / k ⌋)\
  => lim_(n -> oo) P(X_n = j) & = pi_j
$

Sind alle Einträge von $Pi^n$ positiv, dann ist die Voraussetzung
$p_(i j^n) >= epsilon pi_j$ ($i, j = 1, ..., S$) mit
$epsilon : = m i n_(i, j) quad p_(i j)^n$ erfüllt.

#block[
  Sei nun $a = b = 1$, also $ Pi = mat( 0, 1;1, 0) $ dann gilt
  $
    Pi^n = cases(
      mat( 1, 0;0, 1) & "für" n "gerade",
      mat( 0, 1;1, 0) & "für" n "ungerade",

    )
  $
  $lim_(n -> oo) P_(i j)^n$ existiert also nicht! \
  Die Markovkette zeigt periodisches Verhalten.

]

#definition[
  Die Periode $d_i$ eines Zustands $i$ einer Markovkette ist die größte ganze Zahl, die alle $n in bb(N)$ mit $P_(i i)^n > 0$ teilt:
  $ d_i = g g T ({ n in bb(N) . : P_(i i)^n > 0 }) $
  $ d_i = oo, "falls" P_(i i)^n = 0 quad forall quad n in bb(N) $
  Ein Zustandsraum mit Periode 1 heißt #strong[aperiodisch];. Die Markovkette heißt aperiodisch, falls alle ihre Zustände
  aperiodisch sind.]

#example[
  - Für $S = { 1, 2 }$ und $Pi = mat( 0, 1;1, 0)$ gilt
    $
      & d_1 = g g t ({ 2, 4, 6, ... }) = 2\
      & d_2 = 2
    $

  - Jeder Zustand $i$ mit $p_(i i) > 0$ ist aperiodisch.

  - Für die einfache Irrfahrt auf $bb(Z)$ mit $p in (0, 1)$ gilt
    $ d_i = 2 quad forall quad i in bb(Z) $

]
#theorem[

  Für jeden aperiodischen Zustand $i$ existiert $n_0 (i) in bb(N)$, sodass
  $ p_(i i)^n > 0 quad forall quad n >= n_o (i) $

] <thm:periodic_markov>
#example[
  Sei $ Pi = mat( 0, 1, 0;0, 0, 1;1 / 2, 0, 1 / 2) $
  $P_11^1 = 0$, $P_11^2 = 0$.Für $n >= 3$ ist aber
  $ p_11^n >= p_12 p_23 p_33^(n - 3) p_31 = (1 / 2)^(n - 2) > 0 $
  $=>$ Zustand 1 ist aperiodisch. Es gilt nicht, dass
  $P_11^n > 0$ für alle $n in bb(N)$, aber für $n >= 3 = n_0 (1)$.
]
#proof(title: [Beweis von @thm:periodic_markov])[

  Zunächst ist für den Beweis folgendes Lemma notwendig:

  #lemma()[
Ist $N ⊂ bb(N)$, $N != nothing$ abgeschlossen unter Addition, d.h. $n + m in N quad forall quad n, m in N$ und ist $g g T (N) = 1$,
dann existiert $n_0 in bb(N)$, sodass $n in N quad forall n >= n_0$.\
]Um auch dies zu beweisen, muss zunächst gezeigt werden, dass $N$ zwei aufeinander folgende Zahlen $n_1$, $n_1 + 1$ enthält.
  Setze dazu
  $ M : = { n - n' : n, n' in N, n' < n } $ $ m := m i n (M) $ und sei
  $n_1, n_2 in N$, sodass $m = n_2 - n_1$. Zeige $m = 1$. Nehme dafür zunächst an, dass $m != 1$.\
  $=> m > 1$ und somit $m > g g t (N)$. $m$ teilt nicht alle Elemente von $N$.\
  $=>$ Es gibt $n in N$ und $k in bb(N)_0$ mit
  $ k m < n < (k + 1) m, $ also $ 0 < n - k m < m $ und
  $
    n - k m & = n - k (n_2 - n_1)\
    & = overbrace(n + k n_1 + n_2, in N) - overbrace((k + 1) m_2, in N) quad in M
  $
  Widerspruch zur Definition von $m$! Also muss $m = 1$ und
  $n_1, n_1 + 1 in N$.\
  Jede natürliche Zahl $n in bb(N)$ lässt sich schreiben als
  $
    n & = q n_1 + r "mit" q in bb(N)_0 "und" r < n_1\
    => n & = q n_1 + r (n_1 + 1 - n_1)\
    & = r (n_1 + 1) + (q - r) n_1
  $ Für $m >= n_1^2$ ist $q >= n_1$, also $q - r > 0$ und es folgt $n in N$. Es folgt also die Behauptung mit
  $n_0 = n_1^2$.\
  Nun zum Beweis von @thm:periodic_markov: Sei $i$ ein aperiodischer Zustand, für
  $ N_i : = { n in bb(N) : P_(i i)^n > 0 } $ gelte also $g g t (N_i) = 1$, insbesondere $N_i != nothing$.\
  $N_i$ ist abgeschlossen unter Addition, denn für $n, m in N$ gilt
  $ P_(i i)^(n + m) = sum_j p_(i j)^n p_(j i) m >= p_(i i)^n p_(i i)^m > 0 $
  $=>$ Es gibt $n_0 (i)$ mit $P_(i i)^n > 0$
  $forall n >= n_0 (i)$.
]

Eine Markovkette und ihre Übergangsmatrix heißen #strong[irreduzibel];, falls es für alle $i, j in S$ ein $n >= 0$ gibt
mit $p_(i j)^n > 0$.

- $(P_(i j))$ ist genau dann irreduzibel, wenn es für alle $i, j in S$
  mit $i != j$ eine Folge von Zuständen $i_0, ..., i_n in S$
  gibt, mit $i_0 = i, ..., i_n = j$ und
  $p_(i_0 i_1) > 0, ..., p_(i_(n - 1) i_n) > 0$.

- Jede irreduzibel Markovkette mit endlichem Zustandsraum $S$ hat eine eindeutige stationäre Verteilung $(pi_i)_(i in S)$.

Positivität:\
Es existiert ein $i_0 in S$ mit $pi_(i_0) > 0$. Für jedes $j in S$
existiert $n in bb(N)_0$ mit $P_(i_0 j)^n$ und daher
$ pi_j = sum_(i in S) pi_i p_(i j)^n >= pi_(i_0) p_(i_0 j)^n > 0 $
Eindeutigkeit:\
Sei $(tilde(pi)_i)_(i in S)$ eine weitere stationäre Verteilung. Sei
$k in S$ so, dass$ tilde(pi)_k / pi_k <= tilde(pi)_i / pi_i quad forall i in S $
$
  => tilde(pi)_k = sum_(j in S) tilde(pi)_i p_(i k)^n >= tilde(pi)_k / pi_k overbrace(sum_(i in S) pi_i p_(i k)^n, pi_k) = tilde(pi)_k quad forall n >= 0
$
$=>$ Für $n >= 0$ und $i in S$ gilt
$ tilde(pi)_i p_(i k)^n = tilde(pi)_k / pi_k pi_i p_(i k)^n $ Wähle $n$
mit $P_(i k)^n > 0$
$ => tilde(pi)_i = tilde(pi)_k / pi_k pi_i, $
d.h. $(tilde(pi)_i)$ ist proportional zu $(pi_i)$. Und da
$sum tilde(pi)_i = sum pi_i$
$ => tilde(pi)_i = pi_i quad forall quad i in S $

#theorem[

  Sei $(P_(i j))$ die Übergangsmatrix einer irreduziblen Markovkette mit Zustandsraum $S = { 1, ..., s }$ und mindestens
  einem aperiodischen Zustand. \
  $=>$ Es existiert eine eindeutige stationäre Verteilung
  $(pi_i)_(i in S)$ und
  $ lim_(n -> oo) P_(i j)^n = pi_j > 0 quad forall quad i, j in S $
] <thm:stationary_markov>
#proof(title: [Beweis @thm:stationary_markov])[

  Zeige: Es gibt ein $N in bb(N)$ (unabhängig von $i, j$), sodass
  $ P_(i j)^N > ß quad forall quad i, j in S $ Sei $i_0 in S$
  aperiodisch.\
  $=>$ Es gibt ein $n_0 in bb(N)$, sodass
  $
    P_(i_0 i_0)^n > 0 quad forall n >= n_0
  $ Da $(P_(i j))$ irreduzibel ist, gibt es für alle $i, j in S$ ein $n_(i j) in bb(N)_0$ mit
  $P_(i j)^(n_(i j)) > 0$.\
  Setze $N := 2 m a x { n_(i j) : i, j in S } + n_0$.
  $
    => p_(i j)^N >= p_(i i_0)^(n_(i i_0)) p_(i_0 i_0)^(overbrace(N - n_(i i_0) - n_(i_0 j)^(>= n_0))) p_(i_0 j)^(n_(i_0 j)) > 0 quad forall quad i, j in S
  $

  Bemerkung: Unter den Voraussetzungen von @thm:stationary_markov gibt es für jeden Zustand $i$ ein $n_0 (i) in bb(N)$, sodass
  $P_(i i)^n > 0 quad forall quad n >= n_0 (i)$. Daher ist dann jeder Zustand aperiodisch.]

#strong[Interpretation der Grenzverteilung] \
Es gelte
$ pi_j = lim_(n -> oo) P_(i j)^n = lim_(n -> oo) P(X_n = j \| X_0 = i) $
Ist $(a_n)_(n = 1)^oo$ eine Folge reeller Zahlen mit
$lim_(n -> oo) a_n = a$, dann gilt auch
$ 1 / n sum_(k = 0)^(n - 1) a_k = a, $ also hier
$ lim_(n -> oo) 1 / n sum_(k = 0)^(n - 1) P_(i j)^k = pi_j $ und dahier ist
$
  1 / n sum_(k = 0)^(n - 1) P_(i j)^k & = 1 / n sum_(k = 0)^(n - 1) P(X_k = j \| X_0 = i)\
  & = 1 / n sum_(k = 0)^(n - 1) E [bold("1")_({ X_k = j }) \| X_0 = i]\
  & = E [1 / n sum_(k = 0)^(n - 1) bold("1")_({ X_k = j }) \| X_0 = i]
$

Das heißt $pi_j$ ist der Grenzwert der erwarteten Zeitanteile, die die Markovkette in Zustand j verbringt.

#example[
  HIER FEHLT EINE ERGÄNZUNG ZU AUFGABE 29
]
== Rekurrenz und Transienz
#definition[
  Sei ${ X_n : n in bb(N)_0 }$ eine Markovkette mit Zustandsraum S.

  Für jedes $j in S$ sei
  $ tau_j := inf { n >= 1 : X_N = j } quad (inf nothing = oo). $
]

In Worten: $tau_j$ ist der erste Zeitpunkt $n >= 1$, zu
dem die Markovkette $j$ besucht, falls es einen gibt.\
Für $i, j in S$ sei $ f_(i j) = P(tau_j < oo \| X_0 = i) $ In Worten:
$f_(i j)$ ist die Wahrscheinlichkeit, dass $j$ in endlicher Zeit ($>= 1$) erreicht wird bei Start in $i$. Insbesondere
ist $f_(j j)$
die Wahrscheinlichkeit einer Rückkehr.\
Ein Zustand $j in S$ heißt #strong[rekurrent];, falls $f_(j j) = 1$. Er heißt #strong[transient];, falls $f_(j j) < 1$.
Sind alle Zustände rekurrent oder transient, dann heißt auch die Markovkette rekurrent oder transient.

#example[
  Sei $S = { 1, 2, 3 }$ und
  $
    (P_(i j)) = mat(
    0.5, 0.5, 0;
    0.5, 0.5, 0;
    1 / 3, 1 / 3, 1 / 3)
  $
  Dann ist $ f_11 & = sum_(n = 1)^oo P(tau_1 = n \| X_0 = 1)\
       & = sum_(k = 1)^oo P(X_n = 1, X_k = 2 "mit" 1 <= k < n \| X_0 = 1)\
       & = sum_(n = 1)^oo (1 / 2)^n = 1 $ Folglich ist 1 rekurrent. Ebenso auch 2.
  $ f_33 = P(tau < oo \| X_0 = 3) = P(X_1 = 3 \| X_0 = 3) = 1 / 3 < 1 $
  3 ist also transient und somit die Markovkette weder transient noch rekurrent.

]
#theorem[

  Für $j in S$ sei $ N_j = sum_(n = 1)^oo bold("1")_({ X_n = j }) $ die Anzahl der Zeitpunkte $>= 1$ zu denen Zustand $j$ besucht
  wird. \

  - Ist $j$ rekurrent, dann gilt für alle $i in S$
    $ P(N_j = oo \| X_0 = i) = f_(i j), P(N_j = 0 \| X_0 = i) = 1 - f_(i j) $
    und insbesondere
    $ P(N_j = oo \| X_0 = j) = f_(j j) = 1 "und" E [N_j \| X_0 = j] = oo $

  - Ist $j$ transient, dann gilt für alle $i in S$
    $ P(N_j < oo \| X_0 = i) = 1 "und" E [N_j \| X_0 = i] = frac(f_(i j), 1 - f_(j j)) < oo $
] <thm:recurrence_transience>
#proof(title: [Beweis @thm:recurrence_transience])[
  Setze $sigma_j = sup { n >= 1 : X_n = j }$, wobei
  $sup nothing = oo$. Ist $sigma_j$ endlich, dann ist $sigma_j$ der Zeitpunkt des letzten Aufenthalts in $j$. Für jedes $n in bb(N)$ gilt
  $
    P(sigma_j = n \| X_0 = i) & = P(X_n = j, X_m != j "für alle" m > n \| X_0 = i)\
    & = P(X_M != j "für alle" m > n \| X_n = j, X_0 = i) P(X_n = j \| X_0 = i)\
    & = lim_(n -> oo) P(X_(n + 1) != j, ..., X_(n + m != j) \| X_n = j, X_0 = i) P_(i j)^n\
    & = lim_(m -> oo) P(X_1 != j, ..., X_m != j \| X_0 = j) P_(i j)^n\
    & = (1 - f_(j j)) P_(i j)^n
  $
  $
    P(1 <= sigma_j < oo \| X_0 = i) & = sum_(n = 1)^oo P(sigma_j = n \| X_0 = i)\
    & = (1 - f j j) sum_(n = 1)^oo P_(i j)^n\
    & = (1 - f_(j j)) sum_(n = 1)^oo E [bold("1")_(X_n = j) \| X_0 = i]\
    & = (1 - f_(j j)) E [N_j \| X_0 = i]
  $

  - Sei $j$ rekurrent, also $f_(j j) = 1$.\
    $=> P(sigma_j = n \| X_0 = i) = 0$ für alle $n in bb(N)$.\
    $=> P(sigma_j in { - oo, oo }) = 1$, also
    $P(N_j in { 0, oo } \| X_0 = i) = 1$.\
    Es ist $P(N_j = 0 \| X_0 = i) = 1 - f_(i j)$ und es folgt
    $P(N_j = oo \| X_0 = i) = f_(i j)$.

  - Sei $j$ transient, also $f_(j j) < 1$.
    $ (1 - f_(j j)) E [N_j \| X_0 = i] = P(1 <= sigma_j < oo \| X_0 = i) <= 1 $
    $=> E [N_j \| X_0 = i] < oo$ und daher ist
    $P(N_j < oo \| X_0 = i) = 1$.
    $
      => P(1 <= sigma_j < oo \| X_0 = i) & = P(1 <= sigma_j)\
      & = P(tau_j < oo \| X_0 = i)\
      & = f_(i j)
    $
    $=> E [N_j \| X_0 = i] = frac(f_(i j), 1 - f_j j)$.
]

#remark(title: [Bemerkung zu @thm:recurrence_transience])[

  - Wegen $E [N_j \| X_0 = j] = sum_(n = 1)^oo P_(j j)^n$ liefert der Satz ein einfacheres Rekurrenzkriterium
    $ j "ist rekurrent" <=> sum_(n = 1)^oo P_(j j)^n = oo $

  - Im Allgemeinen kann eine Markovkette sowohl rekurrente als auch transiente Zustände haben.\
    Ist ${ X_n }$ irreduzibel, dann isn entweder alle Zustände rekurrent oder alle sind transient.\
    Denn: Falls es einen rekurrenten zustand $j$ gibt, dann gibt es für jedes $i in S$ $n_1, n_2 >= 0$ mit $P_(i j)^(n_1) < 0$,
    $P_(j i)^(n_2) > 0$ und daher
    $
      sum_(n = 1)^oo P_(i i)^n >= sum_(n = 1)^oo P_(i j)^(n_1) P_(j j)^n P_(j i)^(n_2) = overbrace(P_(i j)^(n_1) P_(j i)^(n_2), > 0) sum_(n =)^oo P_(j j)^n = oo
    $
    $=> quad i$ ist ebenfalls rekurrent.

  - Ist $j$ transient, dann gilt
    $lim_(n -> oo) P_(i j)^n = 0 quad forall quad i in S$, denn
    $ sum_(n = 1)^oo P_(i j)^n = E [N_j \| X_0 = i] = frac(f_(i j), 1 - f_(j j)) < oo $

  - Jede Markovkette mit endlichem Zustandsraum $S = { 1, ..., s }$ hat mindestens einen rekurrenten Zustand, denn sonst
    wäre
    $ 1 = lim_(n -> oo) sum_(j = 1)^s P_(i j)^n = sum_(j = 1)^s lim_(n -> oo) P_(i j)^n = 0 "Widerspruch!" $

  - Jede irreduzible Markovkette mit endlichem Zustandsraum ist rekurrent. Außerdem gilt für solche Markovketten $ E [tau_j \| X_0 = i] < oo $
    und daher ist
    $ P(N_j = oo \| X_0 = i) = f_(i j) = 1 quad forall quad i, j in S $
]
#example[
  Wie betrachten wieder die einfache Irrfahrt auf $bb(Z)$. \
  Da eine Rückkehr zum Zustand $i$ immer nur in 2 Schritten möglich ist, ist die Periode $d_i = 2$. \
  $ P_(i i)^(2 n) = vec(2 n, n) p^n (1 - p)^(2 n - n) $

  Wegen

  $ (vec(2 (n + 1), n + 1)) / (2 n) = ((2n + 2)(2n +1)) / ((n+1)^2 ) <= 4 $ //TODO is the denominator of (2 n) right?
  und
  $vec(2, 1) = 2$ gilt $ vec(2 n, n) <= 4^n $ Für $p != 1 / 2$ ist
  $P(1 - p) < 1 / 4$ und daher (unter Nutzung geom. Reihe)
  $
    sum_(n = 1)^oo P_(i i)^n = sum_(n = 1)^oo P_(i i)^(2 n) = sum_(n = 1)^oo vec(2 n, n) [P(1 - p)]^n <= sum_(n = 1)^oo [4 P(1 - p)]^n < oo
  $
  $=>$ Für $p != 1 / 2$ ist die einfache Irrfahrt transient. \
  Andererseits gilt $vec(2 n, n) >= frac(4^n, 2 sqrt(n))$ (Beweis durch vollst. Induktion hier ausgelassen). \
  Für $p = 1 / 2$ gilt daher
  $
    sum_(n = 1)^oo P_(i i)^n = sum_(n = 1)^oo vec(2 n, n) [P(1 - p)]^n >= sum_(n = 1)^oo frac(4^n, 2 sqrt(n)) (1 / 4)^n = 1 / 2 sum_(n = 1)^oo 1 / sqrt(n) = oo
  $
  $=>$ für $p = 1 / 2$ ist die einfache Irrfahrt rekurrent.

]
Ein Zustand $j$ heißt positiv rekurrent, falls $E_j [T_j] < oo$ und er heißt nullrekurrent, falls $E_j [T_j] = oo$. Ist
der Zustandsraum der Markovkette endlich, folgt aus Irreduzibilität bereits positive Rekurrenz und die Existenz einer
eindeutigen stationären Verteilung. Die Konvergenz zu einer eindeutigen stationären Verteilung (unabhängig von der
Anfangsverteilung) hingegen basiert (s. @thm:stationary_markov ) darauf, dass mindestens ein Zustand aperiodisch ist.

= Erneuerungsprozesse

#definition[
  Eine Erneuerung ist ein Ereignis, das zu zufälligen Zeitpunkten auftritt. Ein Erneuerungsprozess ist ein stochastischer
  Prozess, der die Anzahl der Erneuerungen bis zu einem Zeitpunkt $t$ beschreibt. Seien
  $Y_1, Y_2, ...$ i.i.d die Wartezeiten, also die Zeiten zwischen aufeinanderfolgenden Erneuerungen, mit $E [Y_i] = mu quad in (0, oo)$
  und $V a r [Y_i] = sigma^2$. Die Zeitpunkte der Erneuerungen seien definiert als $ T_n = Y_1 + Y_2 +... + Y_n $ Sei $N (t)$ die
  Anzahl der Erneuerungen bis zu einem Zeitpunkt $t$:
  $ N (t) = m a x { n in bb(N)_0 : T_n <= t } $
]

In Worten: $N (t)$ ist die maximale Anzahl an Erneuerungen, deren
Gesamtdauer $T_n$ nicht über
$t$ hinausgeht.\
Für jeden Zeitpunkt $t$ gilt
$ T_(N (t)) <= t < T_(N (t) + 1) quad (star) $

Nach dem starken Gesetz der großen Zahlen gilt mit Wahrscheinlichkeit 1, dass
$
  lim_(n -> oo) T_n / n = lim_(n -> oo) frac(Y_1 +... + Y_n, n) = lim_(n -> oo) 1 / n sum_(i = 1)^n Y_i = mu quad (star star)
$

Es gilt zudem $ lim_(t -> oo) N (t) = oo $ Um zu zeigen, dass dies gilt, sei anzunehmen, dass $N (t) <= M quad forall t$ mit
$N (t^(\*)) = M$.Das wiederum impliziert
$T_(M + 1) > t quad forall t > t^(\*)$. Das wiederum impliziert
$ T_(M + 1) = overbrace(Y_1 + Y_2 + Y_M, = t^(\*) < oo) + Y_(M + 1) = oo $
und damit $Y_(M + 1) = oo$. Das wäre ein Widerspruch, da dies
$P(Y = oo) > 0$ voraussetzen würde, was gemäß $E [Y] < oo$ nicht der Fall ist.

#theorem[

  Sei $0 < mu = E [Y_1] < oo$. Mit Wahrscheinlichkeit 1 gilt
  $ lim_(t -> oo) frac(N (t), t) = 1 / mu $
] <thm:renewal_mean>
#proof(title: [Beweis @thm:renewal_mean])[

  Mit $(star)$ und $(star star)$ folgt
  $ => frac(T_(N (t)), N (t)) <= frac(t, N (t)) < frac(T_(N (t) + 1), N (t) + 1) frac(N (t) + 1, N (t)) $
  und $ => & lim_(t -> oo) frac(T_(N (t)), N (t)) = mu\
   & lim_(t -> oo) frac(T_(N (t) + 1), N (t) + 1) = mu\
   & lim_(t -> oo) frac(N (t) + 1, N (t)) = 1\
=> & lim_(t -> oo) frac(t, N (t)) = mu $
]
#example[

  Zu betrachten sei ein Erneuerungsprozess ${ N (t) : t in bb(N)_0 }$, bei dem $Y_1, Y_2, ...$ i.i.d die Wartezeit bis
  zum Ausfall einer Glühbirne in einer Lampe mit einer Glühbirne beschreibt. Folglich ist
  $T_n$ die Zeit, bis die n-te Glühbirne ausgefallen ist, bzw. ausgetauscht werden musste. \
  Nehmen wir an, wir beobachten in Tagen $Y_1 = 100$, $Y_2 = 150$,
  $Y_3 = 125$, $Y_4 = 110$ und wir interessieren uns für $N (270)$.
  $ N (270) = m a x { n in bb(N)_0 : T_n <= 270 } = 2 $ Angenommen, wir beobachten an Tag 1000, dass die 7. Glühbirne
  ausgetauscht wird, was ist dann die erwartete Lebensdauer einer Glühbirne? Nach @thm:renewal_mean ist für einen unendlichen
  Zeithorizont
  $
    & "Anzahl ausgetauschter Glühbirnen bis Zeitpunkt t" / t\
    & -> 1 / "Erwartete Lebensdauer einer Glühbirne"
  $ Also ist $mu approx 1000 / 7 = 143$

]
#example[
  Zu betrachten sei ein Erneuerungsprozess ${ N (t) : t in bb(N)_0 }$, bei dem $Y_1, Y_2, ...$ i.i.d. die Zeitabstände
  zwischen Schadensfällen ist. Folglich ist $T_n$ die Zeit, bis die n-te Schadensmeldung eingegangen ist. \
  Wenn die Frage nach dem erwarteten Zeitabends zwischen zwei Meldungen ist, könnte nach @thm:renewal_mean wieder
  $ mu approx t / "Anzahl Meldungen bis Zeit t" $ berechnet werden. \
  Nun erhalte die Versicherung zu den Zeiten $T_1, T_2, ...$
  Schadensforderungen in Höhe von $X_1, X_2, ...$ i.i.d mit
  $E X_i < oo .$. Über die Gesamte Zeit häufen sich also
  $ X (t) = sum_(i = 1)^(N (t)) X_i $ an. Berechne
  $lim_(t -> oo) frac(X (t), t)$. \
  Da gilt $ lim_(t -> oo) frac(N (t), t) = frac(1, E [Y_1]) $ und
  $ lim_(n -> oo) 1 / n sum_(i = 1)^n X_i = E [X_i] $ folgt mit
  $lim_(t -> oo) N (t) = oo$
  $ => lim_(n -> oo) frac(1, N (t)) sum_(i = 1)^(N (t)) X_i = E [X_i] $
  Mittels @thm:renewal_mean erhalten wir
  $
    lim_(t -> oo) frac(X (t), t) = lim_(t -> oo) (frac(1, N (t)) sum_(i = 1)^(N (t))) frac(N (t), t) = frac(E [X_1], E [Y_1])
  $

]
#theorem[
  Sei $mu := E [Y_1]$, $sigma^2 := V a r [Y_1]$ mit $0 < mu < oo$ und
  $0 < sigma < oo$. \
  $=>$ Für $t -> oo$ ist $N (t)$ asymptotisch normalverteilt mit Parametern
  $ t / mu "und" frac(t sigma^2, mu^3), $ das heißt
  $ lim_(t -> oo) P(frac(N (t) - t / mu, sqrt(frac(t sigma^2, mu^3))) < y) = Phi (y) quad forall y in bb(R) $

] <thm:renewal_distribution>

#proof(title: [Beweis @thm:renewal_distribution])[

  Der Beweis nutzt $P(N (t) < n) = P(T_n > t)$, den zentralen Grenzwertsatz und folgendes Lemma: Seien $X_1, X_2, ...$
  ZUfallsvariablen, sodass
  $l i m_(n -> oo) P(X_n > x) = G (x) quad forall x in bb(R)$, wobei
  $G$ stetig ist. $=>$ Für alle
  $x, x_1, x_2, ... in bb(R)$ mit $lim_(n -> oo) X_n = x$ gilt
  $ lim_(n -> oo) P(X_n > x_n) = G (x) $ Sei nun $y in bb(R)$. Für alle $t > 0$ gilt
  $
    P(frac(N (t) - t / mu, sqrt(frac(t sigma^2, mu^3))) < y) & = P(N (t) < t / mu + y sigma sqrt(t / mu^3))\
    & = P(N (t) < n_t)
  $ mit $n_t = ⌈ t / mu + y sigma sqrt(t / mu^3) ⌉$.\
  Sei $t > 0$ so groß, dass $n_t >= 1$. Dann gilt
  $
    P(N (t) < n_t) & = P(T_(n_t) > t)\
    & = P(frac(T_(n_t) - n_t mu, sigma sqrt(n_t)) > frac(t - n_t mu, sigma sqrt(n_t)))
  $
  Und mit $lim_(t -> oo) n_t / t = 1 / mu$ ist
  $
    lim_(t -> oo) frac(t - n_t mu, sigma sqrt(n_t)) & = lim_(t -> oo) frac(t - (t / mu + y sigma sqrt(t / mu^3)) mu, sigma sqrt(n_t))\
    & = lim_(t -> oo) frac(- y sqrt(t / mu), sqrt(n_t))\
    & = - y
  $ Mit dem zentralen Grenzwertsatz und dem Lemma folgt also
  $ lim_(t -> oo) P(N (t) < n_t) = 1 - Phi (- y) = Phi (y) $
]
= Poisson-Prozesse

#definition[

  Eine Zufallsvariable X heißt exponentialverteilt mit Parameter
  $lambda > 0$ ($X tilde.op E X P(lambda)$), falls $X$ die Dichte
  $ f (x) = cases(lambda e^(- lambda x) & "falls" x > 0, 0 & "sonst") $
  hat.]

#definition[
  Sei $lambda$ eine Konstante $ > 0$. Seien $Y_1, Y_2, ...$ i.i.d. exponentialverteilte Zufallsvariablen für alle $n = 1, 2, ...$.\
  Setze $   & T_0 := 0\
  & T_n := Y_1 +... + Y_n\
  & N (t) : = m a x { n in bb(N)_0 : T_n <= t }, t >= 0 $
  Dann heißt ${ N (t) : t >= 0 }$ Poisson-Prozess mit Intensität
  $lambda$.\
  Ein stochastischer Prozess ${ N (t) : t >= 0 }$ heißt ein Prozess mit unabhängigen Zuwächsen, falls für je endlich viele
  Zeitpunkte
  $0 = t_0 < t_1 <... < t_k$ die Zufallsvariablen $   & N (t_0),\
  & N (t_1) - N (t_0),\
  & dots.v\
  & N (t_k) - N (t_(k - 1)) $ unabhängig sind.\
]
#theorem[
  Sei ${ N (t) : t >= 0 }$ ein Poisson-Prozess mit Intensität
  $lambda > 0$. \
  $=> { N (t) : t >= 0 }$ hat unabhängige Zuwächse und für
  $0 <= s < t$ gilt
  $ N (t) - N (s) tilde.op P O I (lambda (t - s)), $
  $ P(N (t) - N (s) = n) = e^(- lambda (t - s)) frac([lambda (t - s)]^n, n !) "für") n = 0, 1, ... $
] <thm:mean_poisson>

#proof(title: [Beweis @thm:mean_poisson])[
  Seien $Y_i$, $T_n$, $N (t)$ wie in der Definition eines Poisson-Prozesses.\
  Sei $k >= 2$, $0 = t_0 < t_1 <..., t_k$,
  $n_1, ..., n_k in bb(N)$ beliebig fest.
  $ => P(N (t_i) - N (t_(i - 1)) = n_i, i = 1, ..., k) = P((T_1, ..., T_(m + 1)) in B times (t_k, oo)), $
  wobei $m = n_1 +... + n_k$ und
  $B = { (s_1, ..., s_m) in bb(R)^m : 0 < s_1 <... < s_m, lr(|{ j : t_(i - 1) < s_j <= t_i }|) = n_i, i = 1, ..., k }$.
  $(T_1, ..., T_(m + 1))$ hat die Dichte
  $
    f (s_1, ..., s_(m + 1)) = cases(lambda^(m + 1) e^(- lambda s_(m + 1)) & "falls" 0 < s_1 <... < s_(m + 1), 0 & "sonst")
  $
  $
    P(N (t_i) - N (t_(i - 1)) = n_i, i = 1, ..., k) & = integral_(B times (t_k, oo)) f (s_1, ..., s_(m + 1)) thin d (s_1, ..., S_(m + 1))\
    & = lambda^(m + 1) (integral_B 1 thin d (s_1, ..., s_m)) integral_(t k)^oo e^(- lambda s_(m + 1)) thin d s_(m + 1)
  $
  An dieser Stelle ist zu nutzen, dass
  $
    integral_B 1 thin d (s_1, ..., s_m) & = integral_(B_1) 1 thin d (x_1, ..., x_(n_1)) integral_(B_2) 1 thin d (x_1, ..., x_(n_2))... integral_(B_k) 1 thin d (x_1, ..., x_(n_k))\
    & = product_(i = 1)^k frac((t_i - t_(i - 1))^(n_i), n_i !)
  $ und
  $ integral_(t_k)^oo e^(- lambda s_(m + 1)) thin d s_(m + 1) = e^(- lambda t_k) / lambda $
  Deswegen gilt
  $
    P(N (t_i) - N (t_(i - 1)) = n_i, i = 1, ..., k) & = lambda^(1 + sum_(i = 1)^k n_i) (product_(i = 1)^k frac((t_i - t_(i - 1))^(n_i), n_i !)) e^(- lambda t_k) / lambda\
    & = product_(i = 1)^k frac((t_i - t_(i - 1))^(n_i), n_i !) e^(t_i - t_(i - 1))
  $
]

#example[
  Sei ${ N (t) : t >= 0 }$ ein Poisson-Prozess mit Intensität
  $lambda > 0$. Berechne $P(N (1) = 1, N (3) = 5)$.
  $
    P(N (1) = 1, N (3) = 5) & = P(N (1) = 1, N (3) - N (1) = 4)\
    & = P(overbrace(N (1) = 1, tilde.op P O I (lambda))) P(overbrace(N (3) - N (1) = 4, tilde.op P O I (2 lambda)))\
    & = frac(e^(- lambda) lambda, 1 !) frac(e^(- 2 lambda) (2 lambda)^4, 4 !)\
    & = 2 / 3 e^(- 3 lambda) lambda^5
  $

]
#example[
  Ab 09:00 erfolgen Anrufe gemäß eines Poisson-Prozesses. Gegeben, dass bis 09:30 genau ein Anruf eingeht, wie groß ist
  die bedingte Wahrscheinlichkeit, dass er vor 09:20 eingeht, wenn $t$ in Stunden gemessen wird?
  $
    P(T_1 < 1 / 3 \| N (1 / 2) = 1) & = frac(P(T_1 < 1 / 3, N (1 / 2) = 1), P(N (1 / 2) = 1))\
    & = frac(P(T_1 < 1 / 3, N (1 / 2) - N (1 / 3) = 0), P(N (1 / 2) = 1))\
    & = frac(P(T_1 < 1 / 3) P(N (1 / 2) - N (1 / 3) = 0), P(N (1 / 2) = 1))\
    & = frac(
      frac(e^(- lambda 1 / 3), 1 !) (lambda / 3)^1 frac(e^(- lambda (1 / 2 - 1 / 3)), 0 !) (lambda (1 / 2 - 1 / 3))^0,
      frac(e^(- lambda 1 / 2), 1 !) (lambda / 2)^1,

    )\
    & = 2 / 3
  $ Das entspricht genau $2 / 3$ der Zeit!

]
