import 'package:curativecare/dao/database_dao.dart';
import 'package:curativecare/models/search_model.dart';

import 'abstract/view_cdm_screen_repository.dart';

class ViewViewCDMScreenRepositoryImpl extends ViewCDMScreenRepository{
  @override
  Future fetchCDMList(String tableName) {
     DatabaseDao databaseDao=new DatabaseDao();
      return databaseDao.readData(tableName);
  }

}