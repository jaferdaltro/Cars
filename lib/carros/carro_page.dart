import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/carros/carro.dart';
import 'package:carros/carros/lori_api.dart';
import 'package:carros/favoritos/favorito_service.dart';
import 'package:carros/widgets/text.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatefulWidget {
  Carro c;

  CarroPage(this.c);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _bloc = LoriBloc();

  Color color = Colors.grey;

  Carro get carro => widget.c;


  @override
  void initState() {
    super.initState();

    FavoritoService.isFavorito(carro).then((bool favorito){
      setState(() {
        color = favorito ? Colors.red : Colors.grey;
      });
    });

    _bloc.feth();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.c.nome),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.location_on),
              onPressed: _onClickMapa,
            ),
            IconButton(
              icon: Icon(Icons.videocam),
              onPressed: _onClickVideo,
            ),
            PopupMenuButton(
              onSelected: _onClickPoupMenu,
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(value: "Editar", child: Text("Editar")),
                  PopupMenuItem(value: "Deletar", child: Text("Deletar")),
                  PopupMenuItem(value: "Share", child: Text("Share")),
                ];
              },
            ),
          ],
        ),
        body: _body());
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: widget.c.urlFoto,
          ),
          _bloco1(),
          Divider(),
          _bloco2(),
        ],
      ),
    );
  }

  Row _bloco1() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            text(widget.c.nome, fontSize: 22, bold: true),
            text(widget.c.tipo)
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite,
                size: 40,
                color: color,
              ),
              onPressed: _onClickFavorite,
            ),
            IconButton(
              icon: Icon(
                Icons.share,
                size: 40,
              ),
              onPressed: _onClickShare,
            ),
          ],
        )
      ],
    );
  }

  void _onClickPoupMenu(String value) {
    switch (value) {
      case "Editar":
        print("Editar...");
        break;
      case "Deletar":
        print("Deletar...");
        break;
      case "Share":
        print("Share...");
        break;
    }
  }

  void _onClickMapa() {}

  void _onClickVideo() {}

  void _onClickFavorite()async {

    bool favorito = await FavoritoService.favoritar(carro);

    setState(() {
      color = favorito ? Colors.red : Colors.grey;
    });
  }

  void _onClickShare() {}

  _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        text(widget.c.descricao, bold: true),
        SizedBox(
          height: 20,
        ),
        StreamBuilder<String>(
            stream: _bloc.stream,
            initialData: "",
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return TextError("there is no text to show!!");
              }

              return text(
                snapshot.data,
              );
            }),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
