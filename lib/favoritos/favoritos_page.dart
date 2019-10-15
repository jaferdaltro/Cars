import 'package:carros/carros/carro.dart';
import 'package:carros/carros/carros_listview.dart';
import 'package:carros/favoritos/favoritos_bloc.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

class FavoritosPage extends StatefulWidget {

  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {

    final bloc = FavoritosBloc();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print("init state do listView");
    bloc.feth();
  }

  @override
  Widget build(BuildContext context) {
    print("carros_listview.build");
    super.build(context);

    return StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return TextError("ops... houve um erro!");
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Carro> carros = snapshot.data;
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: CarrosListview(carros),
          );
        });
  }

  Future<void> _onRefresh() {
    return bloc.feth();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
  }
}
