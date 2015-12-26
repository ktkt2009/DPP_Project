library(shiny)


ui <- basicPage(
    
    plotOutput("plot", click = "plot_click"),
    verbatimTextOutput("info")
)
