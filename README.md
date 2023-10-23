# Practica-2.C - Computación en la nube

Implementación de un servicio web desarrollado en Dart usando el framework Conduit.
## Integrantes:
- [Jian Liu](https://github.com/JianLiu08)
- [Mayra Ramírez](https://github.com/mayquinte)

## Instalación
```bash
# Clonar el repositorio de GitHub
$ git clone https://github.com/mayquinte/Practica-2.git

# Ingresar a la carpeta del proyecto
$ cd Practica-2
/Practica-2$ cd my_project

# Crear todo para que el servicio este disponible
/Practica-2/my_project$ docker compose up -d
```

## Endpoints del servicio web
- GET http://{Direccion}:8888/status -> Responde simplemente pong
- GET http://{Direccion}:8888/directories -> Lista todos los objetos
- POST http://{Direccion}:8888/directories -> Crea un objeto
- GET http://{Direccion}:8888/directories/{id} -> Muestra un objeto
- PUT http://{Direccion}:8888/directories/{id} -> Actualiza un objeto
- DELETE http://{Direccion}:8888/directories/{id} -> Eliminar un objeto

## Esquema de un objeto
```bash
{
   "name": "Mayra Ramírez",
   "email": "mvramirez@ucab.edu.ve"
}
```


