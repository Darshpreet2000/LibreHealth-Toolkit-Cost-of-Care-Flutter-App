import 'package:curativecare/dao/database_dao.dart';
import 'package:curativecare/models/search_model.dart';
import 'package:curativecare/repository/abstract/database_repository.dart';

class DatabaseRepositoryImpl extends DatabaseRepository {
  final hospitalDao = DatabaseDao();

  @override
  Future getCDM(String tableName) {
    hospitalDao.readData(tableName);
  }

  @override
  void insertCDM(String tableName, List<SearchModel> cdmList) async {
    //Create a table then insert in it
    await hospitalDao.createHospitalTable(tableName);
    await hospitalDao.insertData(tableName, cdmList);
    return;
  }
}
