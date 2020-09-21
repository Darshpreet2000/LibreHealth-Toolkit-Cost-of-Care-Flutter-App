import 'package:equatable/equatable.dart';

abstract class ViewCdmScreenEvent extends Equatable {
  const ViewCdmScreenEvent();
}

class LoadCdm extends ViewCdmScreenEvent {
  final String tableName;

  LoadCdm(this.tableName);

  @override
  List<Object> get props => [tableName];
}
