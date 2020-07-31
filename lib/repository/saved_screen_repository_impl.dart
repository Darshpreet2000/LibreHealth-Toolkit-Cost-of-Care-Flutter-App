import 'package:curativecare/dao/database_dao.dart';
import 'package:curativecare/repository/abstract/saved_screen_repository.dart';

class SavedScreenRepoImpl extends SavedScreenRepository {
  @override
  Future getAllTables() async {
    DatabaseDao databaseDao = new DatabaseDao();
    List<String> hospitals = new List();
    hospitals = await databaseDao.getAllTables();
    hospitals.removeAt(0);
    for (int i = 0; i < hospitals.length; i++) {
      hospitals[i] = hospitals[i].replaceAll('_', ' ');
    }
    return hospitals;
  }
}
