import 'package:flutter/material.dart';

import '../models/todo_model.dart';
import '../widgets/todos_widget.dart';

class DonePage extends StatefulWidget {
  const DonePage({super.key});

  @override
  State<DonePage> createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  @override
  Widget build(BuildContext context) {
    return TodosWidget(
      todos: [
        TodoModel(isActive: true, title: "dasd", description: "description"),
        // TodoModel(isActive: false, title: "dasd", description: "description"),
        // TodoModel(isActive: false, title: "dasd", description: "description"),
      ],
    );
  }
}
