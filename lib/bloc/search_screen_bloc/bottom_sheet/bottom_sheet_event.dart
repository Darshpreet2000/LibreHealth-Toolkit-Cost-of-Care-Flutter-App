import 'package:equatable/equatable.dart';

abstract class BottomSheetEvent extends Equatable {
  const BottomSheetEvent();
}

class BottomSheetFetchValues extends BottomSheetEvent {
  @override
  List<Object> get props => [];
}

class BottomSheetApply extends BottomSheetEvent {
  int selectedRadioTile;
  int priceRadioTile;

  BottomSheetApply(this.selectedRadioTile, this.priceRadioTile);

  @override
  List<Object> get props => [];
}

class BottomSheetChangeValue extends BottomSheetEvent {
  int selectedRadioTile;
  int priceRadioTile;

  BottomSheetChangeValue(this.selectedRadioTile, this.priceRadioTile);

  @override
  List<Object> get props => [selectedRadioTile, priceRadioTile];
}
