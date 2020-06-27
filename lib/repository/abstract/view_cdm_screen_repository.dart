import 'package:curativecare/models/search_model.dart';

abstract class ViewCDMScreenRepository{
  Future fetchCDMList(String tableName);
}