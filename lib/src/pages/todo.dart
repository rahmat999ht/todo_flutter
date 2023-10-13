import 'package:flutter/material.dart';

import '../models/todo_model.dart';
import '../widgets/todos_widget.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
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
