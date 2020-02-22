# Modelo MNIST Fashion
library(keras)
library(tensorflow)
library(tidyr)
library(ggplot2)

# carga de la tabla
fashion_mnist = dataset_fashion_mnist()

# etiquetas
c(train_images, train_labels) %<-% fashion_mnist$train
c(test_images, test_labels) %<-% fashion_mnist$test

# configuración de etiquetas por números (en castellano e inglés)
class_names = c('T-shirt/top',
                'Trouser',
                'Pullover',
                'Dress',
                'Coat', 
                'Sandal',
                'Shirt',
                'Sneaker',
                'Bag',
                'Ankle boot')

class_names_es = c('Camiseta',
                'Trouser',
                'Pullover',
                'Dress',
                'Coat', 
                'Sandal',
                'Shirt',
                'Deportivo',
                'Bolsa',
                'Botín')

# preprocesado de los datos
image_1 <- as.data.frame(train_images[1, , ])
colnames(image_1) <- seq_len(ncol(image_1))
image_1$y <- seq_len(nrow(image_1))
image_1 <- gather(image_1, "x", "value", -y)
image_1$x <- as.integer(image_1$x)

ggplot(image_1, aes(x = x, y = y, fill = value)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "black", na.value = NA) +
  scale_y_reverse() +
  theme_minimal() +
  theme(panel.grid = element_blank())   +
  theme(aspect.ratio = 1) +
  xlab("") +
  ylab("")

# escalado de imágenes
train_images <- train_images / 255
test_images <- test_images / 255

# configuración de capas para el modelo
model <- keras_model_sequential()
model %>%
  layer_flatten(input_shape = c(28, 28)) %>%
  layer_dense(units = 128, activation = 'relu') %>%
  layer_dense(units = 10, activation = 'softmax')

# compilación
model %>% compile(
  optimizer = 'adam', 
  loss = 'sparse_categorical_crossentropy',
  metrics = c('accuracy')
)

# entrenamiento del modelo
model %>% fit(train_images, train_labels, epochs = 5, verbose = 2)

# comprobar la precisión
score <- model %>% evaluate(test_images, test_labels, verbose = 0)

cat('Test loss:', score$loss, "\n")
cat('Test accuracy:', score$acc, "\n")