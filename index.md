---
title: "Stalagmite Proxy System Modelling using R and JAGS"
author: "Sarah Pederzani"
date: "Jan 17-26 2024"
output: html_document
---

We will discuss Bayesian proxy system modelling of karst systems and stalagmite records and work on individual small projects. The workshop will take place in the Geology & Geophysics, Fredrick Albert Sutton Building. See bewlo for more information on [how to get there](#location). 

The workshop will start out with one day of lectures introducing fundamental concepts, which we will start applying in practical coding exercises on Day 2. See the full [schedule](#schedule) below. 
  
Day 2 will demonstrate how to use simulations to construct and test PSM model structures and teach the fundamentals of JAGS - the Bayesian modelling language we will use. Full participation in the coding exercises requires a basic knowledge of R coding and working installations of the necessary software. Please see check out software [pre-requisites](#prerequisites) and installation instructions before the workshop. There is also information on [how to connect to WiFi](#wifi) on campus. 

Anyone is welcome to sit in on Day 2 without coding actively to get the conceptual ideas of model construction. For those newer to R there are cheat sheets and helpful resources on the [resources page](resources.md). 

Project work participants also please make sure to prepare your data following the [data format guidelines](#data-cleaning). 
    
Topic links in the [schedule](#schedule) will lead to brief summaries of covered content. At a later date slides and code files will be available for download as well. 

Resources for project participants are available on a dedicated [resources page](resources.md). 

<h1 id="prerequisites">
Prerequisites
</h1>

## Reading
Fischer-Femal et al. paper on a soil carbonate Bayesian PSM
[https://doi.org/10.1016/j.gca.2020.10.022](https://doi.org/10.1016/j.gca.2020.10.022)

Treble et al. preprint for the KarstSolution model, which is a good example of a (non-Bayesian) karst model
[https://doi.org/10.31223/osf.io/j4kn6](https://doi.org/10.31223/osf.io/j4kn6)

## Software
If you plan on participating in the programming classes on Day 2 you will need:
  
- a working installation of R and RStudio
- a working installation of JAGS
- a number of R packages that will be used, see list below
      
Please go through the installations steps in order to make sure that each software is linked correctly to its prerequisites. 
      
### R and RStudio
      
First, download the most recent R installation file [here](https://ftp.osuosl.org/pub/cran/) and follow the installation instructions for your operating system. 
      
Then install RStudio. RStudio is a coding environment that makes using R much more pleasant. You can download the desktop client [here](https://posit.co/downloads/). 
      
For reference on the level of R skills needed you can take a look at this introductory course (chapters 1-8 essential, 1-13 ideal): 
[https://swcarpentry.github.io/r-novice-gapminder/index.html](https://swcarpentry.github.io/r-novice-gapminder/index.html)
      
### JAGS
      
JAGS is the program that we use to run our Bayesian models. JAGS is a stand-alone program that needs to be installed seperately from R. We will run our models from R scripts that interface with the JAGS program through a set of R packages listed further down. 

Download the [JAGS installation file](https://sourceforge.net/projects/mcmc-jags/) and run through the installation. 
      
### R packages
      
You will need the following R packages: tidyverse, R2jags, bayesplot, CalvinBayes, palmerpenguins, patchwork, devtools
      
You can install them by opening RStudio and running the following command in the Console at the bottom left: `install.packages(c("tidyverse", "R2jags", "bayesplot", "palmerpenguins", "patchwork", "devtools"))`. 
      
You will need to install the CalvinBayes package using devtools. Run the following code in the Console:
        
`devtools::install_github("rpruim/CalvinBayes")`

<h2 id="data-cleaning">
Data cleaning
</h2>

For the participants of the project portion - please make sure to bring cleaned data that you will need for your project. I have deposited some cleaned data in a shared folder I sent via email. You can use that as a template for formatting your own files. 

Some general data cleaning/formatting guidelines:

- save your data in csv files
- name your files something reckognizable and don't use spaces or special characters in the file names
- name your columns something recknognizable and don't use spaces or special characters in column names
- I recommend using lower case seperated by underscores for any file, column, or variable names
- format all data into SI units to avoid conversion errors (e.g. rainfall in mm not inches, temperatures in celcius)
- format dates into international format ("yyyy-mm-dd" or "dd-mm-yyy"), don't use "mm-dd-yyyy"

Since most people will use some data that I have previously cleaned this will ensure that units and formats are compatible across data sets and you don't end up spending too much time reformating things during the workshop. 

<h2 id="wifi">
WiFi
</h2>

Eduroam is available on UofU campus so if you have that set up it should work automatically. Setup will depend on your home institution so check Eduroam instructions there. 

If you have issues with Eduroam you can connect to the UGuest WiFi instead. The U has a [UGuest connection guide](https://www.union.utah.edu/wp-content/uploads/sites/67/2024/06/UGuestGuide2022.pdf). You will need to enter a phone number to receive a confirmation code. 
      
<h1 id="schedule">
Schedule
</h1>
      
## Friday
      
| Time          | Fri Jan 17th - Room 483              | Format    | Instructor  |
| ------------- | ------------------------------------ | --------- | ----------- |
| 09:00 &ndash; 10:30  | [Introduction to Proxy System Models](PSM_intro.md)  | Lecture   | Gabe        |
| 10:30 &ndash; 11:00  | Morning Break                        |           |             |
| 11:00 &ndash; 12:00  | [Introduction to Karst Modelling](karst_modelling.md)  | Lecture   | Sarah       |
| 12:00 &ndash; 13:00  | Lunch Break                          |           |             |
| 13:00 &ndash; 14:30  | [Bayesian Statistics](Bayesian_Stats.md)           | Lecture   | Sarah       |
| 14:30 &ndash; 15:00  | Afternoon Break                      |           |             |
| 15:00 &ndash; 16:30  | [Bayesian Statistics](Bayesian_Stats.md) (cont.)           | Lecture   | Sarah       |
        
## Saturday
        
| Time          | Sat Jan 18th - Room 303              | Format    | Instructor  |
| ------------- | ------------------------------------ | --------- | ----------- |
| 09:00 &ndash; 10:30  | [Forward Simulations](forward_modelling.md)         | Practical | Sarah       |
| 10:30 &ndash; 11:00  | Morning Break                        |           |             |
| 11:00 &ndash; 12:00  | [Forward Simulations](forward_modelling.md) (cont.)          | Practical | Sarah       |
| 12:00 &ndash; 13:00  | Lunch Break                          |           |             |
| 13:00 &ndash; 14:30  | [Bayesian Models in R and JAGS](bayesian_modelling.md) | Practical | Sarah       |
| 14:30 &ndash; 15:00  | Afternoon Break                      |           |             |
| 15:00 &ndash; 16:30  | [Bayesian Models in R and JAGS](bayesian_modelling.md) (cont.) | Practical | Sarah       |
        
## Sunday
        
| Time          | Sun Jan 19th - 303/GSCE     &nbsp;         | Location |
| ------------- | ------------------------------------ | --------- |
| 09:00 &ndash; 10:30  | Post/Pre-Docs: recap & project prep  | GSCE Seminar Room |
|               | PIs: PI meeting                      | Room 303 |
| 10:30 &ndash; 11:00  | Morning Break                        |         
| 11:00 &ndash; 12:00  | Post/Pre-Docs: recap & project prep  |  GSCE Seminar Room |
|               | PIs: PI meeting                      | Room 303 |
| 12:00 &ndash; 13:00  | Lunch Break                          |   
| 13:00 &ndash; 14:30  | Full group meeting                   |  Room 303 |
| 14:30 &ndash; 15:00  | Afternoon Break                      |   
| 15:00 &ndash; 16:30  | Full group meeting                   |  Room 303 |

**Group Dinner**
        
## Individual project work
        
| Day          | Time            | Location          |
| ------------ | --------------- | ----------------- |
| Mon Jan 20th | ~ 09:00 &ndash; 16:30  | GCSC Seminar Room |
| Tue Jan 21st | ~ 09:00 &ndash; 16:30  | GCSC Seminar Room |
| Wed Jan 22nd | ~ 09:00 &ndash; 16:30  | GCSC Seminar Room |
| Thu Jan 23rd | Day off         |  |
| Fri Jan 24th | ~ 09:00 &ndash; 16:30  | GCSC Seminar Room |
| Sat Jan 25th | ~ 09:00 &ndash; 16:30  | GCSC Seminar Room |
| Sun Jan 26th | ~ 09:00 &ndash; 16:30  | GCSC Seminar Room |

<h1 id="location">
Location
</h1>

We will meet in the Fredererick Albert Sutton Building (FASB, 115 S 1460 E, Salt Lake City, UT 84112) for all workshop days. Please check the room numbers for each day in the schedule above. On Friday we meet in Room 483 on the 4th floor (note that main entrance is on the 2nd floor). If you enter through the main entrance head to your right and up the stairs/lift. Room 483 is on the south side of the building. 

Find the location of FASB on the [campus map](https://map.utah.edu/?buildingnumber=12) and on [Google Maps](https://maps.app.goo.gl/58aHJL5Ey15PvQXA7). 

**Commuting by Bus/Trax:** The closest bus stops are the Kennecott Building stop (lines 1, 2, 223) and President's Circle (lines 213, 220). Stadium Station (Trax red line, bus lines 4, 455, 473) is about a 10 minute walk from FASB. 

Public transportation tickets are 2.50$ and can be bought on the [Transit App](https://www.rideuta.com/Fares-And-Passes/Transit-Mobile-Ticketing). 
        
        
        
        
        
