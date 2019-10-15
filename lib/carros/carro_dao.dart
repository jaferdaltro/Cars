import 'dart:async';

import 'package:carros/carros/carro.dart';
import 'package:carros/utils/sql/base_dao.dart';

// Data Access Object
class CarroDAO extends BaseDAO<Carro> {
  @override
  String get table => "carro";

  Future<List<Carro>> findAllByTipo(String tipo) async {
    return query('select * from carro where tipo =? ', [tipo]);
  }

  @override
  Carro fromMap(Map<String, dynamic> map) {
    return Carro.fromMap(map);
  }
}
