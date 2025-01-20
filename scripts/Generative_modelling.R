####################################################################
##### PSM workshop Day 2 - Simulations and Generative models #######
####################################################################


#### random numbers and distributions ####

#### using distributions ####

# R contains several pseudo-random number generators using different distributions

# different functions to get different things from probability distributions
# d for density
# r for random number generation
# p for cumulative distribution
# q for quantile function (inverse cumulative distribution)

# we will mostly use r and sometimes d

# examples using normal distribution

rnorm(10)

# get 10 random draws from normal dist

# default is mean = 0 and sd = 1
# set different values

rnorm(10, mean = 5, sd = 0.5)

# use pnorm to know what the probability of a number in my distribution being below 4 is

pnorm(4, mean = 5, sd = 0.5)

# use dnorm to draw densities

# drawing densities
# using d versions (dnorm, dgamma, dunif)

# dnorm returns the probability at a specific point in the distribution

dnorm(5, mean = 5, sd = 0.5)

dnorm(4, mean = 5, sd = 0.5)

# we can use these functions to plot probability densities

x <- seq(from = 0,to = 10,by = 0.1)
y <- dnorm(x, mean = 5, sd = 0.5)

df <- data.frame(x, y)

plot(x, y, type = "l")

# other distributions

# uniform distribution

runif(10, min = 0, max = 10)

# in the uniform distribution all values between min and max are equally likely
# all with p = 1/n

dunif(10, min = 0, max = 10)
dunif(1, min = 0, max = 10)

x <- seq(from = -5,to = 15,by = 0.1)

y <- dunif(x, min = 0, max = 10)

df <- data.frame(x, y)

plot(x, y, type = "l")

# other examples include poisson, binomial, gamma, student's t and many more
# use them with rpois, rbinom, rgamma, rt

#### set.seed ####

# note that re-running the random number draws yields a different result every time

rnorm(10)

# use set.seed to receive the same numbers every time

set.seed(7)
rnorm(10)

# rnorm uses a pseudo-random number generator which uses and algorithm that starts
# at a different starting point - the seed - every time it is run
# it is good practice to always set a seed in a simulation script
# to ensure reproducibility


# sampling from a distribution
# using r versions, for random samples

samples <- rnorm(10, mean = 0, sd = 1)
samples

# use set.seed() to receive the same samples every time

# we can use sample() to randomly sample from a given set of things
# can be numbers, objects, letters etc

# number range
sample(1:10, 4)

# specific set of numbers, e.g. even numbers
sample(c(2,4,6,8,10,12), 1)

# letters

sample(letters, 5)
sample(LETTERS, 5)

# months

sample(month.name, 2)

# or sample from a specified vector (strings or numbers)

participants <- c("Sarah", "Gabe", "Yuval", "Cam", "Zhao", "Aida", 
                  "Jessica", "Jocelyn", "Isabel", "Michael", "Liz")

sample(participants, 1)

#### A first generative model: simulate a linear model ####

# simulate values of x
# we'll try to get something that looks like precip amounts

y_gamma <- dgamma(x, shape = 1, rate = 0.1)

plot(x, y_gamma)

rainfall <- rgamma(100, shape = 1, rate = 0.1)

plot(1:100, rainfall)

# simulate something that depends on rainfall
# drip rates

# specify a linear relationship

slope <- 80000/50

intercept <- 0

drip <- slope * rainfall + intercept

plot(rainfall, drip)

# we've just made a first very simple generative model!

#### Example Qustion ####
# how sensitive is my linear regression to measurement error?

# range of errors to test
# specify SDs for a normal distribution error model

error_sds <- seq(from = 0.1, to = 1, by = 0.1)

# writing a loop to iterate our linear model over the different amounts of error

# first make an empty matrix to save our values into

out_drip <- matrix(NA, nrow = 100, ncol = 10)

# write the loop

for (i in 1:length(error_sds)) {
  
  # simulate the error term
  # get random draws from normal dist
  error_perc <- rnorm(100, mean = 0, sd = error_sds[i])
  
  # convert into a percentage of 10,000 drips
  error <- error_perc * 10000
  
  # or replace negative values with sample from lowest 20% of data
  
  drip <- ifelse(drip < 0, sample(drip[drip < quantile(drip, probs = 0.2)], 1), drip)
  
  # save output
  
  out_drip[,i] <- drip
  
}

out_drip

plot(rainfall, out_drip[,1])

plot(rainfall, out_drip[,10])



#### A first Ca isotope model ####
# pcp, shifts d44Ca
# model of drip water d44Ca


# initial d44Ca 
# host rock d44Ca

host_Ca <- rnorm(1000, mean = -0.35, sd = 0.1)

# initial solution d44Ca is same as host rock d44Ca
# renaming this isn't really necessary from a computation point of view
# but makes it easier to think about for now

init_Ca <- host_Ca

# model change through pcp

# choose some value of f after pcp
# beta distribution is bounded between 0 and 1
# peak of distribution is at ~0.8

f <- rbeta(1000, shape1 = 8, shape2 = 2)

# specify some fractionation factor alpha

alpha <- rnorm(1000, mean = 0.9996, sd =1e-5)

# convert to epsilon to work with delta values rather than isotope ratios
epsilon <- (alpha -1)*1000

# rayleigh fractionation equation

drip_Ca <- init_Ca + epsilon*log(f)

# visualize the outcomes

hist(host_Ca)
hist(drip_Ca)

hist(alpha)
hist(f)
