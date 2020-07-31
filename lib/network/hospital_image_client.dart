import 'package:dio/dio.dart';
import 'package:html/parser.dart';

class FetchHospitalImages {
  //Getting image from Google
  Future<String> fetchImagesFromGoogle(String name) async {
    String url = 'https://www.google.com/search?tbm=isch&q=';
    url = url + "${name} Hospital";
    Dio dio = new Dio();
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        String document = response.data;
        var doc = parse(document);
        var img = doc.getElementsByTagName('img')[1].attributes['src'];
        return img;
      }
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.CONNECT_TIMEOUT) {
        throw Exception("Connection Timeout");
      }
      throw Exception(ex.message);
    }
  }
}
