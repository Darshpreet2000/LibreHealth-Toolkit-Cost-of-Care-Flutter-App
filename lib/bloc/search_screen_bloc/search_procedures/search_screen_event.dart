import 'package:equatable/equatable.dart';

abstract class SearchScreenEvent extends Equatable {
  const SearchScreenEvent();
}

class SearchScreenInitialStateEvent extends SearchScreenEvent {
  @override
  List<Object> get props => [];
}

class SearchInDatabase extends SearchScreenEvent {
  final String searchString;

  SearchInDatabase(this.searchString);

  @override
  List<Object> get props => [searchString];
}

class SearchInDatabaseFromViewCDMScreen extends SearchScreenEvent {
  final String searchString;
  final String hospitalName;

  SearchInDatabaseFromViewCDMScreen(this.searchString, this.hospitalName);

  @override
  List<Object> get props => [searchString];
}
