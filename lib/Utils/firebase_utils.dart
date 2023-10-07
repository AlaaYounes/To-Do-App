import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/taskModel.dart';
import '../models/userModel.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTaskCollection(String uid) {
    var userCollection = getUserCollection();
    return userCollection.doc(uid).collection('tasks').withConverter(
        fromFirestore: (snapshot, options) => Task.fromJson(snapshot.data()!),
        toFirestore: (task, options) => task.toJson());
  }

  static Future<void> addTaskToFireStore(Task task, String? uId) async {
    var taskCollection = FirebaseUtils.getTaskCollection(uId!);
    var document = taskCollection.doc();
    task.id = document.id;
    return await document.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task, String? uId) async {
    var taskCollection = FirebaseUtils.getTaskCollection(uId!);
    await taskCollection.doc(task.id).delete();
  }

  static Future<void> updateTasksFromFireStore(Task task, String? uId) async {
    var taskCollection = FirebaseUtils.getTaskCollection(uId!);
    return await taskCollection.doc(task.id).update({
      'title': task.title,
      'description': task.description,
      'dateTime': task.dateTime?.millisecondsSinceEpoch,
    });
  }

  static Future<void> isDone(Task task, String? uId) async {
    var taskCollection = FirebaseUtils.getTaskCollection(uId!);
    await taskCollection.doc(task.id).update({'isDone': task.isDone});
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionPath)
        .withConverter(
            fromFirestore: (snapshot, options) =>
                MyUser.fromJson(snapshot.data()!),
            toFirestore: (myUser, options) => myUser.toJson());
  }

  static Future<void> addUserToFireStore(MyUser user) async {
    var userCollection = getUserCollection();
    return await userCollection.doc(user.id).set(user);
  }

  static Future<MyUser?> readUserFromFirebase(String? uId) async {
    var querySnapshot = await getUserCollection().doc(uId).get();
    return querySnapshot.data();
  }
}
