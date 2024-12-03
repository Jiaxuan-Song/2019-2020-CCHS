#### Preamble ####
# Purpose: Downloads and saves the data from Canadian Community Health Survey: Public Use Microdata File
# Author: Jiaxuan Song
# Date: 22 November 2024
# Contact: jiaxuan.song@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(tidyverse)
library(arrow)

CCHS_data <- 
  read_csv(
    here::here("data/01-raw_data/pumf_cchs.csv"),
    show_col_types = FALSE
  )
write_csv(CCHS_data, "data/01-raw_data/cchs_raw_data.csv")






