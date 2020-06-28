import 'package:equatable/equatable.dart';

abstract class ViewCdmScreenEvent extends Equatable {
  const ViewCdmScreenEvent();
}

class LoadCdm extends ViewCdmScreenEvent {
  String tableName;

  LoadCdm(this.tableName);

  @override
  List<Object> get props => [];
}
