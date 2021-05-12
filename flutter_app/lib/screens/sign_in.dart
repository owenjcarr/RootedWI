import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email'
            ),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password'
            ),
          ),
          SizedBox(height: 10.0),
          RaisedButton(
            child: Text('Login'),
            color: Colors.blue,
            onPressed: () {
              context.read<AuthenticationService>().signIn(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim(),
              );
            },
          )
        ],
      )
    );
  }
}