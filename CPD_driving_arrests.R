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
  # removed unnecessary/unhelpful variables
  select(-computed_region_vrxf_vc4k, -computed_region_6mkv_f3dw,
         -computed_region_bdys_3d7i, -computed_region_43wa_7qmu,
         -computed_region_rpca_8um6) |> 
  # finding total for each charge type - M or F 
  count(charge_1_type) |> 
  # arranging from largest to smallest value
  arrange(desc(n)) |> 
  view()

# looked at arrests that involved driving in the most serious charge
# charge 1 = most serious charge 
# 50,100 M (misdemeanor) and 7,792 F (felony) as of 4/13/2025







