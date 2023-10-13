import 'package:flutter/material.dart';
import 'package:todo_flutter/src/models/todo_model.dart';

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
  var isActive = false;
  final title = TextEditingController();
  final description = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    if (widget.todo != null) {
      isActive = widget.todo?.isActive ?? false;
      title.text = widget.todo?.title ?? "";
      description.text = widget.todo?.description ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
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
          const SizedBox(
            height: 8,
          ),
          TextField(
            controller: description,
            decoration: const InputDecoration(
              labelText: "Desc",
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
          ),
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
                  isActive = !isActive;
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Done"),
                      Checkbox(
                        value: isActive,
                        onChanged: (value) {
                          isActive = value ?? isActive;
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
            onPressed: () {},
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
