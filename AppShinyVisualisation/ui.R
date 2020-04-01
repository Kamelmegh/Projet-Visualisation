#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shinydashboard)
library(readr)

dashboardPage(skin = "green",
    dashboardHeader(title = "Dashbord"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Données Météo", tabName = "data", icon = icon(name="fa-align-justify",class = "far fa-align-justify", lib = "font-awesome")),
            menuItem("Nuage de Point", tabName = "nuagepoint", icon = icon(name="fa-chart-line",class = "far fa-chart-line", lib = "font-awesome")),
            menuItem("Histogramme", tabName = "histogramme", icon = icon(name="fa-chart-bar",class = "fal fa-chart-bar", lib = "font-awesome"))
        )
    ),
    dashboardBody(
        tabItems(
            #Tab Données Météo
            tabItem(tabName = "data",
                fluidRow(
                    dataTableOutput("dataweather")
                )
            ),
            
            # Tab Nuage de Point
            tabItem(tabName = "nuagepoint",
                # Boxes need to be put in a row (or column)
                fluidRow(
                    box(
                        title = "Nuage de Point", status = "primary", solidHeader = TRUE,width =8,
                        collapsible = TRUE,
                        plotOutput("graph_continent", height = 250)
                    ),
                    box(
                        title = "Paramètres", status = "info", solidHeader = TRUE, width =4,
                        #"Box content here", br(), "More box content",
                        sliderInput("bins", "Température :", 1, 50, value = c(15, 30)),
                        textInput("text", "Saisissez votre description :")
                    ),
                    box(
                        title = "Nuage de Point", status = "primary", solidHeader = TRUE,width =8,
                        collapsible = TRUE,
                        plotOutput("graph_country", height = 250)
                    ),
                    box(
                        title = "Description", status = "info", solidHeader = TRUE, width =4,
                        textOutput("description")
                    ),
                )
            ),
            
            # Tab Histogramme
            tabItem(tabName = "histogramme",
                    
                fluidRow(
                    box(
                        selectInput('dataset', "Choix d'une echelle ", c('Pays', 'Continent')), width =3
                ),
                box(
                    title = "Histogramme", status = "primary", solidHeader = TRUE, width =8,
                    collapsible = TRUE,
                    plotOutput("continent_histogramme", height = 300)
                )
                )
                    
            )
        )
    )
)