import 'package:cost_of_care/bloc/download_cdm_bloc/download_cdm_progress/download_file_button_event.dart';
import 'package:cost_of_care/database/hospital_database.dart';
import 'package:cost_of_care/models/search_model.dart';
import 'package:sqflite/sqflite.dart';

import '../main.dart';

class DatabaseDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<void> createHospitalTable(String name) async {
    name = "`$name`";
    final db = await dbProvider.database;
    await db.transaction((txn) async {
      await txn.rawQuery('DROP TABLE IF EXISTS $name ');
      await txn.rawQuery(
          'CREATE TABLE $name ( description varchar ,  charge varchar, category varchar )');
    });
    return;
  }

  Future getAllTables() async {
    final database = await dbProvider.database;
    List<String> tableNames = [];
    await database.transaction((txn) async {
      tableNames = (await txn.query('sqlite_master',
              where:
                  "type = ? AND name NOT IN ('sqlite_sequence', 'android_metadata')",
              whereArgs: ['table']))
          .map((row) => row['name'] as String)
          .toList(growable: true);
    });
    print(tableNames);
    return tableNames;
  }

  Future insertDataInCDM(
      InsertInDatabase event, List<SearchModel> cdmList) async {
    String tableName = event.hospitalName;
    final database = await dbProvider.database;
    tableName = "`$tableName`";
    int total = cdmList.length;
    int completed = 0;
    double percentCount = 0, progressNow = 0, counter = 1;
    double progress = 0.6;
    database.transaction((txn) async {
      Batch batch = txn.batch();
      for (int i = 0; i < cdmList.length; i++) {
        SearchModel cdm = cdmList[i];
        await Future(() {
          batch.insert(tableName, cdm.toMap());
          completed += 1;
          percentCount = (completed / total) * 40;
          if (percentCount >= counter) {
            progressNow = ((completed / total) * 0.4);
            event.downloadFileButtonBloc.add(DownloadFileButtonProgress(
                progress + progressNow,
                event.index,
                event.hospitalName,
                event.downloadFileButtonBloc));
            counter++;
          }
        });
      }
      await batch.commit();
    });

    //checking
    //   print(database.rawQuery('select * from $tableName limit 10'));
    print('Done');
    return;
  }

  Future<List<SearchModel>> readDataFromCDM(String name) async {
    name = "`$name`";

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

  Future searchProcedureInAllTables(String searchQuery) async {
    final database = await dbProvider.database;
    List<SearchModel> list = [];
    List<String> hospitalName = await getAllTables();
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
    if (length > 0) {
      for (int i = 0; i < length; i++) {
        hospitalName[i] = "`${hospitalName[i]}`";
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
                ? " and category = '$category'"
                : " ") +
            " limit 80 ) ";

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

  Future searchProcedureInSingleTable(String searchQuery, String name) async {
    name = "`$name`";

    final database = await dbProvider.database;

    List<SearchModel> list = [];
    String query = "Select * from ( SELECT description , charge ,category , ";
    query += "'" +
        name +
        "'" +
        " as name " "from " +
        name +
        " where " +
        name +
        ".description like " +
        "'%" +
        searchQuery +
        "%' " +
        "  ) ";
    print(query);
    await database.transaction((txn) async {
      List<Map<String, dynamic>> result = await txn.rawQuery(query);
      result.forEach((itemMap) {
        SearchModel searchModel = new SearchModel.empty();
        list.add(searchModel.fromMapResult(itemMap));
      });
    });
    return list;
  }

  Future searchProcedureInAllTablesByPrice(double searchQuery) async {
    final database = await dbProvider.database;
    List<SearchModel> list = [];
    List<String> hospitalName = await getAllTables();
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
    if (length > 0) {
      for (int i = 0; i < length; i++) {
        start = start + 1;
        hospitalName[i] = "`${hospitalName[i]}`";
        query += "'" +
            hospitalName[i] +
            "'" +
            " as name " "from " +
            hospitalName[i] +
            " where " +
            "ROUND(${hospitalName[i]}.charge,0) = ROUND($searchQuery,0)" +
            (checkCategory == true && box.get('category') != 0
                ? " and category = '$category'"
                : " ") +
            " limit 80 ) ";
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

  Future searchProcedureInSingleTableByPrice(
      double searchQuery, String name) async {
    name = "`$name`";

    final database = await dbProvider.database;

    List<SearchModel> list = [];
    String query = "Select * from ( SELECT description , charge ,category , ";
    query += "'" +
        name +
        "'" +
        " as name " "from " +
        name +
        " where " +
        "ROUND($name.charge,0) = ROUND($searchQuery,0)" +
        "  ) ";
    print(query);
    await database.transaction((txn) async {
      List<Map<String, dynamic>> result = await txn.rawQuery(query);
      result.forEach((itemMap) {
        SearchModel searchModel = new SearchModel.empty();
        list.add(searchModel.fromMapResult(itemMap));
      });
    });
    return list;
  }
}
