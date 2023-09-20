import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do App'),
      ),
    );
  }
}
