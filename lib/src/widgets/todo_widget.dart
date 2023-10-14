import 'package:flutter/material.dart';
import 'package:todo_flutter/src/models/todo_model.dart';
import 'package:todo_flutter/src/pages/update.dart';

import '../services/todo_firestore_service.dart';
import '../utils/page_navigation_opacity.dart';

class TodoWidget extends StatelessWidget {
  final TodoModel todo;
  const TodoWidget({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    onDelete() {
      TodoFirestoreService.deleteTodo(todo.id);
    }

    onUpdate() {
      PageNavigationOpacity.toPage(
        context,
        UpdatePage(
          todo: todo,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: todo.isDone,
                onChanged: (v) {
                  TodoFirestoreService.updateTodo(
                    todo.copyWith(isDone: v ?? todo.isDone),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      todo.descripsion,
                      style: const TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 32,
            // width: 32,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 32,
                  width: 32,
                  child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    color: Colors.deepPurple,
                    splashColor: Colors.deepPurple,
                    splashRadius: 24,
                    icon: const Icon(Icons.create_rounded),
                    onPressed: onUpdate,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: VerticalDivider(),
                ),
                SizedBox(
                  height: 32,
                  width: 32,
                  child: IconButton(
                      padding: const EdgeInsets.all(0.0),
                      color: Colors.red.shade700,
                      splashRadius: 24,
                      splashColor: Colors.red.shade700,
                      icon: const Icon(
                        Icons.delete,
                      ),
                      onPressed: onDelete),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
