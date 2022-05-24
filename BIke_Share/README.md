
# Google Data Analytics Capstone Case Study 1: CYCLISTIC BIKE-SHARE
#### Author: Aaquib Kudchikar

#### May 24, 2022

#### TOOLS USED: RStudio, Tableau

#### Dataset: [Cyclistic](https://divvy-tripdata.s3.amazonaws.com/index.html)

# Scenario

You are a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve your recommendations, so they must be backed up with compelling data insights and professional data visualizations.

<div align="center">
<img src="https://user-images.githubusercontent.com/96247747/170041460-39bbc400-e6a1-440c-8aa2-7538f6853a97.jpeg" width="400"></img>
</div>
<br/>

I have used the six steps of the data analysis process learned through out the 8 courses in the Google Data Analytics program to answer key business questions. Ask, prepare, process, analyze, share, and act.

## Ask
In this step, I asked myself questions such as ‘How do annual members and casual riders use Cyclistic bikes differently?’ to guide my analysis. Lily Moreno, the director of marketing believes annual Members are much more profitable than Casual riders. As a junior data analyst working at Cyclistic, my task is to help the marketing team analyze the differences between Casual riders and Members with the goal of providing recommendations that will help convert Casual riders into annual Members to maximize profit.

## Prepare
I downloaded the dataset that is used for this case study and stored it. I was required to download data for the last 12 months. I downloaded trip data between May 2021-April 2022. It is a public dataset provided by Motivate International Inc.  

## Process
I combined the separate files into one data frame using R. I then cleaned the data frame by removing unnecesary columns from Bike_share  like start_lat, start_lng, end_lat, and end_lng column. Created indiviual coloumns for date, day_of_week, month, year of each trip from started_at column, then added ride_length column(difference of ended at and started_at column) and deleted rows that had ride start time later than ride end time (ie started_at > ended_at).

## Analyze
I calculated and summarized the data frame using functions such as mean, median, max, and min in R. Compared average ride length of each day of the week of each user type, analyzed ridership data by type and weekday, ridership data by type and month

## Share
I created Column Chart using ggplot2 for Average Ride duration for weekday and month by member type. Exported the required versions of Data frames as csv file for more data visualizations in Tableau. I then combined the visualizations on a dashboard that can be viewed [here.](https://public.tableau.com/views/Bike_share_16533279294160/Dashboard1?:language=en-GB&:display_count=n&:origin=viz_share_link)

<div align="center">
<img src="https://user-images.githubusercontent.com/96247747/170044744-6b588dc4-4220-42aa-974b-6a39706c44fb.png")></img>
</div>
<br/>


It was interesting to see similar patterns in Tableau, and in R. To view my R code in GitHub, click [here.](https://github.com/AaquibCodes/Analytics_Projects/blob/0f6b7a7447e720fb4e257974090e52ca7baae502/BIke_Share/Data_Wrangling_Exploration.R)

## Act
In this final step, my task was to state and act on key findings by providing recommendations that will help the marketing director (my manager) maximize profits.

### Key Findings
Casual riders are most active on Weekends and tend to take longer rides, Casual riders ride 2 Times longer on Weekends and takes more no of rides than member.
Casual riders mostly use bikes for recreational, unlike members who have consistent activity throughout the year, casual riders use of bikes on weekends and holidays suggests they use them for recreational purposes
Causal riders take longest rides on the months of July August and September. On its peak on July, average ride duration of casual riders is 3x more than members.
Overall, Casual riders take less number of rides but for longer durations. Casual riders take 12 % less rides than Members but for 2.5x longer duration.

### Deliverables (Recommendations)

#### 1) Design riding packages by keeping recreational activities, weekend contests, and summer events in mind as more casual riders are inclined towards it. 
#### 2) If customers are charged on duration basis, offer specialized discounts and more longer rides and thus it results in high revenue. 
#### 3) Design seasonal packages, It allows flexibility and encourages casual riders to get membership for specific periods they want rather than paying for annual subscription. 
#### 4) Effective and efficient promotions by targeting casual riders at the busiest times.
     Days   :  Weekends
     Months :  June, July, August and September
     

### Thankyou for reading :)

## 🔗 Links
[![portfolio](https://img.shields.io/badge/my_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://github.com/AaquibCodes/)
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/aaquibkudchikar/)

