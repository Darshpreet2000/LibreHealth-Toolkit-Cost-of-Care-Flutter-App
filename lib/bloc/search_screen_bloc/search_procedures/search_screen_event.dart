import 'package:equatable/equatable.dart';

abstract class SearchScreenEvent extends Equatable {
  const SearchScreenEvent();
}

class SearchInDatabase extends SearchScreenEvent {
  String searchString;

  SearchInDatabase(this.searchString);

  @override
  List<Object> get props => [searchString];
}

class SearchInDatabaseFromViewCDMScreen extends SearchScreenEvent {
  String searchString;
  String hospitalName;

  SearchInDatabaseFromViewCDMScreen(this.searchString, this.hospitalName);

  @override
  List<Object> get props => [searchString];
}
