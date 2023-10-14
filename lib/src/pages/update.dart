import 'package:flutter/material.dart';
import 'package:todo_flutter/src/widgets/form_todo_widget.dart';

import '../models/todo_model.dart';

class UpdatePage extends StatelessWidget {
  final TodoModel todo;
  const UpdatePage({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo Update"),
      ),
      body: FormTodoWidget(
        todo: todo
      ),
    );
  }
}
