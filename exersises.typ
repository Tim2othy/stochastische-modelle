#import "settings.typ": *


// AB11

#let ex42 = exer[Aufgabe 42][
  Es seien $U$ und $V$ unabhängige Zufallsvariablen.
  Für die Mengen $A subset RR$ und $B subset RR^2$ gelte die folgende Implikation:
  $
    u in A med and med (u, v) in B arrow (w, v) in B med forall med w in A^c.
  $
  + Zeigen Sie:
    $
      P(U in A, med (U, V) in B) & <= P(U in A) med P((U, V) in B).
    $
  + Zeigen Sie durch ein Gegenbeispiel, dass die Unabhängigkeitsannahme nicht gestrichen werden kann.

  *Hinweis zu (a).*
  Benutzen Sie eine Zufallsvariable $W$, so dass $W$ dieselbe Verteilung hat wie $U$ und so dass $U, V, W$ unabhängig sind.
  Beachten Sie außerdem die Ungleichung:
  $
    1_A (u) med 1_B (u, v) med 1_(A^c) (w) <= 1_A (u) med 1_B (w, v) med 1_(A^c) (w).
  $
]
#let ex43 = exer[Aufgabe 43][
  Seien $(Y_n)_(n=1)^infinity$, $(T_n)_(n=0)^infinity$ und ${N(t): t >= 0}$ wie in Definition 3.1. (FIX TODO)
  Es sei $t^* > 0$ ein fester Zeitpunkt und es sei$X := Y_(N(t^*) + 1).$
  Interpretiert man die $Y_n$ als Lebensdauern von nacheinander verwendeten Bauteilen, dann ist $X$ die Lebensdauer des zur Zeit $t^*$ verwendeten Bauteils.

  Zeigen Sie:
  + Für alle $t >= 0$ gilt: $P(X <= t) <= P(Y_1 <= t).$
  + Für alle $k > 0$ gilt: $E(X^k) <= E(Y_1^k).$
]
