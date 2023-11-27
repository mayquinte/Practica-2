# Usa la imagen de Dart oficial desde Docker Hub
FROM dart:latest

# Actualiza e instala cualquier paquete necesario
RUN apt-get update -y \
   && apt-get install -y build-essential libpq-dev git 

# Copia tu aplicación al contenedor
COPY . /my_project

# Cambia al directorio de tu aplicación
WORKDIR /my_project

# Obtiene las dependencias de tu aplicación
COPY /Practica-2/my_project/pubspec.yaml /my_project/
RUN dart pub global activate conduit
RUN dart pub get

# Instala PostgreSQL
RUN apt-get install -y postgresql-client
RUN apt-get install -y postgresql

# Genera las migraciones
RUN dart run conduit db generate 

# Haz que el script sea ejecutable
RUN chmod +x start.sh

# Usa el script para iniciar tu aplicación
CMD ["./start.sh"]

# Expone el puerto 8888
EXPOSE 8888