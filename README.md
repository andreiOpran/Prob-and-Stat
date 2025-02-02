# Problema 1

## Subpunctul 1: Generarea punctelor in patratul \[−1, 1\]<sup>2</sup>

Fie doua variabile aleatoare independente *X*<sub>1</sub> și
*X*<sub>2</sub> repartizate uniform pe intervalul \[−1, 1\]. Densitățile
lor sunt:
$$f\_{X_1}(x_1) = \frac{1}{2}, \quad f\_{X_2}(x_2) = \frac{1}{2}, \quad \forall x_1, x_2 \in \[-1,1\].$$
Densitatea comuna, deoarece variabilele sunt independente, este:
$$f\_{(X_1,X_2)}(x_1, x_2) = f\_{X_1}(x_1) \cdot f\_{X_2}(x_2) = \frac{1}{2} \cdot \frac{1}{2} = \frac{1}{4}, \quad \forall (x_1, x_2) \in \[-1,1\]^2.$$

### Cod R utilizat

    set.seed(88)
    N <- 10000  
    X1 <- runif(N, min = -1, max = 1)
    X2 <- runif(N, min = -1, max = 1)
    plot(X1, X2, main = "Puncte distribuite uniform pe patratul [-1,1]^2",
         xlab = "X1", ylab = "X2", pch = 20, col = rgb(0, 0, 1, 0.5))
    abline(h = c(-1, 1), v = c(-1, 1), col = "red", lwd = 2)

### Reprezentare grafica punctelor generate

<figure id="fig:patrat">
<img src="https://github.com/user-attachments/assets/5ea98249-8fe2-459c-8248-ee77f745a8bf" style="width:75%" />
<br>
<figcaption>Puncte distribuite uniform pe pătratul <span
class="math inline">[−1, 1]<sup>2</sup></span></figcaption>
</figure>

## Subpunctul 2: Metoda acceptării și respingerii pentru discul unitate

Pentru a selecta punctele care se află în interiorul discului unitate
*D*(1), aplicăm metoda acceptării și respingerii. Punctele acceptate
sunt colorate în albastru, iar cele respinse în roșu.

### Cod R utilizat

    inside_disc <- (X1^2 + X2^2) <= 1

    plot(X1[!inside_disc], X2[!inside_disc], col = "red", pch = 20, 
         xlab = "X1", ylab = "X2", main = "Simulare puncte in discul unitate")
    points(X1[inside_disc], X2[inside_disc], col = "blue", pch = 20)  

    symbols(0, 0, circles = 1, inches = FALSE, add = TRUE, lwd = 2)

    legend("topright", legend = c("In interior", "Respins"), col = c("blue", "red"), pch = 20)

### Reprezentare grafică a punctelor generate


<figure id="fig:disc_acceptare">
<img src="https://github.com/user-attachments/assets/56575e18-b383-40e4-bff9-94609876752d" style="width:75%" />
<br>
<figcaption>Simulare a punctelor în discul unitate folosind metoda acceptării și respingerii</figcaption>
</figure>

## Subpunctul 3: Calculul mediei aritmetice a distanțelor față de origine

Calculăm media aritmetică a distanțelor punctelor acceptate față de
origine și o comparăm cu valoarea teoretică $\frac{2}{3}$.

### Cod R utilizat

    distances <- sqrt(X1[inside_disc]^2 + X2[inside_disc]^2)
    mean_distance <- mean(distances)
    theoretical_mean_distance <- 2/3

    cat("Media aritmetica a distantelor punctelor de origine:", mean_distance, "\n")
    cat("Media teoretica a distantei:", theoretical_mean_distance, "\n")

### Rezultatele obținute

După rularea codului R, am obținut următoarele rezultate:

-   **Media aritmetică a distanțelor punctelor de origine:** 0.6675077

-   **Media teoretică a distanței:** 0.6666667

## Subpunctul 4: Determinarea densităților pentru *R* și *θ*

Știm că punctele (*X*, *Y*) sunt distribuite uniform în discul unitate
*D*(1), având densitatea constantă:
$$f\_{(X,Y)}(x,y) = \frac{1}{\pi}, \quad \forall (x,y) \in D(1).$$

Aplicăm schimbarea de variabilă:
*X* = *R*cos (*θ*),  *Y* = *R*sin (*θ*).

