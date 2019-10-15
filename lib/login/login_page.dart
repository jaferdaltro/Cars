import 'dart:async';

import 'package:carros/login/login_api.dart';
import 'package:carros/carros/home_page.dart';
import 'package:carros/api_response.dart';
import 'package:carros/login/login_bloc.dart';
import 'package:carros/login/user.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final tLogin = TextEditingController();

  final tPass = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _focusPassword = FocusNode();




  final bloc = LoginBloc();



  @override
  Widget build(BuildContext context) {
    print("home build ${widget}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText(
              "Login",
              "Insert your login",
              tLogin,
              validator: _validatorLogin,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              nextFocus: _focusPassword,
            ),
            AppText(
              "Password",
              "Insert your password",
              tPass,
              obscure: true,
              validator: _validatorPass,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              focusNode: _focusPassword,
            ),
            StreamBuilder<bool>(
                stream: bloc.stream,
                initialData: false,
                builder: (context, snapshot) {
                  return AppButton(
                    "Login",
                    _onClickLogin,
                    snapshot.data,
                  );
                }
            ),
          ],
        ),
      ),
    );
  }

  String _validatorLogin(String text) {
    if (text.isEmpty) {
      return "the field login cannot be empty!";
    }
    return null;
  }

  String _validatorPass(String text) {
    if (text.isEmpty) {
      return "the field password cannot be empty!";
    }
    return null;
  }

  void _onClickLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    String login = tLogin.text.trim();
    String pass = tPass.text.trim();

    print("user: $login, password: $pass");

    ApiResponse response = await bloc.login(login, pass);

    if (response.ok) {
      User user = response.result;
      print(">>>$user");
      push(context, HomePage(), replace: true);
    } else {
      alert(context, response.msg);
    }


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
  }
}
