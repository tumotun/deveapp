library(shiny)


data1 <- read.csv('outcome-of-care-measures.csv')
data <- data1[, -match(c('Provider.Number', 'Address.2', 'Address.3'), names(data1))]
data <- data[,c(1:8, 14,20,26,32,38)]
data$City <- gsub(' +$', '', data$City)

shinyServer(function(input, output) {
  datainput <- reactive({
    if (input$dataset == "All") {
      data
    } else {
      data[data$State == input$dataset, ]
    }
  })
  
  output$list4hearta <- renderPrint({
    data.fin <- datainput()[,c(1:8, 11)]
    if (input$options == 'mor') {
      tar <- grep("Mortality", names(data.fin))
    } else {
      tar <- grep("Readmission", names(data.fin))
    }
    
    data.fin <- data.fin[order(data.fin[, tar]), ]
    data.fin[, tar] <- as.numeric(as.character(data.fin[, tar]))
    thres <- quantile(data.fin[,tar], input$rankpercent/100, na.rm= T)
    result <- data.fin[data.fin[, tar] <= thres , ]
    row.names(result) <- NULL
    q <- complete.cases(result)
    pres <- data.frame(Hospital = result[q,][,1], State = result[q,][4])
    print(pres)
  })
  
  output$list4heartf <- renderPrint({
    data.fin <- datainput()[,c(1:7, 9, 12)]
    if (input$options == 'mor') {
      tar <- grep("Mortality", names(data.fin))
    } else {
      tar <- grep("Readmission", names(data.fin))
    }
    
    data.fin <- data.fin[order(data.fin[, tar]), ]
    data.fin[, tar] <- as.numeric(as.character(data.fin[, tar]))
    thres <- quantile(data.fin[,tar], input$rankpercent/100, na.rm= T)
    result <- data.fin[data.fin[, tar] <= thres, ]
    row.names(result) <- NULL
    q <- complete.cases(result)
    pres <- data.frame(Hospital = result[q,][,1], State = result[q,][4])
    print(pres)
  })
  
  output$list4penu <- renderPrint({
    data.fin <- datainput()[,c(1:7, 10, 13)]
    if (input$options == 'mor') {
      tar <- grep("Mortality", names(data.fin))
    } else {
      tar <- grep("Readmission", names(data.fin))
    }
    
    data.fin <- data.fin[order(data.fin[, tar]), ]
    data.fin[, tar] <- as.numeric(as.character(data.fin[, tar]))
    thres <- quantile(data.fin[,tar], input$rankpercent/100, na.rm= T)
    result <- data.fin[data.fin[, tar] <= thres, ]
    row.names(result) <- NULL
    q <- complete.cases(result)
    pres <- data.frame(Hospital = result[q,][,1], State = result[q,][4])
    print(pres)
  })
  
#   output$stateselect <=- renderUI({
#     selectInput("dataset", "State:", as.list(c("All", sort(unique(data$State)))))
#   })
})
