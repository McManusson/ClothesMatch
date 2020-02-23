######################################################################
# Aplicación ClothesMatch para encontrar coincidencias entre prendas #
######################################################################

# Autores: Daniel, Marcos, Isabel y...

source("./backend/pkgs.r") # carga los paquetes y variables de entorno

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("ClothesMatch #ZaraChallenge"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            fileInput("file", 
                      "Sube imagen", 
                      multiple = FALSE,
                      accept = c('.png', '.gif', '.jpg', '.jpeg'),
                      placeholder = "Archivo"),
                      buttonLabel = "Subir"
            ),

        # Show a plot of the generated distribution
        mainPanel(
           h1("Tu imagen:"),
           uiOutput("image"),
           h2("Parecidos:")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$image <- renderUI({
    img(src="prendana.png")
  })
    observeEvent(input$file, {
        infile = input$file
        if(is.null(infile))
            return()
        file.copy(infile$datapath, file.path(place, infile$name))
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
