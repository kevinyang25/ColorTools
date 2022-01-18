library(shiny)
library(base64enc)
library(colourpicker)
source("PopColor.R")
source("CCC.R")
source("Sphere.R")
ui <- navbarPage(
    title = "Color Tools",
    tabPanel("Top Color",
             fluidPage(
                 sidebarLayout(
                     sidebarPanel(
                         fileInput(
                             "image",
                             h3("Upload image here"),
                             accept = c("image/jpg", "image/png")
                         ),
                         sliderInput(
                             "bins",
                             h3("Top X Colors"),
                             min = 1,
                             max = 25,
                             value = 10
                         ),
                         checkboxInput("removetop1",
                                       label = "Remove Top Color",
                                       value = FALSE)
                     ),
                     mainPanel(uiOutput("initialimage"),
                               plotOutput("popPlot"))
                 )
             )),
    tabPanel("Color Clusters",
             fluidPage(
                 sidebarLayout(
                     sidebarPanel(
                         fileInput(
                             "image2",
                             h3("Upload image here"),
                             accept = c("image/jpg", "image/png")
                         ),
                         sliderInput(
                             "bins2",
                             h3("Number of Clusters"),
                             min = 1,
                             max = 25,
                             value = 10
                         )
                     ),
                     mainPanel(
                         uiOutput("initialimage2"),
                         plotOutput("clusters"),
                         h4(
                             "*There may be duplicate colors depending on the number of clusters selected"
                         )
                     )
                 )
             )),
    tabPanel("Spherical Color Highlighter",
             fluidPage(
                 sidebarLayout(
                     sidebarPanel(
                         fileInput(
                             "image3",
                             h3("Upload image here"),
                             accept = c("image/jpg","image/png")
                         ),
                         radioButtons(
                             "filetype",
                             h3("File type"),
                             choices = list(
                                 ".jpg/.jpeg"=1,
                                 ".png"=2
                             )
                         ),
                         colourInput("center",
                                     h3("Input color center here"),
                                     returnName = TRUE),
                         sliderInput(
                             "radius",
                             h3("Radius size"),
                             min = 0,
                             max = 255,
                             value = 0
                         ),
                         selectInput(
                             "highlight",
                             label = h3("Select highlight color"),
                             choices = list(
                                 "Red",
                                 "Green",
                                 "Blue",
                                 "Yellow",
                                 "Cyan",
                                 "Magenta",
                                 "White",
                                 "Black"
                             )
                         )
                     ),
                     mainPanel(
                         uiOutput("initialimage3"),
                         plotOutput("Sphere"),
                         h4("Number of highlighted pixels:"),
                         h1(textOutput("numPix")),
                         h4("Proportion of image highlighted:"),
                         h1(textOutput("fracPix"))
                     )
                 )
             ))
)
server <- function(input, output) {
    base64a <- reactive({
        inFile <- input[["image"]]
        if (!is.null(inFile)) {
            dataURI(file = inFile$datapath,
                    mime = c("image/jpg", "image/png"))
        }
    })
    
    output[["initialimage"]] <- renderUI({
        if (!is.null(base64a())) {
            tags$div(tags$img(src = base64a(), width = "100%"),
                     style = "width: 400px;")
        }
    })
    
    output$popPlot <-
        renderPlot({
            validate(
                need(input$image$datapath,"Please upload a jpg or png image!")
            )
            maxColor(input$image$datapath, input$bins, input$removetop1)
            })
    
    base64b <- reactive({
        inFile <- input[["image2"]]
        if (!is.null(inFile)) {
            dataURI(file = inFile$datapath,
                    mime = c("image/jpg", "image/png"))
        }
    })
    
    output[["initialimage2"]] <- renderUI({
        if (!is.null(base64b())) {
            tags$div(tags$img(src = base64b(), width = "100%"),
                     style = "width: 400px;")
        }
    })
    
    output$clusters <-
        renderPlot({
            validate(
                need(input$image2$datapath,"Please upload a jpg or png image!")
            )
            kcolor(input$image2$datapath, input$bins2)
            })
    
    base64c <- reactive({
        inFile <- input[["image3"]]
        if (!is.null(inFile)) {
            dataURI(file = inFile$datapath,
                    mime = c("image/jpg", "image/png"))
        }
    })
    
    output[["initialimage3"]] <- renderUI({
        if (!is.null(base64c())) {
            tags$div(tags$img(src = base64c(), width = "100%"),
                     style = "width: 400px;")
        }
    })
    output$Sphere<-renderPlot({
        validate(
            need(input$image3$datapath,"Please upload a jpg or png image!")
        )
        sphereHighlighter(input$image3$datapath,input$filetype,input$center,input$radius,input$highlight)
        })
    output$numPix<-renderText({
        validate(
            need(input$image3$datapath,"Please upload a jpg or png image!")
        )
        sphereHighlighter(input$image3$datapath,input$filetype,input$center,input$radius,input$highlight)$pixel.count
        })
    output$fracPix<-renderText({
        validate(
            need(input$image3$datapath,"Please upload a jpg or png image!")
        )
        sphereHighlighter(input$image3$datapath,input$filetype,input$center,input$radius,input$highlight)$img.fraction
        })
}
shinyApp(ui = ui, server = server)
