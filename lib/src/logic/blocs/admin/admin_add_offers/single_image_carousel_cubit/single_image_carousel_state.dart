part of 'single_image_carousel_cubit.dart';

sealed class SingleImageState extends Equatable {
  const SingleImageState();

  @override
  List<Object> get props => [];
}

final class SingleImageInitial extends SingleImageState {}

final class SingleImageSelected extends SingleImageState {
  final File image;

  const SingleImageSelected({required this.image});

  @override
  List<Object> get props => [image];
}

final class SingleImageError extends SingleImageState {
  final String errorString;

  const SingleImageError({required this.errorString});

  @override
  List<Object> get props => [errorString];
}
