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

  Future getAllTables() async {
    final database = await dbProvider.database;
    List<String> tableNames = new List();
    tableNames = (await database
            .query('sqlite_master', where: 'type = ?', whereArgs: ['table']))
        .map((row) => row['name'] as String)
        .toList(growable: true);
    print(tableNames);
    return tableNames;
  }
   Future searchProcedureInAllTables(String searchQuery) async{
        final database=await dbProvider.database;
        List<String> hospitalName=await getAllTables();
        if(hospitalName.length>0)
          hospitalName.removeAt(0);
        String query=" Select * from ( SELECT description , charge ,category , ";
        int length=hospitalName.length;
        int start=0;
        for(int i=0;i<length;i++) {
          start = start + 1;
          query +=
        "'"+  hospitalName[i]+"'"+" as name " "from "  + hospitalName[i] +
                  " where " + hospitalName[i]  + ".description like " +
                  "'%" + searchQuery + "%'" +" limit 50 ) ";
          if(start != length)
           query+=" union Select * from ( SELECT description , charge ,category , ";
          }
        List<SearchModel> list=new List();
        print(query);
        List<Map<String,dynamic>> result=await database.rawQuery(query);
        result.forEach((itemMap) {
          SearchModel searchmodel=new SearchModel.empty();
          list.add(searchmodel.fromMapResult(itemMap));
        });
        return list;
  }
}
