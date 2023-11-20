import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  var isErrorTime = false;
  var isErrorDate = false;

  var isDone = false;
  final title = TextEditingController();
  final descripsion = TextEditingController();
  final time = TextEditingController();
  final date = TextEditingController();

  String dateFormat = 'dd MMMM yyyy';
  String dateTanggalFormat = 'dd/MM/yyyy';
  List<String> listMonth = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember",
  ];

  @override
  void initState() {
    isDone = widget.todo?.isDone ?? false;
    title.text = widget.todo?.title ?? "";
    descripsion.text = widget.todo?.descripsion ?? "";
    final getDate = widget.todo?.dateTime.toDate();
    final jam = getDate?.hour.toString() ?? "";
    final menit = getDate?.minute.toString() ?? "";
    final day = getDate?.day.toString() ?? "";
    final month = listMonth[getDate!.month - 1];
    final year = getDate.year.toString();
    time.text = '$jam : $menit';
    date.text = '$day $month $year';

    super.initState();
  }

  Future<String> getTime(
    BuildContext context,
  ) async {
    final data = await selectTime(context, TimeOfDay.now());
    if (data != null) {
      final hour = data.hour.toString().padLeft(2, '0');
      final minute = data.minute.toString().padLeft(2, '0');
      final formattedTime = "$hour : $minute";
      return formattedTime;
    }

    return "";
  }

  Future<TimeOfDay?> selectTime(
    BuildContext context,
    TimeOfDay initialDate,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      helpText: "Pilih Waktu",
      cancelText: "BATAL",
      confirmText: "OKE",
      hourLabelText: "Jam",
      minuteLabelText: "Menit",
      initialTime: initialDate,
    );
    if (picked != null && picked != initialDate) {
      return picked;
    }
    return null;
  }

  Future<String> getDate(BuildContext context, [bool isTanggal = false]) async {
    final data = await selectDate(context, DateTime.now());
    if (data != null) {
      final dateFormatter = DateFormat(dateFormat, "id_ID");
      final dateTanggalFormatter = DateFormat(dateTanggalFormat, "id_ID");
      final formattedDate = isTanggal
          ? dateTanggalFormatter.format(data)
          : dateFormatter.format(data);
      return formattedDate;
    }
    return "";
  }

  static Future<DateTime?> selectDate(
    BuildContext context,
    DateTime initialDate,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      return picked;
    }
    return null;
  }

  onSubmit() async {
    TimeOfDay jam = TimeOfDay(
      hour: int.parse(time.text.split(':')[0]),
      minute: int.parse(time.text.split(':')[1]),
    );

    DateFormat inputFormat = DateFormat("dd MMMM yyyy", "id_ID");
    DateTime tanggal = inputFormat.parse(date.text);

    DateTime initDateTime = DateTime(
      tanggal.year,
      tanggal.month,
      tanggal.day,
      jam.hour,
      jam.minute,
    );
    Timestamp dateTime = Timestamp.fromDate(initDateTime);

    final user = FirebaseAuth.instance.currentUser;
    final data = TodoModel(
        id: widget.todo?.id ?? "_",
        userId: user?.email ?? "-",
        isDone: isDone,
        title: title.text,
        descripsion: descripsion.text,
        dateTime: dateTime);

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
          formField(
            title: 'Title',
            controller: title,
            isError: isErrorTitle,
          ),
          formField(
            title: 'Desc',
            controller: descripsion,
            isError: isErrorDescripsion,
          ),
          formField(
            title: 'Time',
            controller: time,
            isError: isErrorTime,
            onTap: () async {
              time.text = await getTime(context);
            },
          ),
          formField(
            title: 'Date',
            controller: date,
            isError: isErrorDate,
            onTap: () async {
              date.text = await getDate(context);
            },
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

Column formField({
  required String title,
  required TextEditingController controller,
  required bool isError,
  void Function()? onTap,
}) {
  return Column(
    children: [
      TextField(
        controller: controller,
        onTap: onTap ?? () {},
        decoration: InputDecoration(
          labelText: title,
          border: const OutlineInputBorder(
            borderSide: BorderSide(),
          ),
        ),
      ),
      if (isError) ...[
        const SizedBox(
          height: 4,
        ),
        Text(
          "$title Tidak Boleh Kosong",
          style: TextStyle(color: Colors.red.shade700, fontSize: 14),
        ),
      ],
      const SizedBox(
        height: 8,
      ),
    ],
  );
}
