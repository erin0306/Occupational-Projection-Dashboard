# Team DANE Final Project
Group Members: Nam Pham, Alberto Melendez, Daniella Mesler, and Erin Cheng

## Project Overview and Purpose
We worked with the occupational employment and wage data in U.S. obtained through the Bureau of Labor Statistics website, which publishes a large amount of information by occupation, including career information, employment levels and projections, and data on earnings and working conditions. These estimates are
calculated with data collected from employers in all industry sectors in metropolitan and nonmetropolitan areas. Our targeted audience will be university students seeking employment because we anticipate that students are more interested in future trends in employment as they look ahead to graduation. We expect our shinyapp to provide insight into various industries and associated occupations through outlining wages, job stability, trends, projections, and a map. Our shinyapp may assist graduating students in making informed decisions about which occupation(s) to pursue and current students about their areas of study.


## Project Link
https://npham24.shinyapps.io/info201-final-dane/

## Data Source
1. Downloaded occupational data by state from the Bureau of Labor Statistics https://www.bls.gov/oes/current/oes_wa.htm#11-0000

2. Dowloaded Occupational projections, 2016–26, and worker characteristics, 2016 (Numbers in thousands)
from the Bureau of Labor Statistics  https://www.bls.gov/emp/tables/occupational-projections-and-characteristics.htm#1. There are several tables in this excel file but we chose Table 1.7 for our second dataset --> "Table 1.7 Occupational projections, 2016-26, and worker characteristics, 2016

3. UW Majors data, we created this dataset using source from the ![UW website](https://www.washington.edu/uaa/advising/degree-overview/majors/list-of-undergraduate-majors/)

## Data Manipulation Summary and Steps Completed
- Downloaded data from the sources above.
- Wrote R script to read data and organize it. Wrote data wrangling code to be used as basis for the interactive data used to build the widgets for source #1 (basic statistics). Pushed to Github for next steps.
- Pulled data from Github and created app and associated widgets for source #2 (projectional data coupled with UW major data). Chained multiple observe function in server and data wrangling for each observe function in order to correctly link the selection together in order to create the graph/ chart.
- Used shinydashboard for better visual presentation. 
   - *Note!* The photo of the Huksy (bottom of page) changes depending on what occupation is chosen (the educational requirements of the occupation, one photo for if only an associate's is required, another photo for if a bachelors is required, etc).
- Pulled data from github and created associated widgets for source #1 (occupational data by state). *Erin and Alberto describe your steps here*
- Compiled code and embedded into a single app with two tabs (one for each data set).
- Pushed remaining changes to github and closed out all issues
