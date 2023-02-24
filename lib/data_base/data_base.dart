import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:prueba/data_base/temperaturas.dart';

class DisDataBase {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'dispositivoss.db'),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE dispositivoss (id INTEGER PRIMARY KEY,nombre TEXT,codigo TEXT,email TEXT)");
    }, version: 1);
  }

  static Future<Future<int>> insert(Dispositivos dispositivoss) async {
    Database database = await _openDB();

    return database.insert("dispositivoss", dispositivoss.toMap());
  }

  static Future<Future<int>> delete(Dispositivos dispositivoss) async {
    Database database = await _openDB();

    return database
        .delete("dispositivoss", where: "id=?", whereArgs: [dispositivoss.id]);
  }

  static Future<Future<int>> update(Dispositivos dispositivoss) async {
    Database database = await _openDB();

    return database.update("dispositivoss", dispositivoss.toMap(),
        where: "id=?", whereArgs: [dispositivoss.id]);
  }

  static Future<dynamic> dispositovo() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> temperaturaMap =
        await database.query("dispositivoss");

    return List.generate(
        temperaturaMap.length,
        (i) => Dispositivos(
              id: temperaturaMap[i]['id'],
              Nombre: temperaturaMap[i]['nombre'],
              Codigo: temperaturaMap[i]['codigo'],
              Email: temperaturaMap[i]['email']
            ));
  }

  static Future<void> insertar2(Dispositivos dispositivoss) async {
    Database database = await _openDB();
    var resultado = await database.rawInsert(
        "INSERT INTO temperaturas (id, fecha, temperatura, email)"
        " VALUES (${dispositivoss.id},${dispositivoss.Nombre},${dispositivoss.Codigo},${dispositivoss.Email})");
  }
}
