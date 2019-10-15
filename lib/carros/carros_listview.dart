import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/carros/carro.dart';
import 'package:carros/carros/carro_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class CarrosListview extends StatelessWidget {

  List<Carro> carros;


  CarrosListview(this.carros);

  @override
  Widget build(BuildContext context) {
    print("carros_listview.build");


    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros == null ? 0 : carros.length,
        itemBuilder: (context, index) {
          Carro c = carros[index];
          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                      child: CachedNetworkImage(
                imageUrl: c.urlFoto ??
                    "https://carros-springboot.herokuapp.com/api/v1/carros/32",

                    width: 250,
                  )),
                  Text(
                    c.nome,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    "descrição...",
                    style: TextStyle(fontSize: 16),
                  ),
                  ButtonTheme.bar(
                    // make buttons use the appropriate styles for cards
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('DETALHES'),
                          onPressed: () {
                            _onClickCarro(context, c);
                          },
                        ),
                        FlatButton(
                          child: const Text('SHARE'),
                          onPressed: () {
                            /* ... */
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onClickCarro(BuildContext context, Carro c) {
    push(context, CarroPage(c));
  }



}
