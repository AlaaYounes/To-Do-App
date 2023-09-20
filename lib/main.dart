import 'package:flutter/material.dart';
import 'package:to_do/home/homeScreen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    title: 'To Do App',
    initialRoute: HomeScreen.routeName,
    routes: {
      HomeScreen.routeName :  (context) => HomeScreen(),
    }
  );
  }
}