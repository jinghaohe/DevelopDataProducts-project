# server.R

library(shiny)
library(ggplot2)
library(maps)
library(Hmisc)

data(unemp)
data(county.fips)

county.fips$polyname<-as.character(county.fips$polyname)
county.fips$state<-sapply(strsplit(county.fips$polyname,","),function(x){capitalize(unlist(x)[1])})
county.fips$county<-sapply(strsplit(county.fips$polyname,","),function(x){capitalize(unlist(x)[2])})
unemp<-merge(county.fips,unemp,by="fips")[,c(-2)]

shinyServer(
  
  function(input, output) { 
            
    output$hist <- renderPlot({ 
        v_winlft <- input$unemprate-input$unempwin
        v_winrgt <- input$unemprate
        windat <- data.frame(vwin=c(v_winlft, v_winrgt))
        ggplot(unemp,aes(x=unemp)) + geom_histogram(color="white",fill="blue") +
                                     geom_vline(data=windat,aes(xintercept=vwin),color="red") +
                                     theme_bw() +
                                     labs(x="Unemployment Rate (%)" ) + labs(y="Number of Counties") +
                                     labs(title="Histogram")
    })       

     output$map.unempwin <- renderPlot({
       v_winlft <- input$unemprate-input$unempwin
       v_winrgt <- input$unemprate
       indx <- unemp$unemp>=v_winlft & unemp$unemp<=v_winrgt 
       colorselect <- c("#F1EEF6", "#980043") 
       unemp$colorBuckets <- as.numeric(indx) + 1
       colorsmatched <- unemp$colorBuckets[match(county.fips$fips, unemp$fips)]     
       map("county", col=colorselect[colorsmatched], fill=TRUE, resolution=0, lty=1)
       title("Counties of Unemployment in the Selected Window, 2009")
     })    
        
    output$countywin <- renderTable({
          v_winlft <- input$unemprate-input$unempwin
          v_winrgt <- input$unemprate
          indx <- unemp$unemp>=v_winlft & unemp$unemp<=v_winrgt           
          indxsort <- unlist(sort(unemp$unemp[indx],decreasing=TRUE,index.return=TRUE)[2])
          unempwin <- unemp[indx,][indxsort,c(2,3,5)]
          print(unempwin[1:input$nct,],row.names=FALSE)
      
    }) 
        
    output$map.unemp <- renderPlot({
      colors <- c("#F1EEF6", "#D4B9DA", "#C994C7", "#DF65B0", "#DD1C77", "#980043")
      unemp$colorBuckets <- as.numeric(cut(unemp$unemp, c(0, 2, 4, 6, 8, 10, 100)))
      colorsmatched <- unemp$colorBuckets[match(county.fips$fips, unemp$fips)] 
      map("county", col=colors[colorsmatched], fill=TRUE, resolution=0, lty=0)
      map("state", col="white", fill=FALSE, add=TRUE, lty=1, lwd=0.2)
      leg.txt <- c("<2%", "2-4%", "4-6%", "6-8%", "8-10%", ">10%")
      legend("bottomright", leg.txt, horiz = FALSE, fill = colors)      
    })
    
    
  }

)