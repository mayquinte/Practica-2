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
        //Datos para el ingreso al servidor de la base de datos
        "userpg",
        "Puchy5531",
        "postgres-db",
        5432,
        "DirectoryAPP");

    ///Crea un objeto "context" que contiene la conexion a la base de datos y el modelo de datos
    context = ManagedContext(dataModel, persistentStore);
  }

  //Rutas junto con el controlador que maneja la logica de la ruta
  @override
  Controller get entryPoint => Router()

    ..route("/status").linkFunction((request) async {
      return Response.ok({"message": "pong"});
    })

    ..route("/directories").link(() => ClientController(context))
    
    ..route("/directories/:c_id").link(() => ClientController(context));
}
