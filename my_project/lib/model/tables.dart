import 'package:my_project/my_project.dart';

//MODELO DE DATOS DE LA BD, tiene que conincidir con la estructura de la base de datos
class Client extends ManagedObject<_Client>
    implements
        _Client {} // _Client es la tabla de la bd la clase Client implementa esta tabla

@Table(name: "Client")
class _Client {
  //tabla de la BD _Client
  @primaryKey
  late int? id;

  @Column()
  late String? name;

  @Column(nullable: false)
  late String email; 

}
