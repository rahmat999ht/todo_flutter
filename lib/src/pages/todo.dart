import 'package:flutter/material.dart';

import '../models/todo_model.dart';
import '../widgets/todos_widget.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return TodosWidget(
      todos: [
        TodoModel(isActive: true, title: "dasd", description: "description"),
        TodoModel(isActive: false, title: "dasd", description: "description"),
        TodoModel(isActive: false, title: "dasd", description: "description"),
      ],
    );
  }
}
