#import "settings.typ": *
#import "@preview/lovelace:0.3.0": *



//AB 1

#let ex02 = exer[Aufgabe 2][
  Eine Urne sei zum Zeitpunkt $t = 0$ leer.
  Zu jedem Zeitpunkt $t ∈ N$ werden zwei Kugeln in die Urne gelegt, eine mit der Nummer $2t - 1$ eine mit der Nummer $2t$.
  Jeweils unmittelbar danach wird eine der $t+1$ Kugeln in der Urne zufällig ausgewählt und entnommen. Es bezeichne $X$ die Anzahl der Kugeln, die für immer in der Urne verbleiben.
  Bestimmen Sie die Verteilung von $X$.

  Hinweis.
  Bestimmen Sie zunächst für jedes $n ∈ N$ die Wahrscheinlichkeit, dass die Kugel mit der Nummer $n$ nie entfernt wird.
]

//AB 2

#let ex07 = exer[Aufgabe 7][
  Es seien $N, X_1, X_2, dots$ unabhängige diskrete Zufallsvariablen mit
  $
    P(N ∈ NN_0) = 1, wide E(N) = ν, wide "Var"(N) = τ^2
  $
  und
  $
    E(X_i) = μ, wide "Var"(X_i) = σ^2 wide "für alle" i = 1, 2, dots
  $
  Es sei $S_0 := 0$ und $S_n := X_1 + dots + X_n$ für $n = 1, 2, dots$
  + Drücken Sie $"E"(S_N )$ durch $μ$ und $ν$ aus.
  + Drücken Sie $"Var"(S_N)$ durch $μ$, $ν$, $σ^2$ und $τ^2$ aus.
]

#let context-ex08 = plain_box[
  Der folgende Pseudocode beschreibt die Verwerfungsmethode (acceptance-rejection method) zur Erzeugung von Pseudozufallszahlen fur eine Verteilung mit einer gegebenen Dichte $f$, also von Realisierungen von Zufallsvariablen mit Dichte $f$.
  Dabei wird angenommen, dass Pseudozufallszahlen fur eine Verteilung mit einer Dichte $g$ erzeugt werdenkonnen und dass es eine Konstante $c$ gibt, so dass $f(x) >= c g(x)$ für alle $x in RR$.
  Auerdem wird angenommen, dass Pseudozufallszahlen fur eine Gleichverteilung auf dem Intervall $(0,1)$ erzeugt werden konnen.
  Die verwendeten Pseudozufallszahlen werden als Realisierungen unabhangiger Zufallsvariablen aufgefasst.

  #pseudocode-list[
    - *repeat* \
      - generate $x ~ g$ \
      - generate $u ~ "uniform distribution on" (0,1)$ \
    - *until* $c u g(x) < f(x)$ \
    - *return* $x$ \
  ]
  Die erzeugten Werte fur $x$ werden also verworfen, solange $c u g(x) >= f(x)$ gilt.
  Sobald das erste Mal $c u g(x) < f(x)$ gilt, wird der aktuelle Wert $x$ akzeptiert und ausgegeben.
  Die folgende Aufgabe begründet dieses Vorgehen.
]
#let ex08 = exer[Aufgabe 8][
  Es seien $f, g : RR ->RR$ Wahrscheinlichkeitsdichten und es sei $c in (0 oo)$ so dass $f(x) <= c g(x)$ für alle $x in R$.
  Es seien $X_1, U_1, X_2, U_2, dots$ unabhängige Zufalls variablen, wobei jedes $X_i$ stetig verteilt ist mit Dichte $g$ und jedes $U_i$ auf dem Intervall $(0,1)$ gleichverteilt ist.
  Sei
  $
    N := "inf" {n in N : c U_n g(X_n) < f(X_n)}.
  $
  Dabei ist $"inf" emptyset = oo$ und $"inf" A = "min" A$  für jede nichtleere Menge $A subset N$.
  + Bestimmen Sie die Verteilung von $N$.
  + Zeigen Sie, dass $X_N$ die Dichte $f$ hat.
]

//AB 3

#let ex10 = exer[Aufgabe 10][
  Geben Sie ein Beispiel für eine Markov-Kette ${X_n : n in N_0}$ mit Zustands raum ${0,1}$ an, so dass es eine Menge $G subset {0,1}$ gibt mit
  $
    P(X_1 in G, X_0 =1)>0
  $
  und
  $
    P(X_2 = 1| X_1 in G, X_0 = 1) != P(X_2 =1 | X_1 in G).
  $
]

//AB 6

#let ex26 = exer[Aufgabe 26.][
  Es seien $X_1, X_2, dots$ Zufallsvariablen mit Werten in $NN_0 ∪{∞}$.
  Zeigen Sie:
  + Für jedes $k ∈NN_0$ gilt:
    $
      P( sum_(n=1)^oo X_n > k) = lim_(n→oo) P(X_1 + dots + X_n > k).
    $
  + $E( sum_(n=1)^oo X_n) = sum_(n=1)^oo + E(X_n) =$
]


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

//Ab 09

