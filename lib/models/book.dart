import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String notes;
  int order;

  Book({
    required this.notes,
    required this.order
  });

  Book.fromJson(Map<String, Object?> json)
      : this(
      notes: json['notes']! as String,
      order: json['order']! as int
  );

  Book copyWith({
    String? notes,
    int? order
  }) {
    return Book(notes: notes ?? this.notes, order: order ?? this.order);
  }

  Map<String, Object?> toJson(){
    return {
      'notes': notes,
      'order': order,
    };
  }
}