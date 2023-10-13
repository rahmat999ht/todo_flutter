import 'dart:convert';

class TodoModel {
  final bool isActive;
  final String title;
  final String description;

  TodoModel({
    required this.isActive,
    required this.title,
    required this.description,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isActive': isActive,
      'title': title,
      'description': description,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      isActive: map['isActive'] as bool,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) => TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}