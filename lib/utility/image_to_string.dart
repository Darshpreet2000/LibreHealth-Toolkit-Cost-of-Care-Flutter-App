import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import '../main.dart';

class ImageToString{
  static Future<bool> saveImageToPreferences(String key,Uint8List value) async {
      String string=base64String(value);
      box.put(key,string);
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}