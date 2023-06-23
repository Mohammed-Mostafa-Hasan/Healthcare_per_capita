library(tidyverse)
library(reshape2)
library(shiny)
Health_data <- read_csv("Data/healthcare_spending_per_capita_1991_2014.csv")
# typeof(Health_data)
# head(Health_data)
# 
# glimpse(Health_data)
# 
# #check out any missing data 
# map(Health_data,~sum((is.na(.))))
# 
# #replace missing data with unknown value
# Health_data$State_Name <- Health_data$State_Name%>%replace_na("unknown")
# sum(is.na(Health_data))
# 
# # make data reshaping for better visualization 
# Health_data <- melt(Health_data,id.vars=c("Code","Item","Group","Region_Number","Region_Name","State_Name" ),
#                           variable.name = "Year",value.name = "dolars")
# head(Health_data)
# nrow(Health_data)
# map(Health_data,~sum(is.na(.)))
# 
# #remove the first letter from year column values
# Health_data$Year <- sub("Y","",Health_data$Year)
# head(Health_data)
# typeof(Health_data)
# glimpse(Health_data)
# 
# selected<-Health_data %>%
#   filter(State_Name==c("California"))
# unique(selected$State_Name)
# head(Health_data$State_Name,15)
# 
# length(unique(Health_data$State_Name))
# 
# ggplot(selected,aes(fill = State_Name,y = Y2013 ))+
#   geom_boxplot()+
#   scale_y_continuous(limits = seq(0,5000,2300))
# 
# #select the mean values for each unique state name respect to year 1991
# 
# selected<-Health_data %>%
#   select(State_Name,Y1991)%>%
#   filter(State_Name=="Arizona")
#  
# 
# 
# unique(Health_data$Region_Number)
# 
# unique(Health_data$Region_Name)
# head(Orange)
# 
# select_max <-Health_data %>%
#   group_by(State_Name)%>%
#   summarise(max_spend = max(Y1991))
#   slice(n=10)
# #   select the maximum value for different state names
#   Health_data %>% 
#     filter(State_Name=="Alabama")%>%
#     summarise(max(Y1991))
# #find the distribution of all values for each year
#   
#   health_dist <- Health_data %>%
#    select(State_Name,Y1991) %>%
#      filter(State_Name==c("Alabama","California"))
# 
#   
# head(health_dist)
# 
# qplot(Y1991,State_Name,data = health_dist,geom = "boxplot")
# 
# # plot using ggplot for state name and year 1991
# ggplot(health_dist)
# 
# ?qplot()
#   
#   head(health_dist,10)
# 
# select_dist <- health_dist[1:5,]
# 
# 
# colnames(select_max)
# head(select_max,10)
# 
# #order_by()
# boxplot(Y1991~State_Name,data = Health_data)
# 
# select_max <- select_max[1:5,]
# 
# qplot(State_Name,max_spend,data = select_max,geom = "barplot")
# 
# nrow(select_max)
# 
# ggplot(select_max,aes(x=max_spend))+
#   geom_histogram()
# 
# require(ggplot2)
# data(package="ggplot2")
# qplot(Type, data=myMovieData , geom="bar", fill=Type)
# 
# 
# ggplot(data=health_dist,
#        aes(x=Y1991)) +
#   geom_boxplot()+
#   facet_grid(~State_Name)
# 
# head(Health_data)
# colnames(selected)



ui <- fluidPage(
    sidebarLayout(
      sidebarPanel(
        selectInput("state","select_state",choices = Health_data$State_Name,selected = "Michigan")
      ),
      mainPanel(
        plotOutput("state_name")
        
      )
    )
  
)

server <- function(input,output){
  
  selected <- reactive( Health_data %>%
    filter(State_Name==input$state))
  output$state_name <-renderPlot(
    selected() %>%
      ggplot(aes(x=State_Name,y=Y1991))+
      geom_boxplot()+
      geom_jitter()
  )
}




shinyApp(ui,server)






