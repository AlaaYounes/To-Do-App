import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Utils/firebase_utils.dart';
import 'package:to_do/models/taskModel.dart';
import 'package:to_do/providers/auth_provider.dart';
import 'package:to_do/providers/db_provider.dart';
import 'package:to_do/theme.dart';
import 'package:toast/toast.dart';
class TaskBottomSheet extends StatefulWidget {
  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}
class _TaskBottomSheetState extends State<TaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    ToastContext().init(context);
    var provider = Provider.of<DBProvider>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                AppLocalizations.of(context)!.task_title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: MyTheme.blackColor.withOpacity(.5), fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: titleController,
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'enter a title for task';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'This is title',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: MyTheme.greyColor, fontSize: 20),
                ),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: MyTheme.blackColor, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                AppLocalizations.of(context)!.task_description,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: MyTheme.blackColor.withOpacity(.5), fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: descriptionController,
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'enter a description for task';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Task details',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: MyTheme.greyColor, fontSize: 20),
                ),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: MyTheme.blackColor, fontSize: 20),
                maxLines: null,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                AppLocalizations.of(context)!.task_date,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: MyTheme.blackColor.withOpacity(.5), fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  var chosenDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (chosenDate != null) {
                    selectedDate = chosenDate;
                  }
                  setState(() {});
                },
                child: Text(
                  '${DateFormat('dd-MM-yyyy ').format(selectedDate)}',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: MyTheme.blackColor, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              InkWell(
                onTap: () {
                  if (formKey.currentState!.validate() != null) {
                    Task task = Task(
                      title: titleController.text,
                      description: descriptionController.text,
                      dateTime: selectedDate,
                    );

                    FirebaseUtils.addTaskToFireStore(
                            task, authProvider.currentUser!.id)
                        .timeout(Duration(milliseconds: 500), onTimeout: () {
                      Navigator.pop(context);
                      Toast.show("task added successfully",
                          duration: Toast.lengthLong, gravity: Toast.bottom);
                    });
                    provider
                        .getTasksFromFireStore(authProvider.currentUser!.id);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: MyTheme.blueColor,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.add_task,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: MyTheme.whiteColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
