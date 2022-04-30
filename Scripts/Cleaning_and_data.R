#### Preamble ####
# Purpose: Finding Out If People Are Getting Divorced Due to the Lockdown Caused by the COVID-19 Pandemic. 
# Author: Min Chang
# Data: 27 April 2022
# Contact: hyemin.chang@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - None


#### Workspace setup ####

library(opendatatoronto)
library(tidyverse)
library(kableExtra)
library(forcats)
library(ggplot2)
library(knitr)
library(tibbletime)
library(dplyr)
library(readr)
D


#### Loading Data ####

#Based on: https://open.toronto.ca/dataset/marriage-licence-statistics/
#Based on: https://open.canada.ca/data/en/dataset/82cc8f33-3b40-4a57-83d1-b8059a12f742
package <- show_package("e28bc818-43d5-43f7-b5d9-bdfb4eda5feb")
resources <- list_package_resources("e28bc818-43d5-43f7-b5d9-bdfb4eda5feb")
datastore_resources <- filter(resources, tolower(format) %in% c('csv'))
data <- filter(datastore_resources, row_number()==2) %>% get_resource()

marriage_license_data <-
  readr::read_csv("Inputs/Marriage Licence Statistics Data.csv")

marriage_divorce_data <-
  readr::read_csv("Inputs/39100052.csv")


#### Cleaning Data ####

# Marriage_license_data

marriage_license_data <-
  marriage_license_data|>
  filter(CIVIC_CENTRE == "TO")|>
  dplyr::select(CIVIC_CENTRE, MARRIAGE_LICENSES, TIME_PERIOD)

marriage_license_data <-
  marriage_license_data[-c(1:96),]

marriage_license_data <-
  marriage_license_data[-c(25:27),]


# Saving cleaned marriage_license_data
save(marriage_license_data, file = "outputs/Rdata/marriage_license_data.RDA")

## Marriage_divorce_data

marriage_divorce_data <-
  marriage_divorce_data|>
  filter(GEO == "Canada", `Sex or Gender` == "Both sexes")|>
  select(REF_DATE, GEO, `Sex or Gender`)

marriage_divorce_data <-
  marriage_divorce_data[-c(1:196),]

marriage_divorce_data <-
  marriage_divorce_data[-c(3:4),]

marriage_divorce_data <-
  marriage_divorce_data[-c(5:6),]

## Saving cleaned marriage_divorce_data
save(marriage_divorce_data, file = "outputs/Rdata/marriage_divorce_data.RDA")
  

  




