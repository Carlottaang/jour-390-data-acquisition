### Jour 390: data portal dive ----

# load packages 
library(tidyverse)

# load data 
diversions <- read_csv("data/Diversion_20250413.csv") |> 
  janitor::clean_names()

# exploring dataset ----
# how many people fail vs. graduate?
diversions |> 
  count(diversion_result)

# do more people graduate from certain programs compared to others?
diversions |> 
  group_by(diversion_program) |> 
  count(diversion_result) |> 
  mutate(pct = n / nrow(diversions) * 100) |> 
  arrange(desc(n))
