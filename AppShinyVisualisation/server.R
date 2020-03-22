
library(shiny)
library(ggplot2)
library(dplyr)
library(magrittr)
library(shinydashboard)
library(readr)
library(rgrs)


data_weather <- read_csv("Données_météo.csv")
data_weather$country <- as.factor(data_weather$country)
data_weather$name <- as.factor(data_weather$name)
data_weather$continent <- as.factor(data_weather$continent)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    #La partie de Nuage de Points*****************
    output$graph_continent <- renderPlot({
        
        data_weather %>%
            filter(temp < input$bins) %>%
            ggplot(aes(x=temp, y=continent)) + 
            geom_point() +
            ggtitle("Température par Continent") +
            xlab("Température °C") +
            ylab("Continent")
        
    })
    output$graph_country <- renderPlot({
        
        data_weather %>%
            filter(temp < input$bins) %>%
            ggplot(aes(x=temp, y=country)) + 
            geom_point() + ggtitle(input$title) +
            ggtitle("Température par Pays") +
            xlab("Température °C") +
            ylab("Pays")
        
    })
    
    #La partie Histogramme***********************
    #Histogramme Par Continent 
    by_continent <- group_by(data_weather, continent)
    dt_continent<-summarise(by_continent, temp = mean(temp))
    hist_continent <- ggplot(dt_continent, aes(continent, temp)) + geom_col(fill="blue") +
            ggtitle("Température moyenne par Continent") +
            xlab("Continent") +
            ylab("Température °C")
    
    #Histogramme Par Pays 
    by_country <- group_by(data_weather, country)
    dt_country <- summarise(by_country, temp = mean(temp))
    hist_country <- ggplot(dt_country, aes(country, temp)) + geom_col(fill="blue") +
        ggtitle("Température moyenne par Pays") +
        xlab("Pays") +
        ylab("Température °C")
    
    #On fait une virification sur le champ de selection pour choisir le graph à afficher 
    output$continent_histogramme <- renderPlot({
        sellection<- input$dataset
        if (sellection == 'Continent'){
            hist_continent
        }else{
            hist_country
        }
        
        })
    
})