import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/home/tasks/taskItem.dart';
import 'package:to_do/providers/config_provider.dart';
import 'package:to_do/theme.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(
            Duration(days: 365),
          ),
          locale: 'en',
          lastDate: DateTime.now().add(
            Duration(days: 365),
          ),
          onDateSelected: (DateTime) {},
          dayColor: provider.isDark() ? MyTheme.whiteColor : MyTheme.blackColor,
          monthColor:
              provider.isDark() ? MyTheme.whiteColor : MyTheme.blackColor,
        ),
        Expanded(
          child: ListView.builder(
              itemBuilder: (context, index) => TaskItem(), itemCount: 10),
        ),
      ],
    );
  }
}
