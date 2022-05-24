# Setting up my environment
# Importing library `tidyverse` and loading datasets

library(tidyverse)
library(lubridate)
df1 <- read.csv("./Cycles/202105.csv")
df2 <- read.csv("./Cycles/202106.csv")
df3 <- read.csv("./Cycles/202107.csv")
df4 <- read.csv("./Cycles/202108.csv")
df5 <- read.csv("./Cycles/202109.csv")
df6 <- read.csv("./Cycles/202110.csv")
df7 <- read.csv("./Cycles/202111.csv")
df8 <- read.csv("./Cycles/202112.csv")
df9 <- read.csv("./Cycles/202201.csv")
df10 <- read.csv("./Cycles/202202.csv")
df11 <- read.csv("./Cycles/202203.csv")
df12 <- read.csv("./Cycles/202204.csv")

# Combining all datasets

Bike_share <- rbind(df1,
                  df2,
                  df3,
                  df4,
                  df5,
                  df6,
                  df7,
                  df8,
                  df9,
                  df10,
                  df11,
                  df12)

glimpse(Bike_share)

#Removing unnecesary columns from all trips

Bike_share <- Bike_share %>% select(-c(start_lat, start_lng, end_lat, 
                                   end_lng))


#Inspecting new data frame we created

str(Bike_share)
colnames(Bike_share)
dim(Bike_share)
nrow(Bike_share)
head(Bike_share)
summary(Bike_share)


#Making indiviual coloumns for date, day, month, year of each trip

Bike_share$date <- as.Date(Bike_share$started_at)
Bike_share$month <- format(as.Date(Bike_share$date), "%m")
Bike_share$day <- format(as.Date(Bike_share$date), "%d")
Bike_share$year <- format(as.Date(Bike_share$date), '%Y')
Bike_share$day_of_week <- format(as.Date(Bike_share$date), "%A")


#Adding ride_length column

Bike_share$ride_length <- difftime(Bike_share$ended_at, Bike_share$started_at)


#inspecting structure of columns

str(Bike_share)


#Converting ride_length from factor to numeric to perform analysis

Bike_share$ride_length <- as.numeric(as.character(Bike_share$ride_length))


#Removing bad data. Many observation has negative ride length

Bike_share_v2 <- Bike_share[!(Bike_share$ride_length<0),]


##Conducting descriptive analysis

summary(Bike_share_v2$ride_length)


#Compare member and casual rides

aggregate(Bike_share_v2["ride_length"], by= Bike_share_v2["member_casual"], FUN = "mean")
aggregate(Bike_share_v2["ride_length"], by= Bike_share_v2["member_casual"], FUN = "median")
aggregate(Bike_share_v2["ride_length"], by= Bike_share_v2["member_casual"], FUN = "min")
aggregate(Bike_share_v2["ride_length"], by= Bike_share_v2["member_casual"], FUN = "max")


#Comparing average ride length of each day of the week of ench user type

aggregate(Bike_share_v2$ride_length ~ Bike_share_v2$member_casual + Bike_share_v2$day_of_week,
          FUN = mean)


#days_of week are out of order need to correct it

Bike_share_v2$day_of_week <- ordered(Bike_share_v2$day_of_week, 
                                   levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))



#Analyzing ridership data by type and weekday

Bike_share_v3 <- Bike_share_v2 %>%  mutate(weekday = wday(started_at, label=TRUE)) %>% #creates weekday field using wday
  group_by(member_casual, weekday) %>%   #groups by user-type and weekday
  summarise(number_of_rides = n(), avearge_duration = mean(ride_length)) %>%   #cal number of rides and average duration
  arrange(member_casual, weekday)   #sorts


#Analyzing ridership data by type and month

Bike_share_v4 <- Bike_share_v2 %>%  mutate(month = month(started_at, label=TRUE)) %>% #creates weekday field using month()
  group_by(member_casual, month) %>%   #groups by user-type and month
  summarise(number_of_rides = n(), avearge_duration = mean(ride_length)) %>%   #cal number of rides and average duration
  arrange(member_casual, month)   #sorts


#Visualize of average duration

Bike_share_v2 %>%  mutate(weekday = wday(started_at, label=TRUE)) %>% #creates weekday field using wday
  group_by(member_casual, weekday) %>%   #groups by user-type and weekday
  summarise(number_of_rides = n(), avearge_duration = mean(ride_length)) %>%   #cal number of rides and average duration
  arrange(member_casual, weekday) %>% #sorts
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge")


Bike_share_v2 %>%  mutate(month = month(started_at, label=TRUE)) %>% #creates month field using month()
  group_by(member_casual, month) %>%   #groups by user-type and month
  summarise(number_of_rides = n(), avearge_duration = mean(ride_length)) %>%   #cal number of rides and average duration
  arrange(member_casual, month) %>% #sorts
  ggplot(aes(x = month, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge")


#Exporting summary file for further analysis

#Exporting all trips necessary version for further analysis 
write.csv(Bike_share_v2, "D:/Cyclist_case_study/Bike_share_v2.csv")

#Exporting avg_ride_length by weekday and type
write.csv(Bike_share_v3, file = "D:/Cyclist_case_study/avg_ride_length_weekday.csv")

#Exporting avg_ride_length by month and type
write.csv(Bike_share_v4, file = "D:/Cyclist_case_study/avg_ride_length_month.csv")


