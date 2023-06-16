library(tidyverse)
library(reshape2)
Health_data <- read_csv("Data/healthcare_spending_per_capita_1991_2014.csv")
typeof(Health_data)
head(Health_data)

glimpse(Health_data)

#check out any missing data 
map(Health_data,~sum((is.na(.))))

#replace missing data with unknown value
Health_data$State_Name <- Health_data$State_Name%>%replace_na("unknown")
sum(is.na(Health_data))

# make data reshaping for better visualization 
Health_data <- melt(Health_data,id.vars=c("Code","Item","Group","Region_Number","Region_Name","State_Name" ),
                          variable.name = "Year",value.name = "dolars")
head(Health_data)
nrow(Health_data)
map(Health_data,~sum(is.na(.)))

#remove the first letter from year column values
Health_data$Year <- sub("Y","",Health_data$Year)
head(Health_data)
typeof(Health_data)
glimpse(Health_data)

selected<-Health_data %>%
  filter(Year=="1991")

ggplot(Health_data,aes( x = Region_Name,y = Y1991))+
  geom_point()
  
colnames(Health_data)
