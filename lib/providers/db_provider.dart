import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/taskModel.dart';

class DBProvider extends ChangeNotifier {
  List<Task> taskList = [];
  DateTime selectDate = DateTime.now();

  static CollectionReference<Task> getTaskCollection() {
    return FirebaseFirestore.instance.collection('tasks').withConverter(
        fromFirestore: (snapshot, options) => Task.fromJson(snapshot.data()!),
        toFirestore: (task, options) => task.toJson());
  }

  Future<void> addTaskToFireStore(Task task) async {
    var taskCollection = getTaskCollection();
    var document = taskCollection.doc();
    task.id = document.id;
    return await document.set(task);
  }

  getTasksFromFireStore() async {
    var taskCollection = getTaskCollection();
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

  Future<void> updateTasksFromFireStore(Task task) async {
    var taskCollection = getTaskCollection();
    return await taskCollection.doc(task.id).update({
      'title': task.title,
      'description': task.description,
      'dateTime': task.dateTime,
    });
  }

  Future<void> isDone(Task task) async {
    var taskCollection = getTaskCollection();
    await taskCollection.doc(task.id).update({'isDone': task.isDone});
    notifyListeners();
  }

  Future<void> deleteTaskFromFireStore(Task task) async {
    var taskCollection = getTaskCollection();
    await taskCollection.doc(task.id).delete();
    notifyListeners();
  }

  changeDate(DateTime newDate) {
    selectDate = newDate;
    getTasksFromFireStore();
  }
}
