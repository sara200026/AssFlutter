import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'taskModel.dart';

class DbHalper {
  DbHalper._();

  static DbHalper dbHalper = DbHalper._();
  Database database;
  static final String databaseName = 'tasksDB.db';
  static final String tableName = 'tasks';
  static final String taskIdColumnName = 'id';
  static final String taskNameColumnName = 'name';
  static final String taskIsCompleteColumnName = 'isComplete';
  static final String colTitle = 'title';

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
      String path = join(databasesPath, databaseName);
      Database database =
          await openDatabase(path, version: 1, onCreate: (db, version) {
        db.execute('''CREATE TABLE $tableName(
      $taskIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
      $taskNameColumnName TEXT NOT NULL,
   
      $taskIsCompleteColumnName INTEGER
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
          where: '$taskIsCompleteColumnName=?', whereArgs: [iscomplete]);

      return res;
    } on Exception catch (e) {
      print(e);
    }
  }

  updateTask(Task task) async {
    try {
      database = await initDataBase();
      int res = await database.update(tableName, task.toJson(),
          where: '$taskIdColumnName=?', whereArgs: [task.taskId]);
      print(res);
    } on Exception catch (e) {
      print(e);
    }
  }

  deleteTask(int id) async {
    try {
      database = await initDataBase();
      int res = await database
          .delete(tableName, where: '$taskIdColumnName=?', whereArgs: [id]);
      print(res);
    } on Exception catch (e) {
      print(e);
    }
  }
}

// import 'package:lec2/taskModel.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DBHelper {
//   DBHelper._();
//   static DBHelper dbHelper = DBHelper._();
//   static final String databasename = 'taskDb.db';
//   static final String tablename = 'task';
//   static final String tableIdColumnname = 'id';
//   static final String tasknameCOlumnname = 'name';
//   static final String taskisComplete = 'isComlete';

//   Database database;
//   Future<Database> initDatabade() async {
//     if (database == null) {
//       return await createDataBase();
//     } else {
//       return database;
//     }
//   }

//   Future<Database> createDataBase() async {
//     try {
//       var databasesPath = await getDatabasesPath();
//       // String path = databasesPath + '/tasksDb.db';
//       String path = join(databasesPath, databasename);
//       Database database = await openDatabase(
//         path,
//         version: 1,
//         onCreate: (db, version) {
//           db.execute('''CREATE TABLE $tablename(
//             $tableIdColumnname INTEGER PRIMARY KEY AUTOINCREMENT,
//             $tasknameCOlumnname TEXT NOT NULL,
//             $taskisComplete INTEGER
//           )''');
//         },
//       );
//       return database;
//     } on Exception catch (e) {
//       print(e);
//     }
//   }

//   insertNewTask(Task task) async {
//     try {
//       database = await initDatabade();
//       int x = await database.insert(tablename, task.toJson());
//       print(x);
//     } on Exception catch (e) {
//       print(e);
//     }
//   }

//   Future<List<Map>> selectAllTas() async {
//     try {
//       database = await initDatabade();
//       List<Map> result = await database.query(tablename);
//       print(result);
//     } on Exception catch (e) {
//       print(e);
//     }
//   }

//   Future<Map> spacificTask(String name) async {
//     try {
//       database = await initDatabade();
//       List<Map> result = await database
//           .query(tablename, where: '$tasknameCOlumnname=?', whereArgs: [name]);
//       print(result);
//     } on Exception catch (e) {
//       print(e);
//     }
//   }

//   updateTask(Task task) async {
//     try {
//       database = await initDatabade();
//       int result = await database.update(tablename, task.toJson(),
//           where: '$tasknameCOlumnname=?', whereArgs: [task.taskName]);
//       print(result);
//     } on Exception catch (e) {
//       print(e);
//     }
//   }

//   deleteTask(Task task) async {
//     try {
//       database = await initDatabade();
//       int resule = await database.delete(tablename,
//           where: '$tasknameCOlumnname=?', whereArgs: [task.taskName]);
//       print(resule);
//     } on Exception catch (e) {
//       print(e);
//     }
//   }
// }
