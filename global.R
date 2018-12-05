## Global value
source("scripts/projection_data_wrangling.R") ## Data wrangling needed for employment projection
source("scripts/UW_major_wrangling.R")
occ_summary <- filter(data[2 : nrow(data), ], Occupation_Type == "Summary")
occ_major <-  filter(occ_summary, layer2 == "0" & layer3 == "000")
occ_groups <- filter(occ_summary, !(layer2 == "0" & layer3 == "000"))
occ <- filter(data[2 : nrow(data), ], Occupation_Type == "Line item")
all_const <- uw_major_data[1,1]

occ_summary <- rbind(c("All",NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA), occ_summary)
occ_major <- rbind(c("All",NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA), occ_major)
occ_groups <- rbind(c("All",NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA), occ_groups)


data_2017 <- read_excel("data/occupational_data_by_state.xlsx")
occ_groups_2017 <- filter(data_2017, OCC_GROUP == "major")
occ_2017 <- data_2017 %>% filter(OCC_GROUP == "detailed")