import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String apiurl = "https://jsonplaceholder.typicode.com/users";

  List<dynamic> _users = [];

  void fetchUsers() async {
    var response = await http.get(Uri.parse(apiurl));
    setState(() {
      _users = json.decode(response.body);
    });
  }

  Future<void> _getData() async {
    setState(() {
      fetchUsers();
    });
  }

  @override
  void initState() {
    fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text(
            'API Integration',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Container(
        child: _users.isNotEmpty
            ? RefreshIndicator(
                child: ListView.builder(
                    padding: const EdgeInsets.all(6),
                    itemCount: _users.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.all(2.0),
                        child: ListTile(
                          title: Text("Name :" + _users[index]['name']),
                          subtitle: Text("Email :" + _users[index]['email']),
                          trailing:
                              Text("Username :" + _users[index]['username']),
                          tileColor: Colors.red[100],
                        ),
                      );
                    }),
                onRefresh: _getData,
              )
            : const Center(
                child: Text(
                  'No results found',
                  style: TextStyle(fontSize: 24),
                ),
              ),
      ),
    );
  }
}
