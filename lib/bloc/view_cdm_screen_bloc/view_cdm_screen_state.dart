import 'package:curativecare/models/search_model.dart';
import 'package:equatable/equatable.dart';

abstract class ViewCdmScreenState extends Equatable {
  const ViewCdmScreenState();
}

class LoadedViewCdmScreenState extends ViewCdmScreenState {
  final List<SearchModel> cdmList;

  LoadedViewCdmScreenState(this.cdmList);

  @override
  List<Object> get props => [cdmList];
}

class LoadingViewCdmScreenState extends ViewCdmScreenState {
  @override
  List<Object> get props => [];
}

class ErrorViewCdmScreenState extends ViewCdmScreenState {
  final String message;

  ErrorViewCdmScreenState(this.message);

  @override
  List<Object> get props => [message];
}
