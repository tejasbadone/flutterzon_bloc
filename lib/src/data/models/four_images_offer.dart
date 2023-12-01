// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class FourImagesOffer extends Equatable {
  final String? id;
  final String title;
  final List<String> images;
  final List<String> labels;
  final String category;

  const FourImagesOffer(
      {this.id,
      required this.title,
      required this.images,
      required this.labels,
      required this.category});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'images': images,
      'labels': labels,
      'category': category,
    };
  }

  factory FourImagesOffer.fromMap(Map<String, dynamic> map) {
    return FourImagesOffer(
      id: map['_id'] as String,
      title: map['title'] as String,
      images: List<String>.from((map['images'])),
      labels: List<String>.from((map['labels'])),
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FourImagesOffer.fromJson(String source) =>
      FourImagesOffer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  FourImagesOffer copyWith({
    String? id,
    String? title,
    List<String>? images,
    List<String>? labels,
    String? category,
  }) {
    return FourImagesOffer(
      id: id ?? this.id,
      title: title ?? this.title,
      images: images ?? this.images,
      labels: labels ?? this.labels,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [id, title, images, labels, category];
}
