import 'package:flutter/material.dart';

import '../models/todos_model.dart';
import '../services/todo_firestore_service.dart';

import '../widgets/todos_widget.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: TodoFirestoreService.getsTodo,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final todos = TodosModel.fromListQueryDocumentSnapshot(
            snapshot.data!.docs,
          );

          return TodosWidget(todos: todos.values);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
