# Yammer_SQL_Project

Yammer product analysis is conducted solving three main case studies querying data using SQL on MySQL.

Analytics uses data and math to answer business questions, discover relationships, predict unknown outcomes, and automate decisions. Yammer, a social networking platform, faces product development problems; the team focuses on answering specific questions to discover novel relationships, solve the cases, and validate their testing results.
    
Yammer provided users data spanning three months to analyze the problem. This study used SQL programming, MySQL Workbench, and MS Excel. SQL (Structured Query Language) asks questions about data; MySQL runs the code, MS Excel, to draw the graphs and charts.

This report follows the pattern of a question, answer, validation and recommendation; At the start, it presents with clear problem statement with graphs/charts, generates the hypothesis of the problem, validates the answers using charts/graphs, concludes with a solution and recommends further steps to be taken.     

This project aims to solve those questions; Yammer specifically asked to solve three case problems related to their product.

## Drop-in User Engagement
   Engagement Dip – Figure out the source of the problem.
   
   Conclusions : UI/UX problem in mobiles and tables.
   
   Looked into following metrics to figure out source of the problem:
   1. Event types with highest drop rate over the months
   2. CTRs of engagement/reengagement emails.
   3. Change in percentage of email CTRs for each type of device(mobile, tablet and desktop) and each device.
   4. Found a high drop rate in mobile and tablet devices.
   
## Understanding Search Functionality
   Product Team thinks about revamping search – the job is to figure out whether the team should change it and what should be changed.
   
   Conclusions: Need to revamp search functionality.
   
   Following metrics were checked :
   1. Usage of autocomplete feature and full search over the period of three  months
   2. Number of searh runs in a session
   3. Most clicks for given top 10 results provided by Yammer search engine
   4. Number of clicks on each of the result after running a full query
   5. Search auto complete clicks after user's nth search run
   
## Validating A/B Test results
   A new feature tests off the charts. Your job is to determine the validity of the experiment.
   
   Metrics used for validation :
   1. Login frequency of users after introducing new feature
   2. Number of message posted
   3. Engagement of users
   
   Concluded A/B testing by conducting statistical significance tests using two tailed t-test, p-values.
   
   
   
   
   For detailed analysis report, [click here!](https://github.com/alsatwar/Yammer_SQL_Project/blob/main/Project_Report/Yammer%20Project%20Report%20Final.pdf)
   
