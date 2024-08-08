import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_note_app/domain/entities/note.dart';

class NoteModel extends Equatable {
  final String title;
  final String content;
  final int color;
  final int timestamp;
  final int? id;
  const NoteModel({
    required this.title,
    required this.content,
    required this.color,
    required this.timestamp,
    this.id,
  });

  Note toEntity() {
    return Note(
      title: title,
      content: content,
      color: color,
      timestamp: timestamp,
    );
  }

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

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'color': color,
      'timestamp': timestamp,
      'id': id,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      color: map['color']?.toInt() ?? 0,
      timestamp: map['timestamp']?.toInt() ?? 0,
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source));

  NoteModel copyWith({
    String? title,
    String? content,
    int? color,
    int? timestamp,
    int? id,
  }) {
    return NoteModel(
      title: title ?? this.title,
      content: content ?? this.content,
      color: color ?? this.color,
      timestamp: timestamp ?? this.timestamp,
      id: id ?? this.id,
    );
  }

  @override
  String toString() {
    return 'NoteModel(title: $title, content: $content, color: $color, timestamp: $timestamp, id: $id)';
  }
}
