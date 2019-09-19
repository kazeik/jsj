import 'package:sqflite/sqflite.dart';
import 'package:quiver/strings.dart';

import 'Utils.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-19 16:57
 * 类说明:
 */

class DbUtils {
  static DbUtils get instance => _getInstance();
  static DbUtils _instance;

  Database db;
  String path;

  static DbUtils _getInstance() {
    if (_instance == null) {
      _instance = new DbUtils._internal();
    }
    return _instance;
  }

  //初始化
  DbUtils._internal() {
    _initDb();
  }

  _initDb() async {
    var databasesPath = await getDatabasesPath();
    path = databasesPath + 'jsj.db';

    Utils.logs("path = $path");

    //根据数据库文件路径和数据库版本号创建数据库表
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE loginTable (
            userId INTEGER PRIMARY KEY,
            avatar TEXT,
            phone TEXT,
            isCurrent REAL,
            cookieKey TEXT,
            cookieValue TEXT)
          ''');
    });
  }

  getPath() => path;

  Future<Database> getDb() async {
    if (db == null) {
      db = await openDatabase(path);
    }
    return db;
  }

  Future<int> insertData(String sql) async {
    getDb();
    int id = -1;
    await db.transaction((txn) async {
      id = await txn.rawInsert(sql);
    });
    db.close();
    return id;
  }

  Future<int> deleteData(String sql) async {
    getDb();
    int id = -1;
    id = await db.rawDelete(sql);
    await db.close();
    return id;
  }

  Future<int> updateData(String sql) async{
    getDb();
    int id = await db.rawUpdate(sql);
    await db.close();
    return id;
  }

}
