import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_flutter/src/models/todo_model.dart';

class TodosModel {
  final List<TodoModel> values;

  const TodosModel({required this.values});

  factory TodosModel.fromListQueryDocumentSnapshot(List<QueryDocumentSnapshot<TodoModel>> docs) {
    return TodosModel(
      values: docs.map((e) => e.data()).toList(),
    );
  }
}
