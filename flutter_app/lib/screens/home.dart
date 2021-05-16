import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  final String id;
  final String name;
  final String cost;

  Produce(this.id, this.name, this.cost);
}

Future<http.Response> getProduceFuture() {
  String base = '10.0.2.2:8000';//@TODO: figure out what to change this to in production
  return http.get(
    Uri.http(base, 'api/produce'),
    headers: <String, String> {
      'Content-Type': 'application/json; charset=UTF-8',
    }
  );
}

List<Produce> createProduceList(http.Response response) {
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    List<dynamic> foo = responseJson['produce'];

    List<Produce> out = [];
    for(var product in foo) {
      debugPrint(product.toString());
      out.add(Produce(product['_id'], product['Name'], product['Cost']));
    }
    return out;
}

class _ProduceListWidgetState extends State<ProduceListWidget> {
  final Future<http.Response> _produceFuture = getProduceFuture();

  Widget _buildRow(Produce produce) {
    debugPrint(produce.name);
    debugPrint(produce.cost);
    return ListTile(
      title: Text(produce.name),
      trailing: Text(produce.cost),
    );
  }

  Widget _buildProduceList() {
    final title = 'Available Produce This Week';

    const titleColor = Color(0xff5E3B66);
    return FutureBuilder<http.Response>(
      future: _produceFuture,
      builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
        if (snapshot.hasData) {
          List<Produce> _produceList = createProduceList(snapshot.data);
          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: _produceList.length*2+2,
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

              final index = (i ~/ 2)-1;
              return _buildRow(_produceList[index]);
            },
          );
        } else if(snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children : const <Widget>[
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
        } else{
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children : const <Widget>[
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
      }
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
