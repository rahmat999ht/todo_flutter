import 'package:flutter/material.dart';

import '../models/todo_model.dart';
import 'todo_widget.dart';

class TodosWidget extends StatelessWidget {
  final List<TodoModel> todos;
  const TodosWidget({
    super.key,
    required this.todos,
  });

  @override
  Widget build(BuildContext context) {
    return todos.isEmpty
        ? const Center(
            child: Text(
              "Masih Kosong",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : ListView.separated(
            itemCount: todos.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return TodoWidget(todo: todos[index]);
            },
          );
  }
}
