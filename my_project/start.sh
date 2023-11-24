#!/bin/bash

# Ejecuta la actualización de la base de datos
dart run conduit db upgrade

# Inicia el servidor
conduit serve