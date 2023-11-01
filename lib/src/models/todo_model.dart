import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  final String id;
  final String userId;
  final bool isDone;
  final String title;
  final String descripsion;

  TodoModel({
    required this.id,
    required this.userId,
    required this.isDone,
    required this.title,
    required this.descripsion,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isDone': isDone,
      'userId': userId,
      'title': title,
      'descripsion': descripsion,
    };
  }

  factory TodoModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return TodoModel(
      id: snapshot.id,
      isDone: data?["isDone"] ?? false,
      title: data?["title"] ?? "-",
      descripsion: data?["descripsion"] ?? "-",
      userId: data?["userId"] ?? "-",
    );
  }

  TodoModel copyWith({
    String? id,
    String? userId,
    bool? isDone,
    String? title,
    String? descripsion,
  }) {
    return TodoModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      isDone: isDone ?? this.isDone,
      title: title ?? this.title,
      descripsion: descripsion ?? this.descripsion,
    );
  }
}
