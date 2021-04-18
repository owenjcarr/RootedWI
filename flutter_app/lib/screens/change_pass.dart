import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MaterialApp(
  home: Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Transform.rotate(angle:270*pi/180,child: Container(
              height: 125,
              width: 125,
              child: CustomPaint(painter: ShapesPainter(Color(0xffC98028)))
            ))
            ,Container(
              height: 125,
              width: 125,
              child: CustomPaint(painter: ShapesPainter(Color(0xff5698A4)))
            )
          ],
          ),
        Column(
          children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Change      ", style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color:Color(0xff5E3B66),fontFamily: 'PlayfairDisplay'),),
              Text("Password.", style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color:Color(0xff5E3B66),fontFamily: 'PlayfairDisplay')),
              Text(" "),
              Text(" "),
              Container(height: 90, width: 250, child: TextField(obscureText: true,decoration: InputDecoration(border:OutlineInputBorder(), labelText: "Enter email", filled:true,fillColor: Colors.purple[100]))),
              Container(height: 90, width: 250, child: TextField(obscureText: true,decoration: InputDecoration(border:OutlineInputBorder(), labelText: "New password", filled:true,fillColor: Colors.purple[100]))),
              Text("  "),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 190,
                    height: 50,
                    child:
                    ConstrainedBox(
                      constraints: BoxConstraints.tightFor(width: 60, height: 60),
                      child: ElevatedButton(
                        child: Icon(Icons.arrow_forward_sharp),                      
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          primary: Color(0xff5E3B66)
                        ),
                      ),
                    ),              
                  )
                ],
              ),
              Text("  "),
              Text("  "),
              Text("  "),
              Text("  "),
            ],            
          ),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Transform.rotate(angle:180*pi/180,child:Container(
              height: 125,
              width: 125,
              child: CustomPaint(painter: ShapesPainter(Color(0xff5698A4)))
            )),
            Transform.rotate(angle:90*pi/180,child:Container(
              height: 125,
              width: 125,
              child: CustomPaint(painter: ShapesPainter(Color(0xffC98028)))
            )),            
          ]
          ),
      ],
    ),
  )
));


class ShapesPainter extends CustomPainter {
  final Color color;

  ShapesPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = color;
    // create a path
    var path = Path();
   path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - size.height, 0);
    // close the path to form a bounded shape
    path.close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// import 'package:flutter/material.dart';

// class ChangePassScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text('Change Password Screen')
//     );
//   }
// }


