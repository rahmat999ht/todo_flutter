import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/todo_model.dart';

class TodoFirestoreService {
  static final firestore = FirebaseFirestore.instance;

  static CollectionReference<TodoModel> get todos =>
      firestore.collection("todos").withConverter<TodoModel>(
            fromFirestore: (snapshot, options) {
              return TodoModel.fromFirestore(snapshot);
            },
            toFirestore: (todo, options) => todo.toMap(),
          );

  static Stream<QuerySnapshot<TodoModel>> get getsTodo => todos.snapshots();
  static Stream<QuerySnapshot<TodoModel>> get getsDone =>
      todos.where("isDone", isEqualTo: true).snapshots();

  static Future<DocumentSnapshot<TodoModel>> getTodo(String id) {
    return todos.doc(id).get();
  }

  static Future<void> createTodo(TodoModel todo) {
    return todos.add(todo);
  }

  static Future<void> updateTodo(TodoModel todo) {
    return todos.doc(todo.id).update(todo.toMap());
  }

  static Future<void> deleteTodo(String id) {
    return todos.doc(id).delete();
  }
}
