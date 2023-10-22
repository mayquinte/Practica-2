import 'package:my_project/model/tables.dart';
import 'package:my_project/my_project.dart';

class ClientController extends ResourceController {
  //  gestiona los queries de los clientes
  ClientController(this.context);

  final ManagedContext context;

@Operation.get()
Future<Response> getAllUsuarios(
    {@Bind.query('limit') int limit = 5,
    @Bind.query('offset') int offset = 0}) async {
  try {
    final clientQuery = Query<Client>(context)
      ..fetchLimit = limit
      ..offset = offset;
    final client = await clientQuery.fetch();
    bool clientEmpty = false;
    if (client.isEmpty){
      clientEmpty = true;
      return Response.notFound(body: {"message": "Clients Not Found"});
    } 
    final count = client.length;
    final nextOffset = offset + limit;
    int prevOffset = 0;
    if(offset > 0)
      prevOffset = offset - limit;

    final results = [];
    for (final c in client) {
      results.add({
        'id': c.id,
        'name': c.name,
        'emails': c.email,
      });
    }

    final Map<String, dynamic> responseMap = {
      'count': count,
      'next': clientEmpty == false ? '/directories?limit=$limit&offset=$nextOffset' : null,
      'previous': prevOffset >= 0 ? '/directories?limit=$limit&offset=$prevOffset' : null,
      'results': results,
    };

    return Response.ok(responseMap);
 
  } catch (e) {
    return Response.serverError(body: {"error": e.toString()});
  }
}

  @Operation.post() //crea un cliente en la BD
  Future<Response> createClient(@Bind.body() Client body) async {
    try {
      final query = Query<Client>(context)..values = body;
      final insertedUsuario = await query.insert();
      return Response.ok(insertedUsuario);
    } catch (e) {
      return Response.serverError(body: {"error": e.toString()});
    }
  }


  @Operation.get('c_id') //Muestra un cliente en especifico
  Future<Response> getUserAtIndex(@Bind.path("c_id") int index) async {
    try {
      final clientQuery = Query<Client>(context)
        ..where((u) => u.id).equalTo(index);
      final client = await clientQuery.fetchOne();
      if (client == null)
        return Response.notFound(body: {"message": "Client Not found"});
      return Response.ok(client);
    } catch (e) {
      return Response.serverError(body: {"error": e.toString()});
    }
  }

  @Operation.put('c_id') //actualiza un cliente de la BD por un id
  Future<Response> updateClient(
      @Bind.path("c_id") int index, @Bind.body() Client body) async {
    try {
      final query = Query<Client>(context)
        ..values = body
        ..where((u) => u.id).equalTo(index);
      final updatedUsuario = await query.updateOne();
      if (updatedUsuario == null) {
        return Response.notFound(body: {"message": "Client Not found"});
      }
      return Response.ok(updatedUsuario);
    } catch (e) {
      return Response.serverError(body: {"error": e.toString()});
    }
  }

  @Operation.delete('c_id') //borra un cliente de la BD por id
  Future<Response> deleteUsuario(@Bind.path("c_id") int index) async {
    try {
      final query = Query<Client>(context)..where((u) => u.id).equalTo(index);
      final deletedUsuario = await query.delete();
      if (deletedUsuario == 0) {
        return Response.notFound(body: {"message": "Client Not found"});
      }
      return Response.ok(deletedUsuario);
    } catch (e) {
      return Response.serverError(body: {"error": e.toString()});
    }
  }
}
