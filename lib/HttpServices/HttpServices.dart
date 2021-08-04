import 'dart:async';
import 'package:http/http.dart' as http;

class CharacterApi {
  static Future getCharacters() {
    return http.get("https://tailorstudio.000webhostapp.com/userFetch.php?id=4");
  }
}