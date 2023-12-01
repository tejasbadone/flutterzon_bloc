part of 'carousel_image_bloc.dart';

sealed class CarouselImageState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CarouselImageChangeState extends CarouselImageState {
  final int index;

  CarouselImageChangeState({required this.index});
  @override
  List<Object?> get props => [index];
}

final class ResetCarouselState extends CarouselImageState {}
