import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/todos_model.dart';
import '../services/todo_firestore_service.dart';
import '../widgets/todos_widget.dart';

class DonePage extends StatefulWidget {
  const DonePage({super.key});

  @override
  State<DonePage> createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  final user = FirebaseAuth.instance.currentUser?..reload();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: TodoFirestoreService.getsTodo(user?.email ?? "-"),
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
