## Jour 390: API lab ----
# using data from Chicago data portal on CPD arrests 

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


# checking data quality 
api_data |> 
  skimr::skim_without_charts()

# basic transformation - driving charges 
api_data |> 
  # fixing variable names
  janitor::clean_names() |> 
  # finding which charge 1s involved driving
  filter(str_detect(charge_1_description, "^DRIVING")) |>
  # finding total for each charge type - M or F 
  count(charge_1_type) |> 
  # finding percentage of total arrests 
  mutate(pct = n / nrow(api_data) * 100,
         pct = round(pct, 4)) |> 
  # arranging from largest to smallest value
  arrange(desc(n)) |> 
  view()

# looked at arrests that involved driving in the most serious charge
# charge 1 = most serious charge 
# 50,104 M (misdemeanor) and 7,794 F (felony) as of 4/13/2025 data





