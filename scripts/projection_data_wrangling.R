## Nam
library("dplyr")
library("ggplot2")
library("readxl")

## Check if you are on the main folder or on scripts/ data folder and read the excel file accordingly
data <- tryCatch({
  read_excel("../data/2016_projection.xlsx")
}, error = function(e) {
  read_excel("data/2016_projection.xlsx")
})

## Renaming so that the dataframe makes sense
data <- data %>%
  select(Jobs, X__1, X__2, X__3, X__4, X__5, X__6, X__7, X__8, X__9, X__10, X__11) %>%
  rename(Code = X__1) %>%
  rename(Occupation_Type = X__2) %>%
  rename(Employment_2016 = X__3) %>%
  rename(Employment_2026 = X__4) %>%
  rename(Employment_Change_Number = X__5) %>%
  rename(Employment_Change_Percent = X__6) %>%
  rename(Percent_Self_Employed_2016 = X__7) %>%
  rename(Occupational_Openings = X__8) %>%
  rename(Median_Annual_2017 = X__9) %>%
  rename(Entry_Education = X__10) %>%
  rename(Work_Experience = X__11) 

##Getting rid of uneccesary stuff
data <- data[3:(nrow(data) - 4), ]

##Formatting data to correct format
## (i.e. rounding 46.99999999999999 into 47)
data$Employment_2016 <- data$Employment_2016 %>% 
  as.numeric() %>% round(digits = 1)
data$Employment_2026 <- data$Employment_2026 %>% 
  as.numeric() %>% round(digits = 1)
data$Employment_Change_Number <- data$Employment_Change_Number %>% 
  as.numeric() %>% round(digits = 1)
data$Employment_Change_Percent <- data$Employment_Change_Percent %>% 
  as.numeric() %>% round(digits = 1)
data$Percent_Self_Employed_2016 <- data$Percent_Self_Employed_2016 %>% 
  as.numeric() %>% round(digits = 1)
data$Occupational_Openings <- data$Occupational_Openings %>%
  as.numeric() %>% round(digits = 1)

## Making layer 1 and 2 based on the occupational code. Layer 3 is done later
## If code is 11-0000
## layer1 is 11
## layer2 is 0
## layer3 is 000
## This is so that we can correctly deal with our data hiearchy
## As some items are in a sub category of other items and we want to be able to deal with this

data$layer1 <- substr(data$Code, 1, 2)
data$layer2 <- substr(data$Code, 4, 7)

## Loop through the data set in order to delete uneccessary data
row <- 2
while (row < nrow(data))
{
  data_row <- data[row, ]
  occ_type <- as.character(data_row[, 3])
  layer2 <- as.character(data_row[, 14])
  if (occ_type == "Summary") {
    if (substr(layer2, 3, 3) != "0" && substr(layer2, 4, 4) == 0) {
      data <- data[c(-row), ]
    }
  }
  row <- row + 1
}
rm(data_row)

## Diving the dataset into layer so that future wrangling in server/ ui is possible.
data$layer3 <- substr(data$layer2, 2, 4)
data$layer2 <- substr(data$layer2, 1, 1)

#write.csv(data, file = "../data/2016_projection.csv", row.names = FALSE)

