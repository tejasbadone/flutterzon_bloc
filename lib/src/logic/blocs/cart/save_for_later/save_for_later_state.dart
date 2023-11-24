part of 'save_for_later_bloc.dart';

sealed class SaveForLaterState extends Equatable {
  const SaveForLaterState();

  @override
  List<Object> get props => [];
}

final class SaveForLaterLoadingS extends SaveForLaterState {}

// save for later

final class SaveForLaterSuccessS extends SaveForLaterState {
  final List<Product> saveForLaterProducts;

  const SaveForLaterSuccessS({required this.saveForLaterProducts});

  @override
  List<Object> get props => [saveForLaterProducts];
}

final class SaveForLaterErrorS extends SaveForLaterState {
  final String errorString;

  const SaveForLaterErrorS({required this.errorString});

  @override
  List<Object> get props => [errorString];
}
