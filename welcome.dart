import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Welcome extends StatefulWidget {

@override
  _Welcome createState() => _Welcome();

}

Widget buildText() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 50),
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
        height: 200,
        child: TextField(
          obscureText: true,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            hintText: ' Text will go here',
            hintStyle: TextStyle(
              color: Colors.white
            )
          ),
        ),
      )
    ],
  );
}

Widget buildLoginBtn() {
  return Container (
    padding: EdgeInsets.symmetric(vertical: 50),
    width: double.infinity,
    child: RaisedButton(
      elevation: 5,
      onPressed: () => print('Login Pressed'),
      padding: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      color: Colors.white,
      child: Text(
        'LOGIN',
        style: TextStyle(
          color: Color(0xff5E3B66),
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
      )
    ),
  );
}

class _Welcome extends State<Welcome> {

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
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
                  physics: NeverScrollableScrollPhysics(),
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
                new Container(
                  child: Text(
                    'Welcome to Rooted!',
                    style: TextStyle(
                      color: Color(0xff5E3B66),
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                )
                ),
                buildText(),
                buildLoginBtn(),
                ],
              ),
                ),



              
              )
            ],
          ),
        ),
        
      )
    );
  }

}