#read in data
occupational_data_by_state <- read.csv("data/edited_occupation_by_state.csv")

## finding higer annual mean wages attempt!
highest_a_mean <- filter(occupational_data_by_state, a_mean >= "10000")
