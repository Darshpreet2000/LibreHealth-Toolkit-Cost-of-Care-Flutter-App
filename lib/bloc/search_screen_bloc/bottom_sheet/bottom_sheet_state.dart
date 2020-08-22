import 'package:equatable/equatable.dart';

abstract class BottomSheetState extends Equatable {
  const BottomSheetState();

  int get selectedRadioTile => null;

  int get priceRadioTile => null;

  bool get searchBy => null;
}

class BottomSheetLoadValues extends BottomSheetState {
  final int selectedRadioTile;
  final int priceRadioTile;
  final bool searchBy;

  BottomSheetLoadValues(
      this.selectedRadioTile, this.priceRadioTile, this.searchBy);

  @override
  List<Object> get props => [selectedRadioTile, priceRadioTile, searchBy];
}

class BottomSheetApplyValues extends BottomSheetState {
  final int selectedRadioTile;
  final int priceRadioTile;
  final bool searchBy;

  BottomSheetApplyValues(
      this.selectedRadioTile, this.priceRadioTile, this.searchBy);

  @override
  List<Object> get props => [selectedRadioTile, priceRadioTile, searchBy];
}
