#import "settings.typ": *


//AB 7

#let ex28 = exer[Aufgabe 28.][
  Eine stochastische Matrix $( p_(i j) )_(i , j in S)$ heißt _doppelt-stochastisch_, falls $sum_(i in S) p_(i j) = 1$ für alle $j in S$.
  Zeigen Sie, dass für jede Markov-Kette mit endlichem Zustandsraum $S$ und doppelt-stochastischer Übergangsmatrix die Gleichverteilung auf $S$ eine stationäre Verteilung ist.
]
#let ex29 = exer[Aufgabe 29.][
  Diese Aufgabe behandelt das Mischen von Spielkarten.
  Gegeben sei ein Stapel von $n gt.eq 2$ Karten mit Nummern $1 , dots.h , n$.
  Es bezeichne $S_n$ die Menge der Permutationen der Menge ${ 1 , dots , n }$, also der Bijektionen $pi : { 1 , dots, n } arrow { 1 , dots , n }$.
  Der Zustand des Stapels ist die Reihenfolge der Karten und kann durch ein Element $pi$ aus $S_n$ beschrieben werden: Karte $i$ ist an Position $pi ( i )$, $i = 1 , dots.h , n$.
  Das Mischen erfolgt so, dass die Karte, die zur Zeit $t in bb(N)_0$ an Position $j$ ist, zur Zeit $t + 1$ an Position $Y_(t + 1) ( j )$ ist, $j = 1 , dots.h , n$.
  Dabei seien $Y_1 , Y_2 , dots.h$ unabhängige identisch verteilte zufällige Permutationen aus $S_n$.
  Dann ist die Folge der Zustände des Kartenstapels eine Markov-Kette.
  + Drücken Sie die Übergangswahrscheinlichkeiten der Markov-Kette durch die Verteilung der $Y_t$ aus.
  + Bestimmen Sie eine stationäre Verteilung der Markov-Kette.
]

#let ex30 = exer[Aufgabe 30.][
  Beweisen Sie diesen Satz.
  Betrachten Sie dazu die Mittel
  $
    q ( n ) := 1 / n ( p^((0)) + dots + p^((n - 1)) ),
  $
  wobei $p ( n )$ die Verteilung von $X_n$ beschreibt, also $p ( n ) = ( P ( X_n = 1 ) , dots.h , P ( X_n = s ) )$.
  Benutzen Sie hier den @thm:bolzano-weierstrass beziehungsweise die Folgerung.
]

#let ex31 = exer[Aufgabe 31.][
  Für welche Verteilungen $( a_i )_(i in bb(Z))$ hat die Irrfahrt auf $bb(Z)$ mit Übergangswahrscheinlichkeiten $p_(i j) = a_(j - i)$ eine stationäre Verteilung?

  Hinweis.
  Betrachten Sie für eine stationäre Verteilung $( pi_i )_(i in bb(Z))$ den kleinsten und den größten Zustand $j$ mit $pi_j = max_(i in bb(Z)) pi_i$.
]

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
