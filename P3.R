# Setam seed-ul pentru reproductibilitate
set.seed(76)

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

# Verificam intersecțiile pentru fiecare ac
intersect_cruce1 <- x1 <= (0.5 * sin(theta1))
intersect_cruce2 <- x2 <= (0.5 * cos(theta1))  # Folosim cos pentru perpendicularitate

# Calculam Z/2 pentru fiecare incercare
Z2 <- (intersect_cruce1 + intersect_cruce2) / 2

# Media și varianța lui Z/2
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



##### SUBPUNCTUL C #####
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

cat("Lungimea acului =", acul_lungime, "Distanța dintre linii =", spatiu_linii, "\n")
cat("Probabilitate estimata (Buffon):", probabilitate_estimata, "\n")
cat("Probabilitate teoretica (Buffon):", probabilitate_teoretica, "\n")


##### SUBPUNCTUL C1-C2 #####
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