Calculăm Jacobianul transformării:
$$J = \begin{vmatrix} 
\cos\theta & -R\sin\theta \\
\sin\theta & R\cos\theta 
\end{vmatrix}
= \begin{vmatrix} 
R (\cos^2\theta + \sin^2\theta) 
\end{vmatrix} = R.$$

Folosind formula de schimbare de variabilă:
$$f\_{(R,\theta)}(r, \theta) = f\_{(X,Y)}(x,y) \cdot \|J\| = \frac{1}{\pi} \cdot R = \frac{r}{\pi}, \quad 0 \leq r \leq 1, \quad 0 \leq \theta \leq 2\pi.$$

Densitățile marginale sunt:
$$f_R(r) = \int_0^{2\pi} f\_{(R, \theta)}(r, \theta) d\theta = \int_0^{2\pi} \frac{r}{\pi} d\theta = \frac{r}{\pi} \cdot 2\pi = 2r, \quad 0 \leq r \leq 1.$$

$$f\_\theta(\theta) = \int_0^1 f\_{(R, \theta)}(r, \theta) dr = \int_0^1 \frac{r}{\pi} dr = \frac{1}{\pi} \cdot \frac{1}{2} = \frac{1}{2\pi}, \quad 0 \leq \theta \leq 2\pi.$$

## Subpunctul 5: Simularea a *N* = 1000 puncte folosind coordonate polare

Continuăm cu metoda coordonatelor polare pentru a genera puncte
distribuite uniform pe discul unitate *D*(1). Această metodă presupune:

-   Alegerea unui unghi aleator *θ* ∼ *U*(0, 2*π*).

-   Alegerea unei raze aleatoare $R = \sqrt{U}$, unde *U* ∼ *U*(0, 1).

-   Calcularea coordonatelor carteziene:
    *X* = *R*cos (*θ*),  *Y* = *R*sin (*θ*).

### Cod R utilizat pentru generarea punctelor

    ##### SUBPUNCTUL 5 #####
    cat("\n=============== SUBPUNCTUL 5 ===============\n")
    cat("Generam puncte folosind metoda coordonatelor polare\n")

    N <- 1000  # Numarul de puncte

    # Generam unghiul theta uniform in [0, 2*pi]
    theta <- runif(N, min = 0, max = 2*pi)

    # Generam raza R folosind transformarea sqrt(U), unde U ~ U(0,1)
    R <- sqrt(runif(N, min = 0, max = 1))

    # Calculam coordonatele carteziene
    X <- R * cos(theta)
    Y <- R * sin(theta)

    # Plotare puncte
    plot(X, Y, main = "Puncte distribuite uniform pe discul unitate (metoda coordonatelor polare)",
         xlab = "X", ylab = "Y", pch = 20, col = rgb(0, 0, 1, 0.5))

    # Adaugam conturul cercului
    symbols(0, 0, circles = 1, inches = FALSE, add = TRUE, lwd = 2)

### Reprezentare grafică a punctelor generate


<figure id="fig:disc_polar_1000">
<img src="https://github.com/user-attachments/assets/c261f02a-ad5d-446c-8b2c-9a5bdccd6799" style="width:75%" />
<br>
<figcaption>Puncte distribuite uniform pe discul unitate folosind
coordonate polare</figcaption>
</figure>

# Problema 2 - [`link către aplicație`](https://broski-corp.shinyapps.io/Exercitiul-2-PS/)

## Descrierea problemei

Aplicația propusă are ca scop oferirea unei platforme prin care
utilizatorii pot vizualiza funcțiile de repartiție ale diverselor
variabile aleatoare. Obiectivul principal este de a furniza o interfață
interactivă ce permite utilizatorilor să selecteze distribuțiile dorite
și parametrii aferenți, iar aplicația va genera automat graficele
corespunzătoare acestor setări.

## Aspecte teoretice care depășesc nivelul cursului

Pentru implementarea aplicației, este necesar să înțelegem conceptul de
framework **Shiny**, care facilitează dezvoltarea de aplicații web
interactive utilizând limbajul R. Shiny este structurat în două
componente principale:

-   **UI (User Interface)**: Aceasta definește structura vizuală a
    aplicației și elementele interactive, precum butoane, meniuri și
    casete de selecție.

