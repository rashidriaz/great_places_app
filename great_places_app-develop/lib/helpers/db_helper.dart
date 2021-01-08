import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
class DBHelper{
  static Future<sql.Database> database() async{
    final dbPath = await sql.getDatabasesPath();
    final sqlDB = await sql.openDatabase(path.join(dbPath, "places.db",), onCreate: (db, currentVersion){
      return db.execute("CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)");
    }, version: 1);
    return sqlDB;
  }
  static Future<void> insert(String table, Map<String, Object> data) async{
    final sqlDB = await DBHelper.database();
    await sqlDB.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);

  }

  static Future<List<Map<String, dynamic>>> getData(String table) async{
    final sqlDB = await DBHelper.database();
    return await sqlDB.query(table);
  }
}