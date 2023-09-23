import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:to_do/home/tasks/taskItem.dart';
import 'package:to_do/theme.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
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
          dayColor: MyTheme.blackColor,
        ),
        Expanded(
          child: ListView.builder(
              itemBuilder: (context, index) => TaskItem(), itemCount: 10),
        ),
      ],
    );
  }
}
