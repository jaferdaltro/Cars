import 'package:carros/carros/carro.dart';
import 'package:carros/carros/carro_page.dart';
import 'package:carros/carros/carros_bloc.dart';
import 'package:carros/carros/carros_listview.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

class CarrosPage extends StatefulWidget {
  final String tipo;

  CarrosPage(this.tipo);

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
  get tipo => widget.tipo;

  CarrosBloc bloc = CarrosBloc();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print("init state do listView");
    bloc.feth(tipo);
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
    return  bloc.feth(tipo);
    
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
  }

}
