# ui.R

library(shiny)
library(knitr)
includeRmd <- function(path){
  contents <- paste(readLines(path, warn = FALSE), collapse = '\n')
  html <- knit2html(text = contents, fragment.only = TRUE, options=c("use_xhtml","smartypants","mathjax","highlight_code", "base64_images"))
  Encoding(html) <- 'UTF-8'
  HTML(html)
}

shinyUI ( pageWithSidebar(
    
      headerPanel ("Exploring Unemployment by County in USA, 2009"),
    
      sidebarPanel (
          h3('Input Parameters'),
          h4(' '),
          h4('Select Unimployment Rate and Window Size'),
          sliderInput('unemprate', 'select unemployment rate (%)', value=5, min=0, max=32, step=1,),
          sliderInput('unempwin', 'select unemployment rate window (%)', value=1, min=1, max=5, step=1,),
          h4('Select Number of Counties to Show for the Unemployment Window'),
          numericInput('nct', 'Number of counties to list', 10, min = 0, max = 100, step = 5),
          submitButton("submit"), 
          p('Note: The information of App can be found in the tabpanel of About')
      ),
    
      mainPanel (            
        tabsetPanel(type = "tabs", 
          tabPanel("Window",
                   h3(''),
                   textOutput('note'),
                   h3('An Unimployment Window in Histogram'),
                   plotOutput('hist'),                   
                   h3('Map of Counties in Unemployment Window'),
                   plotOutput('map.unempwin'),                   
                   h3('List of Counties in Unimployment Window'),
                   tableOutput('countywin')), 
          tabPanel("Overall", 
                   h3('An Overal View of Unemployment by County in USA, 2009'),
                   plotOutput('map.unemp')),
          tabPanel("About",                  
                   includeRmd("about.Rmd"))
        )        
      )
      
  )
)