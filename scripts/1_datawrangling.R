#read in data occupational data by state
original_occupational_data_by_state <- read_excel("data/occupational_data_by_state.xlsx") 
                                                  #col_types="numeric")

# Get rid of null A_MEAN values
occupational_data_by_state <- filter(original_occupational_data_by_state, A_MEAN != "*" & A_MEAN != "#")

# Format A_MEAN to a number
occupational_data_by_state$A_MEAN <- as.numeric(occupational_data_by_state$A_MEAN)


# Minimum annual mean wage in each state
min_annual_wage_per_state <- select(occupational_data_by_state, ST, STATE, OCC_CODE, OCC_TITLE, TOT_EMP, A_MEAN) %>%
  group_by(STATE) %>%
  filter(A_MEAN == min(A_MEAN)
  )

## Maximum annual mean wage in each state
max_annual_wage_per_state <- select(occupational_data_by_state, ST, STATE, OCC_CODE, OCC_TITLE, TOT_EMP, A_MEAN) %>%
  group_by(STATE) %>%
  filter(A_MEAN == max(A_MEAN)
  )


# Mean of A_MEAN by occupation type (so mean of the annual mean wages) greater than $200,000
Above_200K <- select(occupational_data_by_state, STATE, OCC_CODE, OCC_TITLE, TOT_EMP, A_MEAN) %>%
  group_by(OCC_TITLE) %>%
  summarise(MEAN = mean(A_MEAN)) %>%
  filter(MEAN >= 200000)

# Mean of A_MEAN by occupation type (so mean of the annual mean wages) between $150,000 and $199,999
Between_150K_to_199K <- select(occupational_data_by_state, STATE, OCC_CODE, OCC_TITLE, TOT_EMP, A_MEAN) %>%
  group_by(OCC_TITLE) %>%
  summarise(MEAN = mean(A_MEAN)) %>%
  filter(MEAN >= 150000 & MEAN <= 199999)
  
# Mean of A_MEAN by occupation type (so mean of the annual mean wages) between $100,000 and $149,999
# This one might need to be split again
Between_100K_to_149K <- select(occupational_data_by_state, STATE, OCC_CODE, OCC_TITLE, TOT_EMP, A_MEAN) %>%
    group_by(OCC_TITLE) %>%
    summarise(MEAN = mean(A_MEAN)) %>%
    filter(MEAN >= 100000 & MEAN <= 149999)

# Mean of A_MEAN by occupation type (so mean of the annual mean wages) between $50,000 and $99,999
Between_99K_to_50K <- select(occupational_data_by_state, STATE, OCC_CODE, OCC_TITLE, TOT_EMP, A_MEAN) %>%
    group_by(OCC_TITLE) %>%
    summarise(MEAN = mean(A_MEAN)) %>%
    filter(MEAN >= 50000 & MEAN <= 99999)

# Mean of A_MEAN by occupation type (so mean of the annual mean wages) between $25,000 and $49,999
Between_49K_to_25K <- select(occupational_data_by_state, STATE, OCC_CODE, OCC_TITLE, TOT_EMP, A_MEAN) %>%
  group_by(OCC_TITLE) %>%
  summarise(MEAN = mean(A_MEAN)) %>%
  filter(MEAN >= 25000 & MEAN <= 49999)

# Mean of A_MEAN by occupation type (so mean of the annual mean wages) less than $24,999
Less_than_24K <- select(occupational_data_by_state, STATE, OCC_CODE, OCC_TITLE, TOT_EMP, A_MEAN) %>%
  group_by(OCC_TITLE) %>%
  summarise(MEAN = mean(A_MEAN)) %>%
  filter(MEAN <= 24999)


