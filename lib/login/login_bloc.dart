import 'dart:async';

import 'package:carros/api_response.dart';
import 'package:carros/login/login_api.dart';
import 'package:carros/login/user.dart';

class LoginBloc{


  final _streamController = StreamController<bool>();

  get stream => _streamController.stream;

  Future<ApiResponse<User>> login(String login, String pass) async {

    _streamController.add(true);

    ApiResponse response = await LoginApi.login(login, pass);

    _streamController.add(false);

    return response;

  }

  void dispose() {
    _streamController.close();
  }




}