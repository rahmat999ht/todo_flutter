import 'package:flutter/material.dart';
import 'package:todo_flutter/src/widgets/form_todo_widget.dart';

import '../models/todo_model.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo Update"),
      ),
      body: FormTodoWidget(
        todo: TodoModel(
          isActive: true,
          title: "dasd",
          description: "description",
        ),
      ),
    );
  }
}
