# Setam seed-ul pentru reproducibilitate
set.seed(88)

##### SUBPUNCTUL 1 #####
cat("\n=============== SUBPUNCTUL 1 ===============\n")
cat("Generam puncte uniform distribuite pe patratul [-1,1]^2\n")

# Numarul de puncte generate
N <- 10000  

# Generam doua variabile uniforme independente pe [-1,1]
X1 <- runif(N, min = -1, max = 1)
X2 <- runif(N, min = -1, max = 1)

# Reprezentare grafica a punctelor in patrat
plot(X1, X2, main = "Puncte distribuite uniform pe patratul [-1,1]^2",
     xlab = "X1", ylab = "X2", pch = 20, col = rgb(0, 0, 1, 0.5))

# Adaugam conturul patratului pentru claritate
abline(h = c(-1, 1), v = c(-1, 1), col = "red", lwd = 2)


##### SUBPUNCTUL 2 #####
cat("\n=============== SUBPUNCTUL 2 ===============\n")
cat("Aplicam metoda acceptarii si respingerii pentru discul unitate\n")

# Selectam punctele care se afla in discul unitate
inside_disc <- (X1^2 + X2^2) <= 1

# Plotare puncte pentru discul unitate
plot(X1[!inside_disc], X2[!inside_disc], col = "red", pch = 20, 
     xlab = "X1", ylab = "X2", main = "Simulare puncte in discul unitate")
points(X1[inside_disc], X2[inside_disc], col = "blue", pch = 20)  # Punctele acceptate

symbols(0, 0, circles = 1, inches = FALSE, add = TRUE, lwd = 2)

# Legenda
legend("topright", legend = c("In interior", "Respins"), col = c("blue", "red"), pch = 20)


##### SUBPUNCTUL 3 #####
cat("\n=============== SUBPUNCTUL 3 ===============\n")
cat("Calculam media aritmetica a distantelor fata de origine\n")

# Calculam distanta fiecarui punct acceptat fata de origine
distances <- sqrt(X1[inside_disc]^2 + X2[inside_disc]^2)

# Calculam media aritmetica a distantelor
mean_distance <- mean(distances)

# Media teoretica a distantei
theoretical_mean_distance <- 2/3

# Afisam rezultatele
cat("Media aritmetica a distantelor punctelor de origine:", mean_distance, "\n")
cat("Media teoretica a distantei:", theoretical_mean_distance, "\n")


##### SUBPUNCTUL 5 #####
cat("\n=============== SUBPUNCTUL 5 ===============\n")
cat("Generam puncte folosind metoda coordonatelor polare\n")

# Numarul de puncte de generat
N <- 1000

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

