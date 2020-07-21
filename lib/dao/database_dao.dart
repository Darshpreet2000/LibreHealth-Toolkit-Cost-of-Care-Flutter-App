import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_progress/download_file_button_event.dart';
import 'package:curativecare/database/hospital_database.dart';
import 'package:curativecare/models/search_model.dart';
import 'package:sqflite/sqflite.dart';

import '../main.dart';

class DatabaseDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<void> createHospitalTable(String name) async {
    name = name.replaceAll(' ', '_');
    name = name.replaceAll('(', '_');
    name = name.replaceAll(')', '_');
    name = name.replaceAll(',', '_');
    name = name.replaceAll('.', '_');

    final db = await dbProvider.database;
    await db.transaction((txn) async {
      await txn.rawQuery('DROP TABLE IF EXISTS $name ');
      await txn.rawQuery(
          'CREATE TABLE $name ( description varchar ,  charge varchar, category varchar )');
    });
    return;
  }

  void insertData(
      DownloadFileButtonProgress event, List<SearchModel> cdmList) async {
    String tableName = event.hospitalName;
    final database = await dbProvider.database;
    tableName = tableName.replaceAll(' ', '_');
    tableName = tableName.replaceAll('(', '_');
    tableName = tableName.replaceAll(')', '_');
    tableName = tableName.replaceAll(',', '_');
    tableName = tableName.replaceAll('.', '_');

    int total = cdmList.length;
    int completed = 0;
    double percentCount = 0, progressNow = 0;
    double progress = event.progress;
    database.transaction((txn) async {
      Batch batch = txn.batch();
      for (int i = 0; i < cdmList.length; i++) {
        SearchModel cdm = cdmList[i];
        await Future(() {
          batch.insert(tableName, cdm.toMap());
          completed += 1;
          percentCount += 1;
          progressNow = ((completed / total) * 0.4);
          if (percentCount == (total ~/ 40)) {
            event.downloadFileButtonBloc.add(DownloadFileButtonProgress(
                progress + progressNow,
                event.index,
                event.hospitalName,
                event.downloadFileButtonBloc));
            percentCount = 0;
          }
        });
      }
      await batch.commit();
    });

    //checking
    //   print(database.rawQuery('select * from $tableName limit 10'));
    print('Done');
  }

  Future<List<SearchModel>> readData(String name) async {
    name = name.replaceAll(' ', '_');
    name = name.replaceAll('(', '_');
    name = name.replaceAll(')', '_');
    name = name.replaceAll(',', '_');
    name = name.replaceAll('.', '_');

    final database = await dbProvider.database;
    //Table name is given
    List<Map<String, dynamic>> maps;
    await database.transaction((txn) async {
      maps = await txn.query(name);
    });
    return List.generate(maps.length, (i) {
      SearchModel cdm = new SearchModel.empty();
      return cdm.fromMap(maps[i]);
    });
  }

  Future getAllTables() async {
    final database = await dbProvider.database;
    List<String> tableNames = new List();
    await database.transaction((txn) async {
      tableNames = (await txn
          .query('sqlite_master', where: 'type = ?', whereArgs: ['table']))
          .map((row) => row['name'] as String)
          .toList(growable: true);
    });
    print(tableNames);
    return tableNames;
  }

  Future searchProcedureInAllTables(String searchQuery) async {
    final database = await dbProvider.database;
    List<SearchModel> list = new List();
    List<String> hospitalName = await getAllTables();
    if (hospitalName.length > 0) hospitalName.removeAt(0);
    bool checkCategory = await box.containsKey('category');
    String category;
    if (checkCategory && box.get('category') != 0) {
      int categoryType = await box.get('category');
      if (categoryType == 1) {
        category = "Standard";
      } else if (categoryType == 2) {
        category = "DRG";
      } else {
        category = "Pharmacy";
      }
    }
    String query = "Select * from ( SELECT description , charge ,category , ";
    int length = hospitalName.length;
    int start = 0;
    if(length>0) {
      for (int i = 0; i < length; i++) {
        start = start + 1;
        query += "'" +
            hospitalName[i] +
            "'" +
            " as name " "from " +
            hospitalName[i] +
            " where " +
            hospitalName[i] +
            ".description like " +
            "'%" +
            searchQuery +
            "%' " +
            (checkCategory == true && box.get('category') != 0
                ? " and category = '${category}'"
                : " ") +
            " limit 50 ) ";
        if (start != length)
          query +=
          " union Select * from ( SELECT description , charge ,category , ";
      }
      print(query);
      await database.transaction((txn) async {
        List<Map<String, dynamic>> result = await txn.rawQuery(query);
        result.forEach((itemMap) {
          SearchModel searchmodel = new SearchModel.empty();
          list.add(searchmodel.fromMapResult(itemMap));
        });
      });
    }
    return list;
  }
}
