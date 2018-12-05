## Nam

## Takes in a dataset (occ) and produce a graph.

library('shiny')
library('dplyr')
library('plotly')

entry_equivalent_husky <- function(entry) {
  switch(entry,
         "Bachelor's degree" = "Banchelor_Husky.PNG",
         "High school diploma or equivalent" = "Highschool_Husky.PNG",
         "Master's degree" = "Master_Husky.png",
         "Associate's degree" = "Associate_Husky.png",
         "Postsecondary nondegree award" = "Postnonsecondary_Husky.PNG",
         "No formal educational credential" = "NoEducation_Husky.PNG",
         "Some college, no degree" = "Some_college_no_degree.PNG",
         "Doctoral or professional degree" = "Doctorate_Husky.png")
}

specific_table_information <- function(df, job) {
  job_row <- df %>% filter(Jobs == job)
  ##Getting the mean of all Jobs
  df[df == ">=$208,000"] <- "208000"
  all_job_mean <- df %>% 
    ##filter em dash out
    filter(Median_Annual_2017 != "\u2014")
  all_job_mean <- all_job_mean %>%
    mutate(Mean = mean(as.numeric(Median_Annual_2017)))
  all_job_mean <- round(as.numeric(all_job_mean[1, ]$Mean), digits = 0)
  employment_2016 <- job_row$Employment_2016
  employment_2026 <- job_row$Employment_2026
  employment_change <- as.numeric(job_row$Employment_Change_Percent)
  median <- job_row$Median_Annual_2017
  entry_edu <- job_row$Entry_Education
  work_exp <- job_row$Work_Experience
  tags$img(src = "Banchelor_Husky.PNG", width = 300, height = 300)
  
  beginTag <- paste0("<font size = \"6>\"" ,"<p>",
                     "<img src=\"", entry_equivalent_husky(entry_edu) ,
                     "\" align=\"left\" height=300 width=300",
                     " border=\"6\"", 
                     " title = \"", entry_edu, "\"",
                     ">")
  begin <-
  paste0("Your selected specific occupation is ", job, ". According to the dataset from the Burreo of Labor
         Statistic website, the employment in 2016 is ", employment_2016, " thousands and the employment in 
         2026 is ", employment_2026, " thousands. This is ")
  if (employment_change > 0) {
    middle <- paste0(" an increase of ", employment_change, " percent. ")
  } else if (as.numeric(employment_change) < 0) {
    middle <- paste0(" a decrease of ", -employment_change, " percent. ")
  } else {
    middle <- paste0(" a non-increase. ")
  }
  end <- paste0(" This job's median wage in 2017 is $", median, " , compared to the mean of all job of $",
                all_job_mean, ". The job usually requires an entry education of a ", entry_edu, ". ")
  if (work_exp == "5 years or more") {
    end2 <- paste0("This job also usually requires a working experience of 5 years or more.")
  } else if (work_exp == "Less than 5 years") {
    end2 <- paste0("This job also usually requires a working experience of less than 5 years.")
  } else {
    end2 <- paste0("This job does not require any working experience.")
  }
  endTag <- "</p></font>"
  return(paste0(beginTag, begin, middle, end, end2, endTag))
}


employment_projection_chart <- function(df, limit) {
  if (nrow(df) > limit) {
    p <- df[1 : limit, ]
  } else {
    p <- df
  }
  p <- p %>% select(Jobs, Employment_2016, Employment_2026)
  p <- p %>%
    plot_ly() %>%
    add_trace(x = ~Jobs, y = ~Employment_2016, type = "bar",
              textposition = 'auto',
              name = "2016",
              marker = list(color = 'rgb(158,202,225)',
                            line = list(color = 'rgb(8,48,107)'))) %>%
    add_trace(x = ~Jobs, y = ~Employment_2026, type = 'bar', 
              textposition = 'auto',
              name = "2026",
              marker = list(color = 'rgb(58,200,225)',
                            line = list(color = 'rgb(8,48,107)'))) %>%
    layout(title = "2016 - 2026 Employment Projection Between Occupation Groups",
           barmode = "group",
           xaxis = list(title = "Jobs"),
           yaxis = list(title = "Employments (in Thousands)"))
  return(p)
}


median_wage_comparison <- function(df, limit) {
  df <- df %>% filter(Median_Annual_2017 != "-")
  
  if (nrow(df) > limit) {
    p <- df[1 : limit, ]
  } else {
    p <- df
  }  
  p <- p %>% select(Jobs, Median_Annual_2017)
  
  p[p == ">=$208,000"] <- "208000"
  p$Median_Annual_2017 <- as.numeric(p$Median_Annual_2017)
  p <- p %>% 
    plot_ly(
      x = ~Jobs,
      y = ~Median_Annual_2017,
      type = "bar",
      color = "plum") %>%
    layout(title = "2017 Annual Median Wage Between Occupation Groups",
           barmode = "group",
           xaxis = list(title = "Jobs"),
           yaxis = list(title = "Median Annual Wage"))
  return(p)
}


