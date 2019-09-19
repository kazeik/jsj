import 'package:sqflite/sqflite.dart';
import 'package:quiver/strings.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-19 16:57
 * 类说明:
 */

class DbUtils {
  static DbUtils get instance => _getInstance();
  static DbUtils _instance;

  Database db;

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
    String path = databasesPath + 'jsj.db';

    //根据数据库文件路径和数据库版本号创建数据库表
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE loginTable (
            userId INTEGER PRIMARY KEY,
            avatar TEXT,
            phone TEXT,
            isCurrent REAL)
          ''');
    });
  }
}
