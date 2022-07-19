import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/objectbox.g.dart';
// import 'package:bizpro_app/objectbox.g.dart';

class ObjectBoxDatabase {
 late final Store store;

  /// A Box of emprendimientos.
  late final Box<Usuarios> usuariosBox;
  late final Box<Emprendimientos> emprendimientosBox;
  late final Box<Comunidades> comunidadesBox;
  

  ObjectBoxDatabase._create(this.store) {
    // Add any additional setup code, e.g. build queries.
    usuariosBox = Box<Usuarios>(store);
    emprendimientosBox = Box<Emprendimientos>(store);
    comunidadesBox = Box<Comunidades>(store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBoxDatabase> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore();
    return ObjectBoxDatabase._create(store);
  }
  
}