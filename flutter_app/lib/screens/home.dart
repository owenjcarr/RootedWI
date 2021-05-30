import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/services/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: ProduceListWidget(),
      alignment: Alignment(0.0, 0.3),
    );
  }
}

Future<String> getUserEmail() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('email') ?? "";
}

class ProduceListWidget extends StatefulWidget {
  @override
  _ProduceListWidgetState createState() => _ProduceListWidgetState();
}

class Produce {
  final String id;
  final String name;
  final String cost;

  Produce(this.id, this.name, this.cost);
}

List<Produce> createProduceList(http.Response response) {
  Map<String, dynamic> responseJson = jsonDecode(response.body);
  List<dynamic> foo = responseJson['produce'];

  List<Produce> out = [];
  for (var product in foo) {
    debugPrint(product.toString());
    out.add(Produce(product['_id'], product['Name'], product['Cost']));
  }
  return out;
}



class _ProduceListWidgetState extends State<ProduceListWidget> {
  Future<http.Response> _produceFuture;
  Future<http.Response> _balanceFuture;
  String _email = "";

  @override
  void initState() {
    this._produceFuture = getProduceFuture();
    getUserEmail().then(_updateEmail);

    super.initState();
  }

  void _updateEmail(String email) {
    setState(() {
      this._email = email;
    });
    this._balanceFuture = getBalanceFuture(this._email);
  }

  Widget _buildRow(Produce produce) {
    return ListTile(
      title: Text(produce.name, style: GoogleFonts.playfairDisplay()),
      trailing: Text(produce.cost, style: GoogleFonts.playfairDisplay()),
    );
  }

  Widget _buildProduceList() {
    return FutureBuilder<http.Response>(
        future: _produceFuture,
        builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
          if (snapshot.hasData) {
            List<Produce> _produceList = createProduceList(snapshot.data);
            return ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: _produceList.length * 2 - 1,
              itemBuilder: (context, i) {
                if (i.isOdd) return Divider();

                final index = (i ~/ 2);
                return _buildRow(_produceList[index]);
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('An error has occured'),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Retrieving produce for this week'),
                  )
                ],
              ),
            );
          }
        });
  }

  Widget _buildName() {
    return FutureBuilder<http.Response>(
      future: _balanceFuture,
      builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
        String name;
        if (snapshot.hasData) {
          name = getName(snapshot.data);
        }
        else if (snapshot.hasError) {
          name = "Sorry, we couldn't find your name"; // TODO: see how this looks
        } else {
          name = this._email;
        }
        return Text(
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
        );
      }
    );
  }

  Widget _buildBalance() {
    return FutureBuilder<http.Response>(
      future: _balanceFuture,
      builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
        if (snapshot.hasData) {
          int balance = getBalance(snapshot.data);
          return Text(
            'Account Balance: \$$balance',
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              textStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'Playfair Display',
                fontSize: 27,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("Error");
        } else {
          return Text("Retrieving. . .");
        }
      },
    );
  }

  FractionallySizedBox _buildNameBalance() {
    //String name = "FirstName LastName";
    final backgroundColor = Color(0xff637724);
    return FractionallySizedBox(
      alignment: Alignment.center,
      heightFactor: 1.0,
      widthFactor: 1.0,
      child: Container(
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildName(),
            _buildBalance(),
          ],
        ),
      ),
    );
  }

  PopupMenuButton _popupMenuButton(BuildContext context) {
    return PopupMenuButton(
      child: Icon(Icons.more_vert),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: GestureDetector(
            child: TextButton(
              child: Text(
                'Sign out',
                style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.black,
                ),
              ),
            ),
            onTap: () {
              context.read<AuthenticationService>().signOut();
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget produceList = _buildProduceList();
    final title = 'Available Produce This Week';
    final titleColor = Color(0xff5E3B66);
    return Scaffold(
      body: Column(
        // children: [
        // Flexible(flex: 1, child: _buildNameBalance()),

        children: [
          Flexible(
            flex: 1,
            child: Stack(
              children: [
                _buildNameBalance(),
                Positioned(
                  // height: 10,
                  // width: 10,
                  top: 30,
                  left: 10,
                  child: _popupMenuButton(context),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              title,
              style: GoogleFonts.playfairDisplay(
                textStyle: TextStyle(
                  color: titleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
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
