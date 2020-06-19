import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

Future<String> fetchImages(String name) async {
  String url = 'https://www.google.com/search?tbm=isch&q=';
  url = url + "${name} Hospital";

  var response = await http.get(url);

  if (response.statusCode == 200) {
    String document = response.body;
    var doc = parse(document);
    var img = doc.getElementsByTagName('img')[1].attributes['src'];
    return img;
  } else {
    throw Exception('Failed to load');
  }
}
