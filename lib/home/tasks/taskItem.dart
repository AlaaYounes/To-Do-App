import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do/home/tasks/taskDetails.dart';
import 'package:to_do/models/taskModel.dart';
import 'package:to_do/providers/config_provider.dart';
import 'package:to_do/providers/db_provider.dart';
import 'package:to_do/theme.dart';

class TaskItem extends StatefulWidget {
  late Task task;

  TaskItem({required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var dbProvider = Provider.of<DBProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: .25,
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                dbProvider.deleteTaskFromFireStore(widget.task);
                dbProvider.getTasksFromFireStore();
              },
              backgroundColor: MyTheme.redColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete_task,
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TaskDetails(
                          task: widget.task,
                        )));
          },
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: provider.isDark() ? MyTheme.navyBlue : MyTheme.whiteColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: VerticalDivider(
                        thickness: 4,
                        endIndent: 10,
                        indent: 10,
                        color: MyTheme.blueColor,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.task.title ?? '',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.task.description ?? '',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ),
                widget.task.isDone!
                    ? Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          'Done!',
                          style: TextStyle(
                            color: MyTheme.greenColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Visibility(
                          child: InkWell(
                            onTap: () {
                              widget.task.isDone = true;
                              dbProvider.isDone(widget.task).timeout(
                                  Duration(milliseconds: 100), onTimeout: () {
                                print('done');
                              });
                              setState(() {});
                            },
                            child: Container(
                              height: 40,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: MyTheme.blueColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Icon(
                                Icons.check,
                                color: MyTheme.whiteColor,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
