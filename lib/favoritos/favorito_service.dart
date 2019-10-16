
import 'package:carros/carros/carro.dart';
import 'package:carros/carros/carro_dao.dart';
import 'package:carros/favoritos/favorito.dart';
import 'package:carros/favoritos/favorito_dao.dart';

class FavoritoService {
  static Future<bool> favoritar(Carro c) async {
    Favorito f = Favorito.fromCarro(c);

    final dao = FavoritoDAO();

    bool existe = await dao.exists(c.id);

    if (existe) {
      dao.delete(c.id);
      return false;
    } else {
      dao.save(f);
      return true;
    }
  }

  static Future<List<Carro>> getCarros() {
    //SELECT * FROM carro c, favorito f WHERE c.id = f.id;

    return CarroDAO()
        .query('SELECT * FROM carro c, favorito f WHERE c.id = f.id');
  }

  static Future<bool> isFavorito (Carro c)async{
    final dao = FavoritoDAO();
    bool exists = await dao.exists(c.id);
    return exists;
  }
}
