import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

Widget buildUser(TextEditingController _emailController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0,2)
            )
          ]
        ),
        height: 60,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          controller: this._emailController,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.email,
              color: Color(0xff5E3B66),
            ),
            hintText: 'Email',
            hintStyle: TextStyle(
              color: Colors.white
            )
          ),
        ),
      )
    ],
  );
}

Widget buildPassword(TextEditingController _passwordController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: 6,
              offset: Offset(0,2)
            )
          ]
        ),
        height: 60,
        child: TextField(
          obscureText: true,
          controller: this._passwordController,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.lock,
              color: Color(0xff5E3B66),
            ),
            hintText: 'Password',
            hintStyle: TextStyle(
              color: Colors.white
            )
          ),
        ),
      )
    ],
  );
}

Widget buildLoginBtn(BuildContext context) {
  return Container (
    padding: EdgeInsets.symmetric(vertical: 25),
    width: double.infinity,
    child: RaisedButton(
      elevation: 5,
      onPressed: () {
        try {
          context.read<AuthenticationService>().signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
        } on FirebaseAuthException catch (e) {
          print('Failed with error code: ${e.code}');
          print(e.message);
        }
      },
      padding: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      color: Color(0xff5E3B66),
      child: Text(
        'LOGIN',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
      )
    ),
  );
}

Widget buildChangePassword() {
  return Container(
    alignment: Alignment.centerRight,
    child: FlatButton(
      onPressed: () => {
      },
      padding: EdgeInsets.only(right: 0),
      child: Text(
        'Change Password',
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold
        ),
      ),      
    ),
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        child: Stack (
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffffffff),
                    Color(0xffffffff),
                    Color(0xffffffff),
                    Color(0xffffffff),
                  ]
                )
              ),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 120
                ),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  child: Image(
                  image: AssetImage('assets/logo.jpg'),
                  ),
                ),
                SizedBox(height: 50),
                buildUser(_emailController),
                SizedBox(height: 20),
                buildPassword(_passwordController),
                buildLoginBtn(context),
                buildChangePassword(),
              ],
            ),
              ),
            )
          ],
        ),
      ),
    ),

  );
}

}