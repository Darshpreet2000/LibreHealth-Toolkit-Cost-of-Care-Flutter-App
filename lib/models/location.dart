import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class UserLocation extends Equatable{
  String latitude,longitude,address;

  UserLocation(this.latitude, this.longitude, this.address);


  @override
  String toString() {
    return 'Location { latitude: $latitude, longitude: $longitude, address: $address }';
  }

  @override
  List<Object> get props =>[latitude,longitude,address];

}