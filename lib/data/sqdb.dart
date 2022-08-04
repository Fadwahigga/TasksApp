// ignore: depend_on_referenced_packages
// ignore_for_file: avoid_print, depend_on_referenced_packages, duplicate_ignore

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;

  /// اتحقق من انشاء الداتا بيز
  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'tasksapp.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    // كل ما اعدل بغير الversion و بطبق ال upgrade
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) async {
    print("Upgrad=======================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE "tasks" (
  "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  "task" TEXT NOT NULL 

)
''');
//اتاكد من انشاء الدالة
    print("CREATE DATABASE AND TABLE ========================");
  }

// SELECT
  read(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

//INSERT
  insert(String table, Map<String, Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, values);
    return response;
  }

//UPDATE
  update(String table, Map<String, Object?> values, String mywhere) async {
    Database? mydb = await db;
    int response = await mydb!.update(table, values, where: mywhere);
    return response;
  }

//DELETE
  delete(String table, String mywhere) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table, where: mywhere);
    return response;
  }

  mydeletedatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'tasksapp.db');
    await deleteDatabase(path);
  }
}
