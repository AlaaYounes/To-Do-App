import 'package:flutter/material.dart';
import 'package:to_do/home/homeScreen.dart';
import 'package:to_do/home/tasks/taskDetails.dart';
import 'package:to_do/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do App',
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        TaskDetails.routeName: (context) => TaskDetails(),
      },
      theme: MyTheme.lightTheme,
      themeMode: ThemeMode.light,
      darkTheme: MyTheme.darkTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}