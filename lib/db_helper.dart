import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'taskModel.dart';

class DbHalper {
  DbHalper._();

  static DbHalper dbHalper = DbHalper._();
  Database database;
  static final String dbName = 'tasksDB.db';
  static final String tableName = 'tasks';
  static final String idColumnName = 'id';
  static final String taskNameColumnName = 'name';
  static final String isCompleteColumnName = 'isComplete';
  static final String title = 'title';

  Future<Database> initDataBase() async {
    if (database == null) {
      return await createDataBase();
    } else {
      return database;
    }
  }

  Future<Database> createDataBase() async {
    try {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, dbName);
      Database database =
          await openDatabase(path, version: 1, onCreate: (db, version) {
        db.execute('''CREATE TABLE $tableName(
      $idColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
      $taskNameColumnName TEXT NOT NULL,
   
      $isCompleteColumnName INTEGER
      )''');
      });
      return database;
    } on Exception catch (e) {
      print(e);
    }
  }

  insertNewTasks(Task task) async {
    try {
      database = await initDataBase();
      int x = await database.insert(tableName, task.toJson());
      print(x);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Map>> selectAllTasks() async {
    try {
      database = await initDataBase();
      List<Map> reslut = await database.query(tableName);
      print(reslut);
      return reslut;
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Map>> selectSpecificTasks(int iscomplete) async {
    try {
      database = await initDataBase();
      List<Map> res = await database.query(tableName,
          where: '$isCompleteColumnName=?', whereArgs: [iscomplete]);

      return res;
    } on Exception catch (e) {
      print(e);
    }
  }

  updateTask(Task task) async {
    try {
      database = await initDataBase();
      int res = await database.update(tableName, task.toJson(),
          where: '$idColumnName=?', whereArgs: [task.taskId]);
      print(res);
    } on Exception catch (e) {
      print(e);
    }
  }

  deleteTask(int id) async {
    try {
      database = await initDataBase();
      int res = await database
          .delete(tableName, where: '$idColumnName=?', whereArgs: [id]);
      print(res);
    } on Exception catch (e) {
      print(e);
    }
  }
}
