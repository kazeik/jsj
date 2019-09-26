import 'package:jsj/db/BaseDbProvider.dart';
import 'package:jsj/db/pojo/AccountPojo.dart';
import 'package:jsj/utils/Utils.dart';
import 'package:sqflite/sqflite.dart';

/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-20 10:40
 * 类说明:
 */

class AccountDbProvider extends BaseDbProvider {
  ///表名
  final String name = 'account';

  final String columnId = "id";
  final String columnMobile = "mobile";
  final String columnPass = "pass";
  final String columnAvatar = "avatar";
  final String columnCookieKey = "cookieKey";
  final String columnCookieValue = "cookieValue";
  final String columnCurrent = "current";

  @override
  createTableString() {
    return '''
        create table $name (
        $columnId integer primary key,$columnPass text,
        $columnMobile text ,$columnAvatar text,
        $columnCookieKey text,$columnCookieValue text,
        $columnCurrent integer )
      ''';
  }

  @override
  tableName() {
    return name;
  }

  ///查询数据库
  Future getPersonProvider(String id) async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> maps =
        await db.rawQuery("select * from $name where $columnId = $id");
    return maps;
  }

  ///查找所有的数据
  Future<List<Map<String, dynamic>>> findAllProvider(Database db) async {
    return await db.rawQuery("select * from $name");
  }

  ///插入到数据库
  Future insert(AccountPojo model) async {
    Database db = await getDataBase();
    var userProvider = await getPersonProvider(model.id);
    if (userProvider != null) {
      ///删除数据
      await db.delete(name, where: "$columnId = ?", whereArgs: [model.id]);
    }
    return await db.rawInsert(
        "insert into $name ($columnId,$columnMobile,$columnAvatar,$columnPass,$columnCookieKey,$columnCookieValue,$columnCurrent) values (?,?,?,?,?,?,?)",
        [
          model.id,
          model.mobile,
          model.avatar,
          model.pass,
          model.cookieKey,
          model.cookieValue,
          model.current
        ]);
  }

  ///更新数据库
  Future<void> update(AccountPojo model) async {
    Database database = await getDataBase();
    await database.rawUpdate(
        "update $name set $columnMobile = ?,$columnAvatar = ? where $columnId= ?",
        [model.mobile, model.avatar, model.id]);
  }

  Future<void> updateStateBySql(String sql) async {
    Utils.logs("开始更新数据库");
    Database database = await getDataBase();
    Utils.logs("开始更新操作数据库");
    await database.rawUpdate(sql);
  }

  Future<void> updateState(AccountPojo model) async {
    Database database = await getDataBase();
    await database.rawUpdate(
        "update $name set $columnCurrent = ? where $columnId= ?",
        [model.current, model.id]);
  }

//  ///获取事件数据
//  Future<AccountPojo> getPersonInfo(int id) async {
//    Database db = await getDataBase();
//    List<Map<String, dynamic>> maps = await _getPersonProvider(db, id);
//    if (maps.length > 0) {
//      return AccountPojo.fromJson(maps[0]);
//    }
//    return null;
//  }
}
