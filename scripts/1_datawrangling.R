#read in data occupational data by state
original_occupational_data_by_state <- read_excel("data/occupational_data_by_state.xlsx")

## Get rid of null A_MEAN values
occupational_data_by_state <- filter(original_occupational_data_by_state, A_MEAN != "*" & A_MEAN != "#")

## WHY ARE THE WAGES NOT FOLLOWING THE MAX/MIN??? the highest wage is greater than 200,000?????
## Minimum annual mean wage in each state
min_annual_wage_per_state <- select(occupational_data_by_state, ST, STATE, OCC_CODE, OCC_TITLE, TOT_EMP, A_MEAN) %>%
  group_by(STATE) %>%
  filter(A_MEAN == min(A_MEAN)
  )

## Maximum annual mean wage in each state
max_annual_wage_per_state <- select(occupational_data_by_state, ST, STATE, OCC_CODE, OCC_TITLE, TOT_EMP, A_MEAN) %>%
  group_by(STATE) %>%
  filter(A_MEAN == max(A_MEAN)
  )

## Categorizing by annual wages IN PROCESS
a_mean_test <- select(occupational_data_by_state, ST, STATE, OCC_CODE, OCC_TITLE, TOT_EMP, A_MEAN) %>%
  group_by(OCC_TITLE) %>%
  filter(A_MEAN >= "200000")


#...... continue this

