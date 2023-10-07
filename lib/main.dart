import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/login_screen/loginScreen.dart';
import 'package:to_do/providers/auth_provider.dart';
import 'package:to_do/providers/config_provider.dart';
import 'package:to_do/providers/db_provider.dart';
import 'package:to_do/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => AppConfigProvider()),
        ChangeNotifierProvider(create: (context) => DBProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      title: 'To Do List',
      home: LoginScreen(),
      // initialRoute: HomeScreen.routeName,
      // routes: {
      //   HomeScreen.routeName: (context) => HomeScreen(),
      // },
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
