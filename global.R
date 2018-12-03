source("scripts/projection_data_wrangling.R")
source("Scripts/UW_major_wrangling.R")
occ_summary <- filter(data[2 : nrow(data), ], Occupation_Type == "Summary")
occ_major <-  filter(occ_summary, layer2 == "0" & layer3 == "000")
occ_groups <- filter(occ_summary, !(layer2 == "0" & layer3 == "000"))
occ <- filter(data[2 : nrow(data), ], Occupation_Type == "Line item")
all_const <- uw_major_data[1,1]

occ_summary <- rbind(c("All",NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA), occ_summary)
occ_major <- rbind(c("All",NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA), occ_major)
occ_groups <- rbind(c("All",NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA), occ_groups)
