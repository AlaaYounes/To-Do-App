import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:to_do/theme.dart';

class TaskBottomSheet extends StatefulWidget {
  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  String selectedDate = DateFormat('dd-MM-yyyy ').format(DateTime.now());
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      .copyWith(color: MyTheme.blackColor, fontSize: 20),
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
                      .copyWith(color: MyTheme.blackColor, fontSize: 20),
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
              TextFormField(
                controller: dateController,
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'enter a date for task';
                  }
                },
                keyboardType: TextInputType.none,
                decoration: InputDecoration(
                  hintText: '$selectedDate',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: MyTheme.blackColor, fontSize: 20),
                ),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: MyTheme.blackColor, fontSize: 20),
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  ).then((value) {
                    selectedDate = DateFormat('dd-MM-yyyy').format(value!);
                  });
                  print(selectedDate);
                  setState(() {});
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              InkWell(
                onTap: () {
                  formKey.currentState!.validate();
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
