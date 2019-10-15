import 'dart:convert';

import 'package:carros/carros/carro_dao.dart';
import 'package:http/http.dart' as http;

import 'carro.dart';

class TipoCarro{
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    var url = "https://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo";
    print(">> GET > $url");
    var response = await http.get(url);

    List list = json.decode(response.body);
    
    List<Carro> carros = list.map<Carro>((map) => Carro.fromMap(map)).toList();

    return carros;
  }
}
