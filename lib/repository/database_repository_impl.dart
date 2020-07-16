import 'package:curativecare/bloc/download_cdm_bloc/download_file_bloc/download_file_button_event.dart';
import 'package:curativecare/dao/database_dao.dart';
import 'package:curativecare/models/search_model.dart';
import 'package:curativecare/repository/abstract/database_repository.dart';

class DatabaseRepositoryImpl extends DatabaseRepository {
  final hospitalDao = DatabaseDao();

  @override
  Future getCDM(String tableName) async {
    List<SearchModel> hospitalCDM=await hospitalDao.readData(tableName);
    return hospitalCDM;
  }

  @override
  void insertCDM(DownloadFileButtonProgress event, List<SearchModel> cdmList) async {
    //Create a table then insert in it
    await hospitalDao.createHospitalTable(event.hospitalName);
    hospitalDao.insertData(event, cdmList);
    return;
  }
}
