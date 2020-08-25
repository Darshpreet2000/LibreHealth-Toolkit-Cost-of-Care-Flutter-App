import 'package:cost_of_care/models/search_model.dart';
import 'package:cost_of_care/repository/database_repository_impl.dart';

import 'abstract/view_cdm_screen_repository.dart';

class ViewCDMScreenRepositoryImpl extends ViewCDMScreenRepository {
  @override
  Future fetchCDMList(String tableName) async {
    DatabaseRepositoryImpl databaseRepositoryImpl =
        new DatabaseRepositoryImpl();
    List<SearchModel> hospitalCDM =
        await databaseRepositoryImpl.getCDM(tableName);
    return hospitalCDM;
  }
}
