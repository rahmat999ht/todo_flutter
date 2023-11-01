import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_flutter/src/models/todo_model.dart';
import 'package:todo_flutter/src/services/todo_firestore_service.dart';

class FormTodoWidget extends StatefulWidget {
  final TodoModel? todo;

  const FormTodoWidget({
    super.key,
    this.todo,
  });

  @override
  State<FormTodoWidget> createState() => _FormTodoWidgetState();
}

class _FormTodoWidgetState extends State<FormTodoWidget> {
  var isErrorDescripsion = false;
  var isErrorTitle = false;

  var isDone = false;
  final title = TextEditingController();
  final descripsion = TextEditingController();

  @override
  void initState() {
    isDone = widget.todo?.isDone ?? false;
    title.text = widget.todo?.title ?? "";
    descripsion.text = widget.todo?.descripsion ?? "";

    super.initState();
  }

  onSubmit() async {
    final user = FirebaseAuth.instance.currentUser;
    final data = TodoModel(
      id: widget.todo?.id ?? "_",
      userId: user?.email ?? "-",
      isDone: isDone,
      title: title.text,
      descripsion: descripsion.text,
    );

    log(data.toMap().toString());

    final isError = descripsion.text.isEmpty || title.text.isEmpty;

    if (title.text.isEmpty) {
      isErrorTitle = true;
    }

    if (descripsion.text.isEmpty) {
      isErrorDescripsion = true;
    }

    if (isError) {
      setState(() {});
      return;
    }

    if (widget.todo != null) {
      await TodoFirestoreService.updateTodo(data).then(
        (_) => Navigator.pop(context),
      );
      return;
    }

    await TodoFirestoreService.createTodo(data).then(
      (_) => Navigator.pop(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: title,
            decoration: const InputDecoration(
              labelText: "Title",
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
          ),
          if (isErrorTitle) ...[
            const SizedBox(
              height: 4,
            ),
            Text(
              "Title Tidak Boleh Kosong",
              style: TextStyle(color: Colors.red.shade700, fontSize: 14),
            ),
          ],
          const SizedBox(
            height: 8,
          ),
          TextField(
            controller: descripsion,
            decoration: const InputDecoration(
              labelText: "Desc",
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
          ),
          if (isErrorDescripsion) ...[
            const SizedBox(
              height: 4,
            ),
            Text(
              "Descripsion Tidak Boleh Kosong",
              style: TextStyle(color: Colors.red.shade700, fontSize: 14),
            ),
          ],
          const SizedBox(
            height: 8,
          ),
          if (widget.todo != null) ...[
            Container(
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  isDone = !isDone;
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Done"),
                      Checkbox(
                        value: isDone,
                        onChanged: (value) {
                          isDone = value ?? isDone;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(size.width, 40),
              backgroundColor: Colors.deepPurple,
            ),
            onPressed: onSubmit,
            child: Text(
              widget.todo != null ? "Update" : "Create",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
