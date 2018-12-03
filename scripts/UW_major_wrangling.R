## Nam
library("dplyr")
library("ggplot2")

currwd <- getwd()
##working directory is in main folder
if (substr(currwd, nchar(currwd)-3, nchar(currwd)) == "dane") {
  uw_major_data <- read.csv("data/UW_major.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)
} else {
  uw_major_data <- read.csv("../data/UW_major.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)
}

if (substr(currwd, nchar(currwd)-3, nchar(currwd)) == "dane") {
  major_link <- read.csv("data/major_link_occupation.csv", header = TRUE, stringsAsFactors = FALSE)
} else {
  major_link <- read.csv("../data/major_link_occupation.csv", header = TRUE, stringsAsFactors = FALSE)
}

uw_major_data <- uw_major_data 

major_link <- major_link %>% select(Jobs, A, BES, B, C, E, H, L, M, PS, SS)