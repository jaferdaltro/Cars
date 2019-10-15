import 'dart:async';

import 'package:carros/carros/carro.dart';
import 'package:carros/carros/carros_api.dart';
import 'package:carros/carros/carro_dao.dart';
import 'package:carros/utils/connectivity.dart';

class CarrosBloc {
  final _streamController = StreamController<List<Carro>>();

  get stream => _streamController.stream;

  Future <List<Carro>>feth(String tipo) async {
    try {
      List<Carro> carros;

      bool isConnected = await isNetworkOn();

     if(! isConnected){

       carros = await CarroDAO().findAllByTipo(tipo);
       _streamController.add(carros);
       return carros;
     }

      carros = await CarrosApi.getCarros(tipo);
      _streamController.add(carros);


      if(carros.isNotEmpty){
        final dao = CarroDAO();
        carros.forEach(dao.save);

      }

      return carros;

    } catch (e) {
      print(e);
      _streamController.addError(e);
    }
  }

  void dispose() {
    _streamController.close();
  }
}
