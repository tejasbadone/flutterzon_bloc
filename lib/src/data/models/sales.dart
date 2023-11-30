import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/constants/constants.dart';

class Sales extends Equatable {
  final String label;
  final int earning;
  final Color pointColor = Constants.secondaryColor;

  const Sales(this.label, this.earning);

  @override
  List<Object?> get props => [label, earning, pointColor];
}
