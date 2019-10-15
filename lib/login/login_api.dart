import 'dart:convert';

import 'package:carros/api_response.dart';
import 'package:carros/login/user.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<User>> login(String user, String pass) async {

    try {
      var url = 'https://carros-springboot.herokuapp.com/api/v2/login';
      
      Map<String,String> headers = {
         "Content-Type": "application/json"
      };
      
      final params = {
        "username": user,
        "password": pass
      };
      
      String s = json.encode(params);
      
      var response = await http.post(
        url,
        body: s,
        headers: headers,
      );
      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      Map mapResponse = json.decode(response.body);
      
      
      if (response.statusCode == 200){
        final User usuario = User.fromJson(mapResponse);
        usuario.save();
        return ApiResponse.ok(usuario);
      }

      return ApiResponse.error(mapResponse["error"]);
    } catch (error, exeption) {
      print(">>erro no login -- $exeption");
      return ApiResponse.error("não foi possível completar sua chamada!!");
    }
  }
}
