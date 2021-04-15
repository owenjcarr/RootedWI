import 'package:flutter/material.dart';

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
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.green,
    //     title: Text(title),
    //   ),
    return Scaffold(
      body: _buildProduceList(),
    );
  }
}
