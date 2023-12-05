FROM dart:stable AS build
USER root

RUN apt-get update -y \
   && apt-get install -y build-essential libpq-dev git 

COPY . /my_project

WORKDIR /my_project

# Establece la variable de entorno PUB_CACHE
ENV PUB_CACHE=/path/to/your/pub/cache

RUN dart pub global activate conduit
RUN dart pub get

RUN apt-get install -y postgresql-client

# Instalar PostgreSQL
RUN apt-get install -y postgresql

RUN dart run conduit db generate 

EXPOSE 8888
# Ejecutar las migraciones
CMD bash -c 'dart run conduit db upgrade && conduit serve'
