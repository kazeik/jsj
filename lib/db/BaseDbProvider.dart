import 'package:jsj/db/SqlManager.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:meta/meta.dart';

/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-20 10:34
 * 类说明:
 */
abstract class BaseDbProvider {
  bool isTableExits = false;

  createTableString();

  tableName();

  ///创建表sql语句
  tableBaseString(String sql) {
    Utils.logs("创建数据库的语句 = $sql");
    return sql;
  }

  Future<Database> getDataBase() async {
    return await open();
  }

  ///super 函数对父类进行初始化
  @mustCallSuper
  prepare(name, String createSql) async {
    Utils.logs("sql = $createSql");
    isTableExits = await SqlManager.isTableExits(name);
    Utils.logs("当前数据库 = $name 是否已存在 = $isTableExits");
    if (!isTableExits) {
      Database db = await SqlManager.getCurrentDatabase();
      return await db.execute(createSql);
    }
  }

  @mustCallSuper
  open() async {
    Utils.logs("打开数据库 发现数据库当前 $isTableExits 存在");
    if (!isTableExits) {
      await prepare(tableName(), createTableString());
    }
    return await SqlManager.getCurrentDatabase();
  }
}
