import 'package:curativecare/dao/database_dao.dart';
import 'package:curativecare/repository/abstract/saved_screen_repository.dart';

class SavedScreenRepoImpl extends SavedScreenRepository {
  @override
  Future getAllTables() async {
    DatabaseDao databaseDao = new DatabaseDao();
    List<String> hospitals = new List();
    hospitals = await databaseDao.getAllTables();
    return hospitals;
  }
}
