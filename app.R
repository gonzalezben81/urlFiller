library(shiny)

ui <- fluidPage(
  textInput("name", "Name"),
  numericInput("age", "Age", 25),
  textInput("url","URL",placeholder = "www.gonzostats.us"),
  verbatimTextOutput(outputId = "urlText")
)

server <- function(input, output, session) {
  observe({
    query <- parseQueryString(session$clientData$url_search)
    if (!is.null(query[['name']])) {
      updateTextInput(session, "name", value = query[['name']])
    }
    if (!is.null(query[['age']])) {
      updateNumericInput(session, "age", value = query[['age']])
    }
  })
  
  observe({
    
    querytwo <- parseQueryString(session$clientData$url_search)
    if (!is.null(querytwo[["url"]])){
    updateTextInput(session,"url",value = querytwo[['url']])
    }
  })
  
  
  output$urlText <- renderText({
    paste(sep = "",
          "protocol: ", session$clientData$url_protocol, "\n",
          "hostname: ", session$clientData$url_hostname, "\n",
          "pathname: ", session$clientData$url_pathname, "\n",
          "port: ",     session$clientData$url_port,     "\n",
          "search: ",   session$clientData$url_search,   "\n"
    )
  })
  
}

shinyApp(ui, server)