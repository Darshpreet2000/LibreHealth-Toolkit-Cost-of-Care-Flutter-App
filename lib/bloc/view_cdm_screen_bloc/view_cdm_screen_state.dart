import 'package:curativecare/models/search_model.dart';
import 'package:equatable/equatable.dart';

abstract class ViewCdmScreenState extends Equatable {
  const ViewCdmScreenState();
}

class LoadedViewCdmScreenState extends ViewCdmScreenState {
  List<SearchModel> cdmList;

  LoadedViewCdmScreenState(this.cdmList);

  @override
  List<Object> get props => [cdmList];
}

class LoadingViewCdmScreenState extends ViewCdmScreenState {
  @override
  List<Object> get props => [];
}
