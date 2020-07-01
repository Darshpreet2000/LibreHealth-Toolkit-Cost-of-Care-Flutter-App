import 'package:curativecare/dao/database_dao.dart';
import 'package:curativecare/repository/abstract/search_screen_repository.dart';

class SearchScreenRepositoryImpl extends SearchScreenRepository{
  @override
  Future searchForProcedure(String procedureName) {
     DatabaseDao databaseDao=new DatabaseDao();
     return databaseDao.searchProcedureInAllTables(procedureName);
  }

}