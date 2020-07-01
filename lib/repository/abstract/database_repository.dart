import 'package:curativecare/models/search_model.dart';

abstract class DatabaseRepository {
  void insertCDM(String tableName, List<SearchModel> cdmList);

  Future getCDM(String tableName);
}
