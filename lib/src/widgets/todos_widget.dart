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
    return ListView.separated(
      itemCount: todos.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return TodoWidget(todo: todos[index]);
      },
    );
  }
}
