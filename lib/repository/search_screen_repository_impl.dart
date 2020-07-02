import 'package:curativecare/dao/database_dao.dart';
import 'package:curativecare/models/search_model.dart';
import 'package:curativecare/repository/abstract/search_screen_repository.dart';

import '../main.dart';

class SearchScreenRepositoryImpl extends SearchScreenRepository{
  @override
  Future searchForProcedure(String procedureName) async {
     DatabaseDao databaseDao=new DatabaseDao();
    List<SearchModel> list=await databaseDao.searchProcedureInAllTables(procedureName);
     bool checkPrice=await box.containsKey('price');
     if(checkPrice&&box.get('price')!=0) {
      int price=box.get('price');
      if(price==1) {
        list.sort((a, b) {
          return a.charge.compareTo(b.charge);
        });
      }
      else{
        list.sort((a, b) {
          return b.charge.compareTo(a.charge);
        });
      }
     }
     return list;
  }

  List<int> FetchValuesFromHive(){
    int selectedRadioTile;
    int priceRadioTile;
    selectedRadioTile = (box.get('category') ?? 0);
    priceRadioTile = (box.get('price') ?? 0);
    List<int> values=[selectedRadioTile,priceRadioTile];
    return values;
  }
  void SaveValuesToHive( int selectedRadioTile,int priceRadioTile){
    box.put('category', selectedRadioTile);
    box.put('price', priceRadioTile);
  }
}