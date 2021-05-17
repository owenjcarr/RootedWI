import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ProduceList(),
      alignment: Alignment(0.0, 0.3),
    );
  }
}

class ProduceList extends StatefulWidget {
  @override
  _ProduceListState createState() => _ProduceListState();
}

class _ProduceListState extends State<ProduceList> {
  Widget _buildRow(num index) {
    return ListTile(
      title: Text(
        'Produce-$index',
        style: GoogleFonts.playfairDisplay(),
      ),
      trailing: Text(
        'Price-$index',
        style: GoogleFonts.playfairDisplay(),
      ),
    );
  }

  ListView _buildProduceList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: 50,
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2;
        return _buildRow(index);
      },
    );
  }

  FractionallySizedBox _buildNameBalance() {
    String name = "FirstName LastName";
    final backgroundColor = Color(0xff637724);
    double balance = 3000.00;
    return FractionallySizedBox(
      alignment: Alignment.center,
      heightFactor: 1.0,
      widthFactor: 1.0,
      child: Container(
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              name,
              // Center if name is too long and split into two lines
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Playfair Display',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              "Account Balance: \$" + balance.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Playfair Display',
                  fontSize: 27,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget produceList = _buildProduceList();
    final title = 'Available Produce This Week';
    final titleColor = Color(0xff5E3B66);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Hello"),
      //   leading: GestureDetector(
      //     child: Icon(
      //       Icons.navigate_before, // add custom icons also
      //     ),
      //     onTap: () {
      //       context.read<AuthenticationService>().signOut();
      //     },
      //   ),
      // ),
      body: Column(
        children: [
          // _buildNameBalance(),
          Flexible(flex: 1, child: _buildNameBalance()),
          Container(
            alignment: Alignment.center,
            child: Text(
              title,
              style: GoogleFonts.playfairDisplay(
                textStyle: TextStyle(
                    color: titleColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: produceList,
          ),
        ],
      ),
    );
  }
}
