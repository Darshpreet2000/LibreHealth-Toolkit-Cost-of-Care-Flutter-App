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
