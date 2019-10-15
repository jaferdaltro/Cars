import 'dart:async';

import 'package:carros/carros/carro.dart';
import 'package:carros/carros/carros_api.dart';
import 'package:carros/carros/carro_dao.dart';
import 'package:carros/favoritos/favorito_service.dart';
import 'package:carros/utils/connectivity.dart';

class FavoritosBloc {
  final _streamController = StreamController<List<Carro>>();

  get stream => _streamController.stream;

  Future <List<Carro>>feth() async {
    try {

      List<Carro> carros = await FavoritoService.getCarros();
      _streamController.add(carros);

      return carros;

    } catch (e) {
      print(e);
      _streamController.addError(e);
    }
    return null;
  }

  void dispose() {
    _streamController.close();
  }
}
