import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/home/homeScreen.dart';
import 'package:to_do/home/tasks/taskDetails.dart';
import 'package:to_do/providers/config_provider.dart';
import 'package:to_do/theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => AppConfigProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppConfigProvider provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      title: 'To Do List',
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        TaskDetails.routeName: (context) => TaskDetails(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: provider.locale,
      theme: MyTheme.lightTheme,
      themeMode: provider.appTheme,
      darkTheme: MyTheme.darkTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
