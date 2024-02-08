import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  final dynamic user;

  UserScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user['name']),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Name: ${user['name']}'),
            Text('Email: ${user['email']}'),
            Text('Phone: ${user['phone']}'),
            Text('Address: ${user['address']}'),
            Image.network(user['photo']),
          ],
        ),
      ),
    );
  }
}