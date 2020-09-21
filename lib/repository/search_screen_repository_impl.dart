import 'package:cost_of_care/dao/database_dao.dart';
import 'package:cost_of_care/models/search_model.dart';
import 'package:cost_of_care/repository/abstract/search_screen_repository.dart';

import '../main.dart';

class SearchScreenRepositoryImpl extends SearchScreenRepository {
  @override
  Future searchForProcedure(String procedureName) async {
    DatabaseDao databaseDao = new DatabaseDao();
    List<SearchModel> list;
    int searchByValue = 0;
    bool checkSearchBy = await box.containsKey('searchBy');
    if (checkSearchBy) searchByValue = box.get('searchBy');
    if (searchByValue == 1) {
      double priceValue = double.parse(procedureName);
      list = await databaseDao.searchProcedureInAllTablesByPrice(priceValue);
    } else
      list = await databaseDao.searchProcedureInAllTables(procedureName);
    bool checkPrice = await box.containsKey('price');
    if (checkPrice && box.get('price') != 0) {
      int price = box.get('price');
      if (price == 1) {
        list.sort((a, b) {
          return a.charge.compareTo(b.charge);
        });
      } else {
        list.sort((a, b) {
          return b.charge.compareTo(a.charge);
        });
      }
    }
    return list;
  }

  Future searchForProcedureByHospitalName(
      String procedureName, String hospitalName) async {
    DatabaseDao databaseDao = new DatabaseDao();

    List<SearchModel> list;
    int searchByValue = 0;
    bool checkSearchBy = await box.containsKey('searchBy');
    if (checkSearchBy) searchByValue = box.get('searchBy');

    if (searchByValue == 1) {
      double priceValue = double.parse(procedureName);
      list = await databaseDao.searchProcedureInSingleTableByPrice(
          priceValue, hospitalName);
    } else
      list = await databaseDao.searchProcedureInSingleTable(
          procedureName, hospitalName);
    return list;
  }

  List<int> fetchValuesFromHive() {
    int categoryRadioTile;
    int searchByRadioButton;
    int priceRadioTile;
    categoryRadioTile = (box.get('category') ?? 0);
    priceRadioTile = (box.get('price') ?? 0);
    searchByRadioButton = (box.get('searchBy') ?? 0);
    List<int> values = [categoryRadioTile, priceRadioTile, searchByRadioButton];
    return values;
  }

  void saveValuesToHive(
      int selectedRadioTile, int priceRadioTile, int searchBy) {
    box.put('category', selectedRadioTile);
    box.put('price', priceRadioTile);
    box.put('searchBy', searchBy);
  }
}
