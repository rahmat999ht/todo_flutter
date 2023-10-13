import 'package:flutter/material.dart';
import 'package:todo_flutter/src/models/todo_model.dart';

import '../widgets/todo_widget.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  var onChange = false;
  // var _character = Done.fone;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 9,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return TodoWidget(
          todo: TodoModel(
            description: "dd",
            isActive: true,
            title: "dd",
          ),
        );
      },
    );
  }
}
