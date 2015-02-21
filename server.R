library(shiny)
#Load Baby Name Data
#This data was downloaded from http://www.ssa.gov/oact/babynames/limits.html
library(data.table)
Names<-fread("Names.csv")
setkey(Names,first,gender)
#Function that computes the probablity of a name being a boy's name given 
#the approximate year of birth.
BoyProb<-function (n,p,q) {
        n=tolower(n)
        b<-Names[J(n,"M"),sum(instances),by=year]
        g<-Names[J(n,"F"),sum(instances),by=year]
        boy<-b[year>p&year<q,sum(V1)]
        girl<-g[year>p&year<q,sum(V1)]
        
        if (length(boy)==0&length(girl)==0)
        {"NA"}   
        else if (length(boy)==0) 
        {0}
        else if (length(girl)==0)
        {1}
        else{boy/(boy+girl)}
}
#Shiny Part
shinyServer(function(input, output) {  
        output$probability <- renderText({
                n    <- input$name
                p    <- as.numeric(input$min_year)
                q    <- as.numeric(input$max_year)
               
                x=BoyProb(n,p,q)
                if (n==""){
                        print("Please enter a first name")
                }
                else if (p<1880|q<1880){
                        print("Data only goes back to 1880")
                }
                else if (p>2013|q>2013){
                        print("Most current data is 2013")
                }
                else if (p>q){
                        print("The minimum year must be less than the maximium year")
                }
                else {
                        print(paste("The probablity of",n,", a USA-born person, 
                        whose birthdate lies between",p,"and",q,", of being male 
                                    is",round(x,2)))
                }

        })
})