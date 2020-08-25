import 'package:cost_of_care/bloc/download_cdm_bloc/download_cdm_progress/download_file_button_event.dart';
import 'package:cost_of_care/dao/database_dao.dart';
import 'package:cost_of_care/models/search_model.dart';
import 'package:cost_of_care/repository/abstract/database_repository.dart';

class DatabaseRepositoryImpl extends DatabaseRepository {
  final hospitalDao = DatabaseDao();

  @override
  Future getCDM(String tableName) async {
    List<SearchModel> hospitalCDM =
        await hospitalDao.readDataFromCDM(tableName);
    return hospitalCDM;
  }

  @override
  Future insertCDM(InsertInDatabase event, List<SearchModel> cdmList) async {
    //Create a table then insert in it
    await hospitalDao.createHospitalTable(event.hospitalName);
    await hospitalDao.insertDataInCDM(event, cdmList);
    return;
  }
}
