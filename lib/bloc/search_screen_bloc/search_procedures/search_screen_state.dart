import 'package:cost_of_care/models/search_model.dart';
import 'package:equatable/equatable.dart';

abstract class SearchScreenState extends Equatable {
  const SearchScreenState();
}

class InitialSearchScreenState extends SearchScreenState {
  @override
  List<Object> get props => [];
}

class SearchScreenLoadingState extends SearchScreenState {
  @override
  List<Object> get props => [];
}

class SearchScreenLoadedState extends SearchScreenState {
  final List<SearchModel> searchResult;

  SearchScreenLoadedState(this.searchResult);

  @override
  List<Object> get props => [searchResult];
}

class SearchScreenNoDataState extends SearchScreenState {
  @override
  List<Object> get props => [];
}

class SearchScreenFormatExceptionState extends SearchScreenState {
  final String message;

  SearchScreenFormatExceptionState(this.message);

  @override
  List<Object> get props => [message];
}