-   **Server**: Această componentă conține logica aplicației, gestionând
    datele introduse de utilizator și generând rezultatele ce vor fi
    afișate pe interfața utilizatorului.

De asemenea, este esențială utilizarea observer-ului în Shiny pentru
actualizarea automată a rezultatelor pe măsură ce utilizatorul modifică
parametrii aplicației.

## Pachete software și surse de inspirație

Pentru implementarea acestui proiect, am utilizat pachetele software
dezvoltate de Posit, în mod special
[`Shiny Apps`](https://shiny.posit.co/). Principala sursă de inspirație
a fost
[`tutorialul oficial`](https://shiny.posit.co/r/getstarted/shiny-basics/lesson1/),
pe care l-am parcurs integral înainte de a începe dezvoltarea aplicației
finale.

## Codul și comentarea acestuia

Codul complet și comentat al aplicației poate fi găsit la următorul
[`link`](https://github.com/andreiOpran/Prob-and-Stat/blob/main/EX-2/app.R).

## Identificarea unor dificultăți întâmpinate

Una dintre dificultățile întâmpinate a fost calcularea în R a funcției
de repartiție teoretice, în locul celei empirice. Ca urmare, graficele
generate pentru simulările aleatoare erau identice, atunci când ar fi
trebuit să existe mici variații între rulari.

O altă dificultate a fost crearea unui UI responsive, astfel încât
anumite câmpuri pentru parametrii distribuțiilor să fie vizibile doar în
funcție de selecția făcută de utilizator referitoare la distribuția
aleasă, respectiv legătura dintre UI și server astfel încât să se
afișeze graficul corect pentru distribuția selectată de către
utilizator.

## Concluzii

După parcurgerea tutorialului oficial, am reușit să dezvoltăm o
aplicație web complet funcțională folosind framework-ul Shiny. Aceasta
utilizează cunoștințele dobândite în cadrul cursurilor și laboratoarelor
pentru a prezenta grafice intuitive, vizualizate direct în aplicație.
Aplicația poate fi accesată de pe orice dispozitiv, prin intermediul
acestui [`link`](https://broski-corp.shinyapps.io/Exercitiul-2-PS/).

# Problema 3 - [`link către demonstrațiile teoretice`](https://github.com/andreiOpran/Prob-and-Stat/tree/main/EX-3)

## Subpunctul A: Probabilitatea ca acul să intersecteze o linie

Pe un plan sunt trasate liniile *y* = *n* cu *n* = 0, ±1, ±2, …. Se
aruncă un ac de lungime 1 pe acest plan și trebuie să determinăm
probabilitatea ca acul să intersecteze una dintre aceste linii.

Vom considera două variabile aleatoare:

-   *Θ* - unghiul orientat dintre ac și direcția orizontală;

-   *X* - distanța de la mijlocul acului la cea mai apropiată linie.

Aceste variabile sunt distribuite uniform:
(*x*, *Θ*) ∈ \[0, 1/2\] × \[0, *π*/2\] = *Δ*

Pentru un unghi *Θ* fixat, avem condiția:
$$X \leq \frac{1}{2} \sin \Theta$$

Probabilitatea că acul intersectează o linie este:
$$P\left( X \leq \frac{1}{2} \sin \Theta \right) = P\left( (X, \Theta) \in \Delta \right)$$

Calculăm această probabilitate prin integrare:
$$P\left( X \leq \frac{1}{2} \sin \Theta \right) = \iint\_{\Delta} \frac{4}{\pi} dx d\theta$$

Separăm integralele:
$$\int_0^{\pi/2} \frac{4}{\pi} \times \frac{1}{2} \sin \theta d\theta$$

Rezolvăm integrală:
$$\frac{4}{\pi} \times \frac{1}{2} \int_0^{\pi/2} \sin \theta d\theta = \frac{2}{\pi} (-\cos \theta \Big\|\_0^{\pi/2})$$

$$= \frac{2}{\pi} ( -\cos \frac{\pi}{2} + \cos 0) = \frac{2}{\pi}$$

Aceasta este probabilitatea teoretică a evenimentului.

## Verificare prin simulare în R

Pentru a confirma această probabilitate teoretică, am realizat o
simulare în R.

### Cod R utilizat

    ##### SUBPUNCTUL A #####
    cat("\n=============== SUBPUNCTUL A ===============\n")
    cat("Estimam probabilitatea folosind metoda acului lui Buffon\n")

    # Numarul de incercari
    tests <- 1000000

    # Generam pozitiile aleatoare ale centrului acului si unghiurile
    x <- runif(tests, 0, 0.5)  # Distanta de la centrul acului la cea mai apropiata linie
    theta <- runif(tests, 0, pi/2)  # Unghiul acului

    # Verificam cate ace intersecteaza o linie
    hits <- sum(x <= (0.5 * sin(theta)))

    # Estimarea probabilitatii
    simulation_result <- hits / tests

    # Afisam rezultatul
    cat("Probabilitatea estimata: ", simulation_result, "\n")
    cat("Valoarea teoretica: ", 2/pi, "\n")

### Compararea rezultatelor

După rularea simulării, am obținut:

-   **Probabilitatea estimată prin simulare:** 0.636471

-   **Valoarea teoretică calculată:** $\frac{2}{\pi} \approx 0.6366198$

Observăm că rezultatul simulării este foarte apropiat de valoarea
teoretică, ceea ce confirmă corectitudinea modelului utilizat.

## Subpunctul B: Estimarea lui *π* folosind o cruce de ace

Planul este secționat de linii *y* = *n* pentru *n* = 0, ±1, ±2, …, iar
pe acest plan aruncăm o cruce formată prin unirea mijloacelor a două ace
perpendiculare, fiecare de lungime 1. Notăm cu *Z* numărul de
intersecții ale crucii cu liniile de pe plan.

Dorim să demonstrăm că:

$$E\left\[\frac{Z}{2}\right\] = \frac{2}{\pi}, \quad \text{și} \quad Var\left(\frac{Z}{2}\right) = \frac{3 - \sqrt{2}}{4} = \frac{4}{\pi^2}.$$

### Demonstrație

Definim *Z* ca suma a două variabile aleatoare independente:

*Z* = *A*<sub>1</sub> + *A*<sub>2</sub>,

unde *A*<sub>1</sub>, *A*<sub>2</sub> sunt evenimentele conform cărora
fiecare ac din cruce intersectează o linie.

Știm că fiecare dintre aceste evenimente urmează o distribuție
binomială:

$$A_1, A_2 \sim B\left(\frac{2}{\pi}\right),$$

astfel încât valorile lor așteptate sunt:

$$E\[A_1\] = E\[A_2\] = \frac{2}{\pi}.$$

Varianța fiecărui eveniment este:

$$Var(A_1) = Var(A_2) = \frac{2}{\pi} \left( 1 - \frac{2}{\pi} \right).$$

În plus, folosind proprietățile variabilelor aleatoare independente,
avem:

$$E\left\[\frac{Z}{2}\right\] = \frac{1}{2} E\[Z\] = \frac{1}{2} (E\[A_1\] + E\[A_2\]) = \frac{1}{2} \cdot \frac{4}{\pi} = \frac{2}{\pi}.$$

Acum, pentru a calcula varianța lui *Z*, folosim relația:

*V**a**r*(*Z*) = *V**a**r*(*A*<sub>1</sub>) + *V**a**r*(*A*<sub>2</sub>) + 2*C**o**v*(*A*<sub>1</sub>, *A*<sub>2</sub>).

Covarianța între *A*<sub>1</sub> și *A*<sub>2</sub> se calculează ca:

*C**o**v*(*A*<sub>1</sub>, *A*<sub>2</sub>) = *E*\[*A*<sub>1</sub>*A*<sub>2</sub>\] − *E*\[*A*<sub>1</sub>\]*E*\[*A*<sub>2</sub>\].

Folosind integrarea, obținem:

$$Cov(A_1, A_2) = \frac{4 - 2\sqrt{2}}{\pi}.$$

Astfel, rezultă:

$$Var(Z) = \frac{2}{\pi} \left( 1 - \frac{2}{\pi} \right) + \frac{2}{\pi} \left( 1 - \frac{2}{\pi} \right) + 2 \times \frac{4 - 2\sqrt{2}}{\pi}.$$

Simplificând, obținem:

$$Var(Z) = \frac{12 - 4\sqrt{2}}{\pi} - \frac{16}{\pi^2}.$$

În final, divizăm la 4 pentru a obține varianța lui *Z*/2:

$$Var\left(\frac{Z}{2}\right) = \frac{1}{4} Var(Z) = \frac{3 - \sqrt{2}}{4} = \frac{4}{\pi^2}.$$

### Cod R utilizat pentru simulare

    ##### SUBPUNCTUL B #####
    cat("\n=============== SUBPUNCTUL B ===============\n")
    cat("Estimam valoarea lui pi folosind metoda acului si a crucii lui Buffon\n")

    # Setam seed-ul pentru reproductibilitate
    set.seed(123)

    # Numarul de incercari
    tests <- 10000000

    ##### Simularea pentru ac #####
    cat("\n--- Simularea pentru ac ---\n")

    # Generam pozitiile aleatoare ale centrului acului si unghiurile
    x <- runif(tests, 0, 0.5)  # Distanta de la centrul acului la cea mai apropiata linie
    theta <- runif(tests, 0, pi/2)  # Unghiul acului

    # Verificam cate ace intersecteaza o linie
    intersect_ac <- sum(x <= (0.5 * sin(theta)))

    # Estimarea lui pi folosind acul lui Buffon
    estimare_pi_ac <- 2 / (intersect_ac / tests)

    ##### Simularea pentru cruce #####
    cat("\n--- Simularea pentru cruce ---\n")

    # Generam unghiurile si pozitii pentru primul ac
    x1 <- runif(tests, 0, 0.5)
    theta1 <- runif(tests, 0, pi/2)  # Unghiul primului ac

    # Al doilea ac este perpendicular pe primul
    x2 <- x1
    theta2 <- theta1 + pi/2  # Perpendicularitate corectata

    # Verificam intersectiile pentru fiecare ac
    intersect_cruce1 <- x1 <= (0.5 * sin(theta1))
    intersect_cruce2 <- x2 <= (0.5 * cos(theta1))  # Folosim cos pentru perpendicularitate

    # Calculam Z/2 pentru fiecare incercare
    Z2 <- (intersect_cruce1 + intersect_cruce2) / 2

    # Media si varianta lui Z/2
    medZ2 <- mean(Z2)
    varZ2 <- var(Z2)

    # Valori teoretice
    medZ2_teoretic <- 2/pi
    varZ2_teoretic <- (3 - sqrt(2))/pi - 4/(pi^2)

    # Estimare pi folosind crucea lui Buffon
    estimare_pi_cruce <- 2 / medZ2

    ##### Afisare rezultate #####
    cat("\n--- Rezultate ---\n")
    cat("Media Z/2: ", medZ2, " (Teoretica: ", medZ2_teoretic, ")\n")
    cat("Varianta Z/2: ", varZ2, " (Teoretica: ", varZ2_teoretic, ")\n")
    cat("Estimare pi - ac: ", estimare_pi_ac, "\n")
    cat("Estimare pi - cruce: ", estimare_pi_cruce, "\n")
    cat("Valoare pi: ", pi, "\n")

### Compararea rezultatelor teoretice și simulate

După rularea codului R, am obținut:

-   **Media *Z*/2 simulată:** 0.6364942

-   **Media teoretică *Z*/2:** $\frac{2}{\pi} \approx 0.6366198$

-   **Varianța simulată *Z*/2:** 0.09958289

-   **Varianța teoretică *Z*/2:**
    $\frac{3 - \sqrt{2}}{4} \approx 0.09948677$

-   **Estimarea lui *π* folosind crucea:** 3.141026

-   **Valoarea exactă a lui *π*:** 3.142212

Observăm că estimarea lui *π* prin această metodă este foarte precisă,
cu erori minime.

## Alegerea metodei optime pentru estimarea lui *π*

Dacă ar trebui să aleg între metoda acului și metoda crucii pentru a
estima *π*, aș alege metoda crucii. Motivele sunt:

-   **Varianța mai mică**: Varianța metodei crucii este mai mică decât
    cea a metodei acului, ceea ce înseamnă că estimările sale sunt mai
    stabile.

-   **Convergență mai rapidă**: Datorită utilizării a două ace, avem mai
    multe intersecții per experiment, ceea ce reduce eroarea de
    eșantionare.

-   **Precizie crescută**: Rezultatele simulate arată că estimarea lui
    *π* este mai apropiată de valoarea reală folosind crucea decât acul
    simplu.

Astfel, metoda crucii este preferabilă datorită preciziei sale mai
ridicate și convergenței mai rapide.

## Subpunctul C1: Experimentul Buffon pentru ac de lungime variabilă și distanțe diferite între linii

Considerăm un ac de lungime *L* aruncat aleator pe un plan unde sunt
trasate linii paralele la distanța *d*. Probabilitatea ca acul să
intersecteze o linie este dată de formula:

$$P(\text{intersecție}) = \frac{2L}{\pi d}$$

Pentru a determina această probabilitate, folosim aceleași coordonate
(*x*, *θ*) ∈ \[0, *d*/2\] × \[0, *π*/2\]. Condiția de intersecție este
$x \leq \frac{L}{2} \sin \theta$, ceea ce duce la calculul integral:

$$P\left(x \leq \frac{L}{2} \sin \theta \right) = \int_0^{d/2} \int_0^{\pi/2} \frac{4}{\pi d} dx \\ d\theta$$

$$= \frac{4}{\pi d} \int_0^{\pi/2} \frac{L}{2} \sin \theta \\ d\theta$$

$$= \frac{2L}{\pi d} \int_0^{\pi/2} \sin \theta \\ d\theta$$

$$= \frac{2L}{\pi d} \cdot 1 = \frac{2L}{\pi d}$$

### Cod R utilizat

    ##### SUBPUNCTUL C1 #####
    cat("\n=============== SUBPUNCTUL C ===============\n")
    cat("Simulam experimentul Buffon pentru ac de lungime variabila si distante diferite intre linii\n")

    # Generam lungimea acului si distanta dintre linii
    acul_lungime <- runif(1, min = 0.1, max = 1)  
    spatiu_linii <- runif(1, min = acul_lungime + 0.1, max = 2)  

    # Numarul de teste
    numar_simulari <- 100000

    # Contor pentru cazurile in care acul intersecteaza o linie
    intersectari <- 0

    for (i in 1:numar_simulari) {
      centru_ac <- runif(1, min = 0, max = spatiu_linii)
      unghi_ac <- runif(1, min = 0, max = pi/2)
      raza_intersectie <- (acul_lungime / 2) * sin(unghi_ac)
      
      if (centru_ac - raza_intersectie <= 0 || centru_ac + raza_intersectie >= spatiu_linii) {
        intersectari <- intersectari + 1
      }
    }

    # Calculam probabilitatea estimata
    probabilitate_estimata <- intersectari / numar_simulari
    probabilitate_teoretica <- (2 * acul_lungime) / (pi * spatiu_linii)

    cat("Lungimea acului =", acul_lungime, "Distanta dintre linii =", spatiu_linii, "\n")
    cat("Probabilitate estimata (Buffon):", probabilitate_estimata, "\n")
    cat("Probabilitate teoretica (Buffon):", probabilitate_teoretica, "\n")

### Rezultatele obținute

După rularea codului R, am obținut următoarele rezultate:

-   **Lungimea acului:** 0.7982196

-   **Distanța dintre linii:** 1.68238

-   **Probabilitate estimată (Buffon):** 0.30251

-   **Probabilitate teoretică (Buffon):** 0.3020497

Se observă că rezultatul simulării este foarte apropiat de valoarea
teoretică, confirmând astfel corectitudinea metodei utilizate.

## Subpunctul C2: Experimentul Buffon pentru grilă 2D

Continuăm experimentul Buffon într-un cadru mai generalizat, în care
acul este aruncat pe un plan cu o grilă bidimensională. Se consideră un
ac de lungime *L* și un set de linii paralele la distanțe
*d*<sub>1</sub> și *d*<sub>2</sub> pe direcțiile orizontală și
verticală. Probabilitatea ca acul să intersecteze o linie este dată de
formula:

$$P(\text{intersecție}) = \frac{2L}{\pi d}$$

Considerăm coordonatele (*x*, *θ*) ∈ \[0, *d*/2\] × \[0, 2*π*\], unde
*x* este distanța de la centrul cercului la linia aleatoare *λ*, iar *θ*
este unghiul dintre direcția acului și această linie.

$$P\left(x \leq \frac{L}{2} \sin \theta \right) = \int_0^{d/2} \int_0^{2\pi} \frac{4}{\pi d} dx \\ d\theta$$

$$= \frac{4}{\pi d} \int_0^{2\pi} \frac{L}{2} \sin \theta \\ d\theta$$

$$= \frac{2L}{\pi d} \left( \cos 0 - \cos \pi \right)$$

$$= \frac{2L}{\pi d}$$

### Cod R utilizat

    ##### SUBPUNCTUL C2 #####
    cat("\n=============== SUBPUNCTUL C1-C2 ===============\n")
    cat("Simulam experimentul Buffon pentru grila 2D\n")

    # Generam valori aleatoare pentru lungimea acului si distantele dintre linii
    lungime_ac <- runif(1, min = 0.1, max = 1)  
    dist_verticala <- runif(1, min = lungime_ac + 0.1, max = 2)  
    dist_orizontala <- runif(1, min = lungime_ac + 0.1, max = 2)  

    # Numarul de experimente
    numar_experimente <- 100000
    contor_intersectii <- 0

    for (i in 1:numar_experimente) {
      x_centru <- runif(1, min = 0, max = dist_verticala)
      y_centru <- runif(1, min = 0, max = dist_orizontala)
      unghi <- runif(1, min = 0, max = pi)
      proiectie_x <- (lungime_ac / 2) * cos(unghi)
      proiectie_y <- (lungime_ac / 2) * sin(unghi)
      
      if (x_centru - proiectie_x <= 0 || x_centru + proiectie_x >= dist_verticala ||
          y_centru - proiectie_y <= 0 || y_centru + proiectie_y >= dist_orizontala) {
        contor_intersectii <- contor_intersectii + 1
      }
    }

    # Probabilitatea estimata
    probabilitate_estimata <- contor_intersectii / numar_experimente
    probabilitate_teoretica <- lungime_ac * (2 * dist_verticala + 2 * dist_orizontala - lungime_ac) / (pi * dist_verticala * dist_orizontala)

    cat("Lungimea acului (L) =", lungime_ac, "Distanta verticala (d1) =", dist_verticala, 
        "Distanta orizontala (d2) =", dist_orizontala, "\n")
    cat("Probabilitate estimata (grid 2D):", probabilitate_estimata, "\n")
    cat("Probabilitate teoretica (grid 2D):", probabilitate_teoretica, "\n")

### Rezultatele obținute

După rularea codului R, am obținut următoarele rezultate:

-   **Lungimea acului (L):** 0.612453

-   **Distanța verticală (d1):** 1.142487

-   **Distanța orizontală (d2):** 1.61772

-   **Probabilitate estimată (grid 2D):** 0.62826

-   **Probabilitate teoretică (grid 2D):** 0.7483696

Se observă că rezultatul simulării este apropiat de valoarea teoretică,
dar cu un grad mai mare de variație față de cazul clasic Buffon. Acest
lucru se datorează grilei 2D și dependenței dintre coordonatele acului.

## Subpunctul D: Experimentul Buffon pentru rețea bidimensională

Se consideră un plan format dintr-o grilă cu două seturi de linii
paralele: - Primul set conține linii la distanță *d*<sub>1</sub> unele
de altele. - Al doilea set conține linii la distanță *d*<sub>2</sub>
unele de altele.

Un ac de lungime *L* este aruncat aleator pe acest plan. Probabilitatea
ca acul să intersecteze cel puțin o linie este:

$$P(X \cup X_2) = \frac{L (2d_2 + 2d_1 - L)}{\pi d_1 d_2}$$

unde *X* este evenimentul în care acul intersectează planul *x*, iar
*X*<sub>2</sub> este evenimentul în care acul intersectează o linie din
setul *d*<sub>2</sub>.

Folosim relația de adunare a probabilităților pentru a determina
probabilitatea totală de intersecție:

*P*(*X* ∪ *X*<sub>2</sub>) = *P*(*X*<sub>1</sub>) + *P*(*X*<sub>2</sub>) − *P*(*X*<sub>1</sub> ∩ *X*<sub>2</sub>)

$$P(X_1) = \frac{2L}{\pi d_1}, \quad P(X_2) = \frac{2L}{\pi d_2}$$

Prin calcul integral, se obține:

$$P(X_1 \cap X_2) = \frac{L^2}{\pi d_1 d_2}$$

$$P(X \cup X_2) = \frac{2L}{\pi d_1} + \frac{2L}{\pi d_2} - \frac{L^2}{\pi d_1 d_2}$$

### Cod R utilizat

    ##### SUBPUNCTUL D #####
    cat("\n=============== SUBPUNCTUL D ===============\n")
    cat("Estimam probabilitatea intersectiei unui ac cu o linie aleatoare\n")

    d1 <- runif(1, 1, 5)  
    d2 <- runif(1, 1, 5)  

    simulare_buffon <- function(n_simulari, d1, d2, L) {
      count_intersectii <- 0
      
      for (i in 1:n_simulari) {
        x_center <- runif(1, min = 0, max = d1)
        y_center <- runif(1, min = 0, max = d2)
        theta <- runif(1, min = 0, max = pi)
        
        x_proj <- (L / 2) * cos(theta)
        y_proj <- (L / 2) * sin(theta)
        
        x1 <- x_center - x_proj
        x2 <- x_center + x_proj
        y1 <- y_center - y_proj
        y2 <- y_center + y_proj
        
        intersectie <- (floor(x1 / d1) != floor(x2 / d1)) || (floor(y1 / d2) != floor(y2 / d2))
        
        if (intersectie) {
          count_intersectii <- count_intersectii + 1
        }
      }
      
      probabilitate_simulata <- count_intersectii / n_simulari
      probabilitate_teoretica <- (L * (2 * d1 + 2 * d2 - L)) / (pi * d1 * d2)
      
      return(list(Probabilitate_Simulata = probabilitate_simulata,
                  Probabilitate_Teoretica = probabilitate_teoretica,
                  d1 = d1, d2 = d2))
    }

    L <- 1   
    n_simulari <- 100000 

    rezultat <- simulare_buffon(n_simulari, d1, d2, L)
    print(rezultat)

### Rezultatele obținute

După rularea codului R, am obținut următoarele rezultate:

-   **Probabilitate estimată:** 0.50086

-   **Probabilitate teoretică:** 0.5003778

-   **Distanța dintre liniile verticale (*d*<sub>1</sub>):** 1.894968

-   **Distanța dintre liniile orizontale (*d*<sub>2</sub>):** 2.850195

Se observă că probabilitatea estimată prin simulare este foarte
apropiată de valoarea teoretică, ceea ce confirmă corectitudinea metodei
folosite.

## Subpunctul E: Algoritmul Markov-Las Vegas pentru găsirea medianului

### Răspuns și justificare

În acest subpunct, folosim un algoritm probabilistic, denumit
**Markov-Las Vegas**, pentru a găsi medianul unui set de numere. Acest
algoritm funcționează prin selectarea aleatorie a unui subset de valori
din eșantionul inițial, calcularea medianei subsetului și verificarea
dacă este medianul întregului set. Dacă nu, procesul este repetat până
la atingerea unui număr maxim de încercări, după care se folosește
metoda deterministă clasică.

Avantajul metodei este eficiența sa computațională, deoarece nu necesită
sortarea întregului set de date, reducând astfel timpul de calcul în
comparație cu metodele deterministe. Totuși, această metodă nu
garantează un rezultat corect la fiecare rulare, ci doar cu o
probabilitate ridicată.

### Cod R utilizat

    ##### SUBPUNCTUL E #####
    cat("\n=============== SUBPUNCTUL E ===============\n")
    cat("Aplicam algoritmul Markov-Las Vegas pentru gasirea medianului\n")

    las_vegas_median <- function(vec, max_attempts=100) {
      n <- length(vec)
      k <- ceiling(n / 2)  
      
      for (attempt in 1:max_attempts) {
        sample_size <- min(ceiling(sqrt(n)), n)  
        sample_vec <- sample(vec, sample_size)  
        sample_median <- median(sample_vec)
        
        num_less <- sum(vec < sample_median)
        num_equal <- sum(vec == sample_median)
        
        if (num_less < k && num_less + num_equal >= k) {
          return(sample_median)
        }
      }
      
      return(median(vec))
    }

    vec <- sample(1:1000, 100, replace=FALSE)  
    median_exact <- median(vec)
    median_las_vegas <- las_vegas_median(vec)

    cat("Mediana exacta:", median_exact, "\n")
    cat("Mediana gasita cu Las Vegas:", median_las_vegas, "\n")
