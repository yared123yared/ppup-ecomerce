// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'dart:convert';

Todo todoFromJson(String str) => Todo.fromJson(json.decode(str));

String todoToJson(Todo data) => json.encode(data.toJson());

class Todo {
  Todo({
    this.listPosts,
  });

  List<ListPost>? listPosts;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        listPosts: json['listPosts'] == null
            ? null
            : List<ListPost>.from(
                json['listPosts'].map((x) => ListPost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'listPosts': listPosts == null
            ? null
            : List<dynamic>.from(listPosts!.map((x) => x.toJson())),
      };
}

class ListPost {
  ListPost({
    this.id,
    this.title,
    this.content,
  });

  String? id;
  String? title;
  String? content;

  factory ListPost.fromJson(Map<String, dynamic> json) => ListPost(
        id: json['id'],
        title: json['title'],
        content: json['content'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
      };
}
