import 'package:cost_of_care/dao/database_dao.dart';
import 'package:cost_of_care/models/download_cdm_model.dart';
import 'package:cost_of_care/repository/abstract/saved_screen_repository.dart';

class SavedScreenRepoImpl extends SavedScreenRepository {
  @override
  Future getAllTables() async {
    DatabaseDao databaseDao = new DatabaseDao();
    List<String> hospitals = await databaseDao.getAllTables();
    List<DownloadCdmModel> savedCDMs = [];
    hospitals.forEach((element) {
      savedCDMs.add(DownloadCdmModel(element, 1));
    });
    return savedCDMs;
  }
}
