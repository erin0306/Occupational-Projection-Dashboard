overview <- tabItem(
  tabName = "overview_tab",
  titlePanel("Info 201 Final Project - Dane"),
  fluidRow(
    box(width = 12,
        title = "Overview",
        status = "info",
        solidHeader = TRUE,
        h2("Project Description"),
        HTML("<font size = 4><p>
             Our project's goal is to analyze various occupations and industries through outlining 
             wages, job stability, future trends, and geographical representation. 
             We will be working with the occupational employment and wage data in the U.S.
             obtained through the <a href=\"https://www.bls.gov/oes/tables.htm\">Bureau 
             of Labor Statistics</a> website, which publishes a large amount of information by occupation, 
             including career information, employment levels and projections, and data on earnings and working 
             conditions. These estimates arecalculated with data collected from employers in all industry sectors 
             in metropolitan and nonmetropolitan areas.</p></font>"),
        
        HTML("<hr>"),
        
        h2("Audience"),
        HTML("<font size = 4><p>Our targeted audience will be university students seeking employment. We anticipate
             the students to be a lot more interested in future trends in employment since this particular group
             still has a long journey to go in term of professional life. We expect these data to provide them
             insights into each occupations and industries through outlining wages, job stability, future trends,
             and geographical representation. The data may assist graduating students in making informed decisions
             about their future employment, and it can also help students without a major to be more mindful of
             what they want to study.</p></font>"),
        
        HTML("<hr>"),
        
        h2("Employment Projection"),
        HTML("<font size = 4><p>The Employment Projection tab on the side allows user to input their 
             <a href =\"https://www.washington.edu/uaa/advising/degree-overview/majors/list-of-undergraduate-majors/\">
             undergraduate major</a> and this would in turn recommend them occupational groups related to their
             chosen major. The user would then choose an occupational group and be able to compare the 2016-2026 
             Employment Projection and 2017 annual median wage between that occupational group via bar charts.
             The user can then choose a specific occupation among these occupational groups and see various
             statistics on that job (such as employment numbers, entry degree requirement, median wage, ...)
             </p></font>"),
        
        HTML("<hr>"),
        
        h2("Current Occupation"),
        HTML("<font size = 4><p>The Current Occupation tab allows users to choose an occupation and see the 
             heatmap of total employment, mean hourly wage, and mean annual wage across the different states 
             in the United States. Depending on the state and the occupational group that are chosen, the 
             user can also compare occupations through looking at the total employment with a pie chart. 
             The user can also compare mean hourly wage and mean annual wage with bar charts.
             </p></font>"),
        
        HTML("<hr>"),
        
        h2("Contributors"),
        h4(">Nam Pham"),
        h4(">Erin Chan"),
        h4(">Alberto Meléndez"),
        h4(">Daniella Mesler")
        
        )
  )
)
