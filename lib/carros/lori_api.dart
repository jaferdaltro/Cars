import 'dart:async';

import 'package:http/http.dart' as http;

class LoriApi {
  static Future<String> getLori() async {
    String url = "https://loripsum.net/api";

    var response = await http.get(url);

    String text = response.body;

    text = text.replaceAll("<p>", "");
    text = text.replaceAll("</p>", "");

    return text;

  }
}

class LoriBloc {
  final _streamController = StreamController<String>();

  static String lorim;

  get stream => _streamController.stream;

  feth() async {
    try {
      String s = lorim ?? await LoriApi.getLori();
      lorim = s;
      _streamController.add(s);
    } catch (e) {
      _streamController.addError(e);
    }
  }

  void dispose() {
    _streamController.close();
  }
}