#let ex36 = exer[Aufgabe 36][
  Ein Spieler kann bei einem zweiarmigen Banditen in jeder Runde Arm $A$ oder Arm $B$ wählen.
  Wählt er Arm $A$, gewinnt er 1 Euro mit Wahrscheinlichkeit $alpha in (0,1)$ und verliert 1 Euro mit Wahrscheinlichkeit $1-alpha$.
  Wählt er Arm $B$, gewinnt er 1 Euro mit Wahrscheinlichkeit $beta in (0,1)$ und verliert 1 Euro mit Wahrscheinlichkeit $1-beta$.
  Dabei sind $alpha$ und $beta$ unbekannt.
  Wurde der Spieler Arm $A$ bzw. $B$ jeweils mit Wahrscheinlichkeit $1/2$ wahlen, ergabe sich also in jeder Runde die Gewinnwahrscheinlichkeit $1/2( alpha +beta )$.
  Er wählt aber nur in der ersten Runde den Arm zufallig aus.
  Danach geht er wie folgt vor.
  Gewinnt er in Runde $n$, wahlt er in Runde $n+1$ denselben Arm wie in Runde $n$.
  Andernfalls wahlt er den anderen Arm.
  + Berechnen Sie den Grenzwert für $n -> oo$ der Wahrscheinlichkeit, dass der Spieler in Runde $n$ gewinnt.
  + Unter welcher Bedingung an $alpha$ und $beta$ ist dieser Grenzwert größer als $1/2(alpha + beta)$?
]


#let ex37 = exer[Aufgabe 37][
  Im Lauf der Zeit bilden sich $n$ Personen ihre Meinungen, jeweils ausgedrückt durch eine Zahl im Intervall $[0,1]$.
  Beispielsweise kann diese Zahl den Grad der Zustimmung zu einer Aussage ausdrücken.
  Zum Zeitpunkt $t = 0$ hat Person $i$ die Meinung $x_i(0), i = 1, dots, n$.
  Zu den Zeitpunkten $t = 1,2,dots$ aktualisiert jede Person ihre Meinung, indem sie zu einem gewichteten Mittel der bisherigen Meinungen übergeht:
  $
    x_i(t) = sum_(j=1)^n a_(i j) x_j (t_1), wide i = 1, dots, n.
  $
  Person $i$ misst also der Meinung von Person $j$ das Gewicht $a_(i,j)$ bei.
  Die Gewichte sind zeitlich konstant und nichtnegativ und es gilt $sum_(j=1)^n a_(i j)= 1$ für alle $i = 1, dots, n$.
  + Formulieren Sie geeignete Bedingungen an die Gewichte, die sicherstellen, dass ein Konsens erreicht wird in dem Sinn, dass die Grenzwerte $lim_(t ->oo) x_i(t)$ für $i = 1, dots, n$ existieren und ubereinstimmen.
  + Zeigen Sie, dass die Grenzwerte gleich dem arithmetischen Mittel von $x_1 (0), dots, x_n (0)$ sind, falls (zusatzlich zu den Bedingungen aus (a)) $a_(i j) = a_(j i)$ gilt für alle $i = j$.
]

// AB 10

#let ex39 = exer[Aufgabe 39(Googles PageRank)][
  Gegeben seien Webseiten $1,dots, m$.
  Für jede Seite sei bekannt, auf welche Seiten sie durch Links verweist.
  Ein "random surfer" beginnt mit einer zufällig gewählten Seite $X_0$.
  Ist er zum Zeitpunkt $n$ auf Seite $X_n$, wählt er die nächste Seite $X_(n+1)$,   unabhängig von den zuvor besuchten Seiten, wie folgt aus.
  Enthält die aktuelle Seite keine Links, wählt er von allen $m$ Seiten eine zufällig aus.
  Andernfalls folgt er mit Wahrscheinlichkeit $(0,1)$ einem zufällig gewählten Link auf der aktuellen Seite und mit Wahrscheinlichkeit 1 wählt er von allen $m$ Seiten eine zufällig aus.
  Eine zufällige Auswahl bedeutet hier, dass jede der betrachteten möglichkeiten mit derselben Wahrscheinlichkeit gewählt wird.
  Der Rang von Seite $j$ sei $r_j := lim_(n-> oo) P(X_n = j)$.
  Geben Sie ein lineares Gleichungssystem fur die Seitenrange an.
  Zeigen Sie, dass das Gleichungssystem eine eindeutige Losung hat.
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
  Seien $(Y_n)_(n=1)^infinity$, $(T_n)_(n=0)^infinity$ und ${N(t): t >= 0}$ wie in @def:erneuerungsprozes
  Es sei $t^* > 0$ ein fester Zeitpunkt und es sei$X := Y_(N(t^*) + 1).$
  Interpretiert man die $Y_n$ als Lebensdauern von nacheinander verwendeten Bauteilen, dann ist $X$ die Lebensdauer des zur Zeit $t^*$ verwendeten Bauteils.

  Zeigen Sie:
  + Für alle $t >= 0$ gilt: $P(X <= t) <= P(Y_1 <= t).$
  + Für alle $k > 0$ gilt: $E(X^k) <= E(Y_1^k).$
]

// AB 12

#let ex47 = exer[Aufgabe 47][
  Es sei ${N(t) : t_0}$ ein Erneuerungsprozess mit auf dem Intervall $[0,10]$ gleichverteilten Zwischenankunftszeiten.
  Bestimmen Sie näherungsweise eine Lösung der Gleichung $P(N(1440) > alpha) = 0.05$.
]
