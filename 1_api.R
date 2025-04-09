## Jour 390: API lab ----

# load packages 
library(tidyverse)
library(jsonlite)
library(httr)
library(RCurl)

# create request using URL 
response <- GET("https://data.cityofchicago.org/resource/dpt3-jri9.json?$limit=9999999")

# checking status code to see if request was successful 
# if status code = 200, request was successful 
status_code <- status_code(response)

# extract data from the response 
api_data <- fromJSON(content(response, as = "text"))

