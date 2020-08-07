import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_progress/download_file_button_event.dart';
import 'package:curativecare/models/search_model.dart';

abstract class DatabaseRepository {
  void insertCDM(InsertInDatabase event, List<SearchModel> cdmList);

  Future getCDM(String tableName);
}
