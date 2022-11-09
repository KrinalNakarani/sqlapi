import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  Database? database;

  static final ints = DBHelper._();

  DBHelper._() {}

  Future<Database?> initDB() async {
    if (database != null) {
      return database;
    } else {
      return await createDB();
    }
  }

  Future<Future<Database>> createDB() async {
    Directory databasePath = await getApplicationDocumentsDirectory();
    String path = join(databasePath.path, 'abcd.db');
    return openDatabase(path, version: 1, onCreate: (db, version) {
      String query =
          "CREATE TABLE type (mid INTEGER PRIMARY KEY AUTOINCREMENT,id INTEGER,postId INTEGER,name TEXT,email TEXT,body TEXT)";
      db.execute(query);
    });
  }

  void insertDB(
      {int? id,
      int? postId,
      String? name,
      String? email,
      String? body}) async {

    database = await initDB();
    database!.insert("type", {"id": id,
      "postId": postId,
      "name": name,
      "email": email,
      "body": body
    });
  }

  void updateDB(
      {int? id, int? postId, String? name, String? email, String? body}) async {
    database = await initDB();
    database!.update(
        "type",
        {"id": id,
          "postId": postId,
          "name": name,
          "email": email,
          "body": body
        },
        where: "id = $id");
  }

  void deleteDB(int id) async {
    database = await initDB();
    database!.delete("type", where: "id = $id");
  }

  Future<List<Map<String, Object?>>> readDB() async {
    database = await initDB();
    String qu = "SELECT * FROM type";

    return database!.rawQuery(qu);
  }
}
