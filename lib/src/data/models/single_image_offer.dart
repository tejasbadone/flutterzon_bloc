// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SingleImageOffer extends Equatable {
  final String title;
  final String subTitle;
  final String image;
  final String category;

  const SingleImageOffer(
      {required this.title,
      required this.subTitle,
      required this.image,
      required this.category});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'subTitle': subTitle,
      'image': image,
      'category': category,
    };
  }

  factory SingleImageOffer.fromMap(Map<String, dynamic> map) {
    return SingleImageOffer(
      title: map['title'] as String,
      subTitle: map['subTitle'] as String,
      image: map['image'] as String,
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleImageOffer.fromJson(String source) =>
      SingleImageOffer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SingleImageOffer(title: $title, subTitle: $subTitle, image: $image, category: $category)';

  @override
  List<Object?> get props => [title, subTitle, image, category];
}
