import 'package:equatable/equatable.dart';

abstract class BottomSheetEvent extends Equatable {
  const BottomSheetEvent();
}

class BottomSheetFetchValues extends BottomSheetEvent {
  @override
  List<Object> get props => [];
}

class BottomSheetApply extends BottomSheetEvent {
  final int selectedRadioTile;
  final int priceRadioTile;

  final bool searchBy;

  BottomSheetApply(this.selectedRadioTile, this.priceRadioTile, this.searchBy);

  @override
  List<Object> get props => [selectedRadioTile, priceRadioTile, searchBy];
}

class BottomSheetChangeValue extends BottomSheetEvent {
  final int selectedRadioTile;
  final int priceRadioTile;
  final bool searchBy;

  BottomSheetChangeValue(
      this.selectedRadioTile, this.priceRadioTile, this.searchBy);

  @override
  List<Object> get props => [selectedRadioTile, priceRadioTile, searchBy];
}
