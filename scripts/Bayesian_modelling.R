####################################################################
####### PSM workshop Day 2 - Bayesian modelling using JAGS #########
####################################################################

## load packages ###

library(R2jags)
library(bayesplot)
library(tidyverse)
library(patchwork)

#### Example 1: model f and alpha from drip d44Ca data ####
# in this first example we are assuming that our 
# d44Ca drip measurements represent one system state with the same true alpha and true f

# get some input data
# drip_CA = some simulated d44Ca of drip water similar to our generative model

drip_Ca <- rnorm(50, mean = -0.25, sd = 0.11)

# put into list
# can't have NAs in input data

# obtain number of data points
n <- length(drip_Ca)

# put all data into a list for feeding to jags
jags_data <- list(drip_Ca = drip_Ca, n = n)

# specify a model file name to save our model to

model_file <- ("Ca_isotope_toy_model.txt")

# start a jags model text

cat("model{
    
  # generative model
  # we think that our measurements all relate to one true
  # f, alpha, and host rock d44Ca, so these go outside the loop
  
  init_Ca <- host_Ca # assume initial soltion same as host rock
  
  epsilon <- (alpha -1)*1000
  
  # change through pcp

  # rayleigh fractionation

  mu_drip_Ca <- init_Ca + epsilon*log(f)
  
  # condition the drp d44Ca outcomes to our actual d44Ca drip data
  
  for (i in 1:n){

  drip_Ca[i] ~ dnorm(mu_drip_Ca, 0.05^-2) # Jags normal distribution uses precision not SD!
  # precision (tau) = SD^-2
  
  }
  
  
  # priors
  f ~ dbeta(8, 2)
  alpha ~ dunif(0.9994, 0.9999)
  host_Ca ~ dnorm(-0.35, 0.1^-2)
    
    
}", fill = TRUE, file = model_file)

# run the model using jags function

jags_model <- jags(data = jags_data, model.file = model_file, 
                   parameters.to.save = c("f", "alpha", "host_Ca", "mu_drip_Ca"), 
                   n.chains = 3, # number of MCMC chains
                   n.iter = 10000, # no of iterations (length of chains)
                   n.burnin = 1000, # iterations to discard from start of chain
                   n.thin = 1) # save every nth iteration (here we save all of them)

# look at output
# will give you mean and quantiles of posterior, Rhat, effective sample size

jags_model

# convert to mcmc objet to get mcmc chains

model_mcmc <- as.mcmc(jags_model)

# diagnostic plots
# trace plots to evaluate chain mixing

mcmc_trace(model_mcmc, pars = c("f", "alpha", "host_Ca", "mu_drip_Ca"))+
  theme_bw()

# autocorrelation function plot to look at serial autocorrelation in the chain

mcmc_acf(model_mcmc, pars = c("f", "alpha", "host_Ca", "mu_drip_Ca"))+
  theme_bw()

# plot posterior distributions

# plot the posterior for parameters
# add shaded areas for probability mass intervals


mcmc_areas(model_mcmc,
           pars = c("f"), 
           prob = 0.80) + 
  theme_minimal()

mcmc_areas(model_mcmc,
           pars = c("alpha"), 
           prob = 0.80) + 
  theme_minimal()

mcmc_areas(model_mcmc,
           pars = c("host_Ca"), 
           prob = 0.80) + 
  theme_minimal()

mcmc_areas(model_mcmc,
           pars = c("mu_drip_Ca"), 
           prob = 0.80) + 
  theme_minimal()

# compare prior and posterior to see how much we have learned from the data

post_plot <- mcmc_areas(model_mcmc,
           pars = c("f"), 
           prob = 0.80) + 
  theme_minimal()+
  ggtitle("Posterior of f")

prior_df <- data.frame(x = rbeta(10000, shape1 = 8, shape2 = 2))

prior_plot <- ggplot(prior_df, aes(x = x))+
  geom_density(fill = "goldenrod1")+
  theme_minimal()+
  ggtitle("Prior of f")

prior_plot/post_plot

# here our posterior and prior are very similar because we generated our data with
# parameters that are essentially the same as the prior
# but you could use slightly different data to see that change


#### Example 2: multiple samples through time ####
# here our samples represent different system states with different f
# but we still assume they share the same alpha

# make 3 data points as drip d44Ca data

drip_ca2 <- c(rnorm(1, mean = -0.25, sd = 0.11), 
              rnorm(1, mean = -0.15, sd = 0.13), 
              rnorm(1, mean = -0.1, sd = 0.09))

# get number of data points
n <- length(drip_ca2)


# make list of data to feed to jags
jags_data <- list(drip_Ca = drip_ca2, n = n)

# specify a model file name

model_file <- ("Ca_isotope_toy_model_multiple_samples.txt")

# start a jags model text

cat("model{
    
  # generative model
  
  init_Ca <- host_Ca # assume initial solution same as host rock
  
  # alpha stays outside the look bc we assume it doesn't change
  epsilon <- (alpha -1)*1000
  
  # change through pcp
  # PCP fractionation now inside the loop to represent that each data point
  # relates to slightly different f
  
  for(i in 1:n){
  
  # rayleigh fractionation

  mu_drip_Ca[i] <- init_Ca + epsilon*log(f[i])
  
  }
  
  # likelihood function
  
  for (i in 1:n){
  
  # include measurement error
  
  drip_Ca[i] ~ dnorm(true_Ca[i], 0.05^-2) 
  # we model measured d44Ca of drip as some value with the mean of a true d44Ca value
  # with some amount of noise determined by measurement error

  true_Ca[i] ~ dnorm(mu_drip_Ca[i], 0.05^-2) # condition true d44Ca to our measurements
  
  }
  
  
  # priors
  # now loop over f prior to have slightly different f draw for each sample
  for(i in 1:n){
  f[i] ~ dbeta(8, 2)
  }
  alpha ~ dunif(0.9994, 0.9999)
  host_Ca ~ dnorm(-0.35, 0.1^-2)
    
    
}", fill = TRUE, file = model_file)


# run the model
jags_model <- jags(data = jags_data, model.file = model_file, 
                   parameters.to.save = c("f", "alpha", "host_Ca", "mu_drip_Ca"), 
                   n.chains = 3, 
                   n.iter = 10000, 
                   n.burnin = 1000, 
                   n.thin = 1)

# convert to mcmc object

model_mcmc <- as.mcmc(jags_model)

# make trace plot

mcmc_trace(model_mcmc)
