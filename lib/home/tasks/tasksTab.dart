import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/home/tasks/taskItem.dart';
import 'package:to_do/providers/config_provider.dart';
import 'package:to_do/providers/db_provider.dart';
import 'package:to_do/theme.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime selectDate = DateTime.now();
    var provider = Provider.of<AppConfigProvider>(context);
    var dbProvider = Provider.of<DBProvider>(context);
    if (dbProvider.taskList.isEmpty) {
      dbProvider.getTasksFromFireStore();
    }
    return Column(
      children: [
        CalendarTimeline(
          initialDate: dbProvider.selectDate,
          firstDate: DateTime.now().subtract(
            Duration(days: 365),
          ),
          locale: 'en',
          lastDate: DateTime.now().add(
            Duration(days: 365),
          ),
          onDateSelected: (date) {
            dbProvider.changeDate(date);
          },
          dayColor: provider.isDark() ? MyTheme.whiteColor : MyTheme.blackColor,
          monthColor:
              provider.isDark() ? MyTheme.whiteColor : MyTheme.blackColor,
        ),
        Expanded(
          child: ListView.builder(
              itemBuilder: (context, index) => TaskItem(
                    task: dbProvider.taskList[index],
                  ),
              itemCount: dbProvider.taskList.length),
        ),
      ],
    );
  }
}
