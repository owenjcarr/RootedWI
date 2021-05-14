import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ProduceListWidget(),
      alignment: Alignment(0.0, 0.3),
    );
  }
}

class ProduceListWidget extends StatefulWidget {
  @override
  _ProduceListWidgetState createState() => _ProduceListWidgetState();
}

class Produce {
  final int id;
  final String name;
  final String cost;

  Produce({this.id, this.name, this.cost});
  
  factory Produce.fromJson(Map<String, dynamic> json) {
    return Produce(
      id: json['id'],
      name: json['name'],
      cost: json['cost'],
    );
  }

}
Future<http.Response> getProduce() {
  String base = '10.0.2.2';//@TODO: figure out what to change this to in production
  return http.post(
    Uri.https(base, 'api/produce'),
    headers: <String, String> {
      'Content-Type': 'application/json; charset=UTF-8',
    }
  );
}

Future<List<Produce>> createProduceList() async{
  final response = await getProduce();
  print(response);
}

class _ProduceListWidgetState extends State<ProduceListWidget> {
  final ProduceList = <Produce>[];
  Widget _buildRow(num index) {
    return ListTile(
      title: Text('Produce-$index'),
      trailing: Text('Price-$index'),
    );
  }

  Widget _buildProduceList() {
    final title = 'Available Produce This Week';
    const titleColor = Color(0xff5E3B66);
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: 50,
      itemBuilder: (context, i) {
        if (i == 0) {
          return Column(
            children: <Widget>[
              Text(title,
                  style: TextStyle(
                      // color: Colors.purple,
                      color: titleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0)),
            ],
          );
        }
        if (i.isOdd) return Divider();

        final index = i ~/ 2;
        return _buildRow(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
        leading: GestureDetector(
          child: Icon(
            Icons.navigate_before, // add custom icons also
          ),
          onTap: () {
            context.read<AuthenticationService>().signOut();
          },
        ),
      ),
      body: _buildProduceList(),
    );
  }
}
