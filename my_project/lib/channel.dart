import 'package:my_project/my_project.dart';
import 'package:conduit_postgresql/conduit_postgresql.dart';
import '../controller/ClientController.dart';

class MyProjectChannel extends ApplicationChannel {
  late ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

      final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
      final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
        ///Crea un objeto "context" que contiene la conexion a la base de datos y el modelo de datos
        //Datos para el ingreso al servidor de la base de datos
        "postgres",
        "Puchy5531",
        "localhost",
        5432,
        "DirectoryAPP"); //definido en las "clases"

    context = ManagedContext(dataModel, persistentStore);
  }

  //colocar aqui las rutas junto con su controlador que maneja la logica de la ruta
  @override 
  Controller get entryPoint => Router()

    ..route("/status").linkFunction((request) async {
      return Response.ok({"message": "pong"});
    })

    ..route("/directories").link(() => ClientController(context))

    ..route("/directories/:c_id").link(() => ClientController(context));
}