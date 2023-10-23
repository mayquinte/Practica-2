FROM dart:latest

RUN apt-get update -y \
   && apt-get install -y build-essential libpq-dev git 

COPY . /my_project

WORKDIR /my_project

COPY pubspec.* /my_project/
RUN dart pub global activate conduit
RUN dart pub get

RUN apt-get install -y postgresql-client

# Instalar PostgreSQL
RUN apt-get install -y postgresql

# Establecer las variables de entorno para la conexión a la base de datos
#ENV DB_HOST=postgres-db
#ENV DB_PORT=5432
#ENV DB_NAME=DirectoryAPP
#ENV DB_USER=userpg
#ENV DB_PASSWORD=Puchy5531

RUN dart run conduit db generate 

# Esperar a que la base de datos esté disponible antes de ejecutar las migraciones
CMD bash -c 'dart run conduit db upgrade && conduit serve'
# Expose port 8000 to the outside world
EXPOSE 8888