FROM dart:latest

RUN apt-get update -y \
   && apt-get install -y build-essential libpq-dev git 

COPY . /my_project

WORKDIR /my_project

COPY pubspec.* /my_project/
RUN dart pub global activate conduit
RUN dart pub get

# Copy app source code and AOT compile it.
COPY . .

# Ensure packages are still up-to-date if anything has changed
RUN dart pub get --offline
RUN dart compile exe bin/server.dart -o bin/server

# Build minimal serving image from AOT-compiled `/server` and required system
# libraries and configuration files stored in `/runtime/` from the build stage.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/

RUN apt-get install -y postgresql-client

# Instalar PostgreSQL
RUN apt-get install -y postgresql

RUN dart run conduit db generate 

EXPOSE 8888
CMD ["/app/bin/server"]
# Ejecutar las migraciones
CMD bash -c 'dart run conduit db upgrade && conduit serve'
