import 'package:equatable/equatable.dart';

abstract class BottomSheetState extends Equatable {
  int selectedRadioTile;
  int priceRadioTile;

}

class BottomSheetLoadValues extends BottomSheetState{
  int selectedRadioTile;
  int priceRadioTile;

  BottomSheetLoadValues(this.selectedRadioTile, this.priceRadioTile);

  @override
  List<Object> get props => [selectedRadioTile,priceRadioTile];

}
class BottomSheetSaved extends BottomSheetState{

  int selectedRadioTile;
  int priceRadioTile;

  BottomSheetSaved(this.selectedRadioTile, this.priceRadioTile);

  @override
  List<Object> get props => [selectedRadioTile,priceRadioTile];

}