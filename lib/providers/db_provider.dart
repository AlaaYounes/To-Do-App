import 'package:flutter/material.dart';
import 'package:to_do/Utils/firebase_utils.dart';

import '../models/taskModel.dart';

class DBProvider extends ChangeNotifier {
  List<Task> taskList = [];
  DateTime selectDate = DateTime.now();

  getTasksFromFireStore(String? uId) async {
    var taskCollection = FirebaseUtils.getTaskCollection(uId!);
    var querySnapshot = await taskCollection.get();
    taskList = querySnapshot.docs.map((doc) => doc.data()).toList();

    /// sorting
    taskList.sort((task1, task2) => task1.dateTime!.compareTo(task2.dateTime!));

    /// filtering date
    taskList = taskList.where((task) {
      if (task.dateTime?.day == selectDate.day &&
          task.dateTime?.month == selectDate.month &&
          task.dateTime?.year == selectDate.year) {
        return true;
      }
      return false;
    }).toList();
    notifyListeners();
  }

  changeDate(DateTime newDate, String? uId) {
    selectDate = newDate;
    getTasksFromFireStore(uId);
  }
}
