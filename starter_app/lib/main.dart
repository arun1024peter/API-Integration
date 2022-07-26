import 'package:flutter/material.dart';
import 'string.dart' as strings;
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(const GHFlutterApp());

class GHFlutterApp extends StatelessWidget {
  const GHFlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: strings.appTitle,
      home: GHFlutter(),
    );
  }
}

class GHFlutter extends StatefulWidget {
  const GHFlutter({Key? key}) : super(key: key);

  @override
  _GHFlutterState createState() => _GHFlutterState();
}

class _GHFlutterState extends State<GHFlutter> {
  var _members = <dynamic>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(strings.appTitle),
      ),
      body: ListView.separated(
          itemCount: _members.length,
          itemBuilder: (BuildContext context, int position) {
            return _buildRow(position);
          },
          separatorBuilder: (context, index) {
            return const Divider();
          }),
    );
  }

  Future<void> _loadData() async {
    const dataUrl = 'https://gorest.co.in/public/v2/users';
    final response = await http.get(Uri.parse(dataUrl));
    setState(() {
      _members = json.decode(response.body) as List;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Widget _buildRow(int i) {
    return ListTile(
      title: Text('${_members[i]['name']}', style: _biggerFont),
    );
  }
}
