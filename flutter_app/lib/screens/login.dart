import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var email, password, token;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Email'
            ),
            onChanged: (val) {
              email = val;
            },
          ),
          TextField(
            obscureText:  true,
            decoration: InputDecoration(
              labelText: 'Password'
            ),
            onChanged: (val) {
              password = val;
            },
          ),
          SizedBox(height: 10.0),
          RaisedButton(
            child: Text('Login'),
            color: Colors.blue,
            onPressed: () 
              async {
              var dio = Dio();
              var response; 
              try {
                response = await dio.post('http://10.0.2.2:8000/api/auth/', data: {'email': email, 'password': password});
              } catch (e) {
                response = e;
              }

              print(response.toString());
              
              /*
              Auth().login(email, password).then((val) {
                if (val.data['success']) {
                  token = val.data['token'];
                  Fluttertoast.showToast(
                    msg: 'Logged In',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                    );
                }
              });
              */
            },
          )
        ],
      )
    );
  }
}