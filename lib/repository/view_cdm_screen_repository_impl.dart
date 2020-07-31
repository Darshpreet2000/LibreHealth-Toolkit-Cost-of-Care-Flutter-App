import 'package:curativecare/models/search_model.dart';
import 'package:curativecare/repository/database_repository_impl.dart';

import 'abstract/view_cdm_screen_repository.dart';

class ViewViewCDMScreenRepositoryImpl extends ViewCDMScreenRepository {
  @override
  Future fetchCDMList(String tableName) async {
    DatabaseRepositoryImpl databaseRepositoryImpl =
        new DatabaseRepositoryImpl();
    List<SearchModel> hospitalCDM =
        await databaseRepositoryImpl.getCDM(tableName);
    return hospitalCDM;
  }
}
