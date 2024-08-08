import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class Note extends Equatable {
  final String title;
  final String content;
  final int color;
  final int timestamp;
  final int? id;
  const Note({
    required this.title,
    required this.content,
    required this.color,
    required this.timestamp,
    this.id,
  });

  @override
  List<Object?> get props {
    return [
      title,
      content,
      color,
      timestamp,
      id,
    ];
  }

  @override
  String toString() {
    return 'Note(title: $title, content: $content, color: $color, timestamp: $timestamp, id: $id)';
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'color': color,
      'timestamp': timestamp,
      'id': id,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      color: map['color']?.toInt() ?? 0,
      timestamp: map['timestamp']?.toInt() ?? 0,
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));

  Note copyWith({
    String? title,
    String? content,
    int? color,
    int? timestamp,
    ValueGetter<int?>? id,
  }) {
    return Note(
      title: title ?? this.title,
      content: content ?? this.content,
      color: color ?? this.color,
      timestamp: timestamp ?? this.timestamp,
      id: id != null ? id() : this.id,
    );
  }
}
