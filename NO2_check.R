
###################
# Author: Michael Hedges
# Date commenced: 30 May 2022
# Date finalised: 
###################

## Description: This script reads the NO2 data from the underground exposure journeys
## and plots it




library(lubridate)
library(tidyverse)
library(ggplot2)
library(plotly)
library(dplyr)
library(openair)
library(stringr)
library(magrittr)
library(orca)

#Set working directory

rm(list=ls(all=TRUE))
path = dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(path)

# Read ozone data and clean files
no2 <- read.csv("TY1/TY1_NO2_20220609.csv", header = TRUE, stringsAsFactors = FALSE)

colnames(no2)[1] <- "date"

no2$date <- as.POSIXct(strptime(no2$date, "%d/%m/%Y %H:%M"), tz = "GMT")

# Convert to ug/m3

colnames(no2)[3] = "NO2"

no2 = select(no2, date, NO2)

no2$NO2 <- no2$NO2 * 1.9125

no2_1 <- timeAverage(no2, avg.time = "1 min")

ggplot(no2, aes(date, NO2)) +
  geom_line()

ggplot(no2_1, aes(date, NO2)) +
  geom_line()

