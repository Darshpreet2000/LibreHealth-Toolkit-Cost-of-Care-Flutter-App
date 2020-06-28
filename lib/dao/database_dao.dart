import 'package:curativecare/database/hospital_database.dart';
import 'package:curativecare/models/search_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<void> createHospitalTable(String name) async {
    name = name.replaceAll(' ', '_');
    final db = await dbProvider.database;
    await db.rawQuery('DROP TABLE IF EXISTS ${name} ');
    await db.rawQuery(
        'CREATE TABLE ${name} ( description varchar ,  charge varchar, category varchar )');
    return;
  }

  void insertData(String tableName, List<SearchModel> cdmList) async {
    final database = await dbProvider.database;
    tableName = tableName.replaceAll(' ', '_');
    await database.transaction((txn) async {
      Batch batch = txn.batch();
      cdmList.forEach((val) {
        //assuming you have 'Cities' class defined
        SearchModel cdm = val;
        batch.insert(tableName, cdm.toMap());
      });
      await batch.commit();
    });

    //checking
    //   print(database.rawQuery('select * from $tableName limit 10'));
    print('Done');
  }

  Future<List<SearchModel>> readData(String name) async {
    name = name.replaceAll(' ', '_');
    final database = await dbProvider.database;
    //Table name is given
    List<Map<String, dynamic>> maps = await database.query(name);
    return List.generate(maps.length, (i) {
      SearchModel cdm = new SearchModel.empty();
      return cdm.fromMap(maps[i]);
    });
  }
}
