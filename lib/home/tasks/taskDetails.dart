import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do/theme.dart';

class TaskDetails extends StatefulWidget {
  static String routeName = 'TaskDetails';

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  String selectedDate = DateFormat('dd-MM-yyyy ').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Task',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'Title',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: MyTheme.blackColor.withOpacity(.5), fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
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
                height: 20,
              ),
              Text(
                'Description',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: MyTheme.blackColor.withOpacity(.5), fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
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
                height: 20,
              ),
              Text(
                'Task Date',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: MyTheme.blackColor.withOpacity(.5), fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
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
                height: MediaQuery.of(context).size.height * .2,
              ),
              InkWell(
                onTap: () {},
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
                    'Save Changes',
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
