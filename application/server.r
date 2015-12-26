server <- function(input, output) {
    
    require('devtools')
    require('rCharts')
    require('shiny')
    require("quantmod")
    require("TTR")
    require("stringr")
    require('lubridate')
    
    data.setup<-function(data,loc='yahoo',start.date=Sys.Date()-months(1),
                         end.date=Sys.Date()) {
        getSymbols(data,src=loc)
        x<-as.data.frame(window(get(data),
                                start=as.character(start.date),
                                end=as.character(end.date)))
        x$dates<-row.names(x)
        colnames(x)<-c('Open','High','Low','Close','Volume','Adjusted','Dates')
        x<-x[c(7,1,2,3,4,5,6)]
        rownames(x)<-NULL
        return(return(x))
    }
    
    data<-data.setup('FP.PA',start.date=Sys.Date()-months(12))
    
    plot<-Highcharts$new()
    plot$series(data=data$Low,name='Low',color='brown')
    plot$series(data=data$High,name='High',color='green')
    plot$series(data=data$Open,name='Open',color='blue')
    plot$series(data=data$Close,name='Close',color='grey')
    plot$xAxis(categories=data$Dates,type='date')
    plot$chart(zoomType='x')
    plot
    
    
    output$plot <- renderPlot({
        plot(data$Open, data$Close)
    })
    
    output$info <- renderText({
        paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
    })
}