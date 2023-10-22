FROM dart:latest

RUN apt-get update -y \
   && apt-get install -y build-essential libpq-dev git 

COPY . /my_project

WORKDIR /my_project

COPY pubspec.* /my_project/
RUN dart pub global activate conduit
RUN dart pub get

RUN apt-get install -y postgresql-client

# Establecer las variables de entorno para la conexión a la base de datos
ENV DB_HOST=localhost
ENV DB_PORT=5432
ENV DB_NAME=DirectoryAPP
ENV DB_USER=postgres
ENV DB_PASSWORD=Puchy5531

RUN dart run conduit db generate 

# Esperar a que la base de datos esté disponible antes de ejecutar las migraciones
CMD bash -c 'while !</dev/tcp/$DB_HOST/$DB_PORT; do sleep 1; done; dart run conduit db upgrade && dart run ./my_project/bin/main.dart'

# Expose port 8000 to the outside world
EXPOSE 8000