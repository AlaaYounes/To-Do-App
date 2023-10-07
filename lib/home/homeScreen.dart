import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/home/settings/settings.dart';
import 'package:to_do/home/tasks/taskBottomSheet.dart';
import 'package:to_do/home/tasks/tasksTab.dart';
import 'package:to_do/login_screen/loginScreen.dart';
import 'package:to_do/providers/auth_provider.dart';
import 'package:to_do/providers/db_provider.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var dbProvider = Provider.of<DBProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
                '${AppLocalizations.of(context)!.app_title} ${authProvider.currentUser!.name}'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              dbProvider.taskList = [];
              authProvider.currentUser = null;
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: AppLocalizations.of(context)!.tasks),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: AppLocalizations.of(context)!.settings),
          ],
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showTaskBottomSheet();
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [
    TasksTab(),
    SettingsTab(),
  ];

  void showTaskBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => TaskBottomSheet());
  }
}
