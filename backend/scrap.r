# Inditex Scraper
library(dplyr)
library(jsonlite)

## Zara
uri = "https://www.zara.com/es/" # data-layout="products-category-view"

# Extraemos 
zara_uris = read_html(uri) %>% html_nodes("._category-link-wrapper")
layouts = zara_uris %>% html_attr("data-layout")
scrap_uris = zara_uris[which(layouts == "products-category-view")]

href = scrap_uris %>% html_nodes("a") %>% html_attr("href") %>% na.omit() %>% unique()
data_href = scrap_uris %>% html_nodes("a") %>% html_attr("data-href") %>% na.omit() %>% unique()

final_uris = unique(c(href, data_href)) # los enlaces que se usarán

# ID: autoconstruida
# Nombre: name _item (HREF, URL)
# Precio: .main-price

# Para asegurarnos hemos reducido nuestra consulta a products-category-view
prices = NULL

for(i in final_uris) {
  prices[i] = read_html(i) %>% html_nodes(".main-price") %>% html_attr("data-price")
}
names(prices[lapply(prices, length) > 0])

# Generaremos tres categorías por nosotros mismos: ID, Etiqueta y Tienda

# Páginas: el enfoque menos agresivo posible
for(i in final_uris) {
  pages[[i]] = read_html(i)
}


for(i in final_uris) {
  nombre[i] = read_html(i) %>% html_nodes(".product-media") %>% html_attr("alt") %>% na_if("") %>%  na.omit()
}

for(i in final_uris) {
  uris[i] = read_html(i) %>% html_nodes(".item._item") %>% html_attr("href")
}
product_uris = NULL

for(i in 1:length(pages)) {
  product_uris[[i]] = pages[[i]] %>% html_nodes(".item._item") %>% html_attr("href") %>% unique()
}

product_uris = unlist(product_uris, recursive=FALSE)

prices = NULL
for(i in product_uris) {
  prices[[i]] = read_html(i) %>% html_nodes(".info-section")
}

price = read_html("https://www.zara.com/es/es/hombre-nuevo-l711.html?v1=1444994") %>% html_nodes(".main-price")
uris = read_html("https://www.zara.com/es/es/hombre-nuevo-l711.html?v1=1444994") %>% html_nodes(".item._item") %>% html_attr("href")
nombre = read_html("https://www.zara.com/es/es/hombre-nuevo-l711.html?v1=1444994") %>% html_nodes(".product-media") %>% html_attr("alt") %>% na_if("") %>%  na.omit()

ids = c(1L:nrow(df))