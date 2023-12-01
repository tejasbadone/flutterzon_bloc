part of 'carousel_image_bloc.dart';

sealed class CarouselImageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CarouselImageChangedEvent extends CarouselImageEvent {
  final int index;

  CarouselImageChangedEvent({required this.index});
  @override
  List<Object?> get props => [index];
}

final class ResetCarouselEvent extends CarouselImageEvent {}
