import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Auth {
  Dio dio = new Dio();

  login(email, password) async {
    try {
      return await dio.post('http://10.0.2.2:8000/api/auth/', data: {
        "email": email,
        "password": password
      },  options: Options(contentType: Headers.jsonContentType)
      );
    }
    on DioError catch(e) {
      Fluttertoast.showToast(msg: e.response.data['msg'],
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
      );
    }
  }
}