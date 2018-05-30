####################################################
#        Essentials of linear models               #
####################################################

###Stochastic part of linear models: Statistical distributions

### Normal distribution
n <- 10000 				    # Sample size
mu <- mean <- 600			# Mean
sd <- st.dev <- 30		# SD of body mass of male peregrines

sample <- rnorm(n = n, mean = mu, sd = sd)
print(round(sample[1:100], digits = 2))
hist(sample, col = "grey")


### Binomial distribution: The "coin-flip distribution"
n <- 10000  		# Sample size
N <- 16					# Number of individuals that flip the coin 
p <- 0.8				# Probability of success

sample <- rbinom(n = n, size = N, prob = p)
print(sample[1:100])
hist(sample, col = "grey") #Success
hist(N-sample, col=rgb(0.1,0.1,0.1,0.5), add = TRUE) #Failure


### Multinomial distribution
n <- 10000				          # Sample size
N <- 16					            # Number of individuals that flip the coin 
p <- c(0.6, 0.3, 0.1)				# Probability for each category

sample <- rmultinom(n = n, size = N, prob = p)
print(sample[,1:100])
hist(sample[1,], col = "grey", xlim = c(0, N), ylim = c(0,n/2)) #Category 1
hist(sample[2,], col=rgb(0.1,0.1,0.1,0.5), add = TRUE) #Category 2
hist(sample[3,], col=rgb(0.8,0.8,0.8,0.5), add = TRUE) #Category 3


### Poisson distribution
n <- 10000				# Sample size
lambda <- 5				# Mean and variance

sample <- rpois(n = n, lambda = lambda)
print(sample[1:100])
hist(sample, col = "grey", main = "Default histogram")

### Deterministic part of linear models: Linear predictor and design matrices
mass <- c(6, 8, 5, 7, 9, 11)
pop <- factor(c(1,1,2,2,3,3))
region <- factor(c(1,1,1,1,2,2))
hab <- factor(c(1,2,3,1,2,3))
svl <- c(40, 45, 39, 50, 52, 57)


### The model of the mean
model.matrix(mass~1)

summary(glm(mass ~ 1, family = "gaussian"))

mean(mass) #Mean
sum(mass)/length(mass) #Mean

sd(mass)/sqrt(length(mass)) #Standard Error


### t-Test
model.matrix(~region-1)

summary(lm(mass~region-1))

model.matrix(~region)

summary(lm(mass ~ region))


### Simple linear regression
lm(mass ~ svl)

model.matrix(~svl)

lm(mass~svl)

model.matrix(~svl-1)

lm(mass~svl-1)


### One-way analysis of variance (one-way ANOVA)
lm(mass ~ pop)

model.matrix(~pop)

model.matrix(~pop-1)

lm(mass~pop)				# Effects parameterization (R default)

lm(mass~pop-1)				# Means parameterization


### Two-way analysis of variance (two-way ANOVA)
lm(mass ~ region + hab)

model.matrix(~region + hab)

lm(mass ~ region * hab)

model.matrix(~region * hab)

lm(mass ~ region * hab-1-region-hab)

model.matrix(~ region * hab-1-region-hab)

### Analysis of covariance (ANCOVA)
lm(mass ~ pop + svl)			# Additive model
lm(mass ~ pop * svl)			# Interactive model
lm(mass ~ pop + svl + pop:svl) 	# Same, R's way of specifying the interaction term

model.matrix(lm(mass ~ pop + svl))	# Additive model

model.matrix(lm(mass ~ pop * svl))	# Interactive model

model.matrix(lm(mass ~ pop + svl-1))	# Additive model

model.matrix(lm(mass ~ (pop * svl - 1 - svl))) # Interactive model

lm(mass ~ pop + svl) 

### Exercise


#Simulate data
nsites <- 100
alpha <- 0.1
beta1 <- -1 
beta2 <- 1
x1 <- rpois(nsites, 5)
x1.s <- (x1 - mean(x1))/sd(x1)
x2 <- runif(nsites, 0, 1)
x2.s <- (x2 - mean(x2))/sd(x2)
x3 <- runif(nsites, 10, 1000)
x3.s <- (x3 - mean(x3))/sd(x3)
x4.s <- x4 <- rnorm(nsites, 0, 10)

lambda <- exp(alpha + beta1*x1.s + beta2*x2.s)
y <- rpois(nsites, lambda)

data <- data.frame(y,x1,x2,x3,x4)

write.csv(data, file = "C:/Users/farrm/Desktop/GLMfun.csv")

#Download file
urlfile <- "https://raw.githubusercontent.com/farrmt/Rworkshop/master/GLMfun.csv"

tst <- read.csv(urlfile)
tst <- tst[,-1]



### References

 # Kéry, Marc. 2010. Introduction to WinBUGS for ecologists:
 # A Bayesian approach to regression, ANOVA, mixed models,
 # and related analyses. Academic Press, Boston.





















