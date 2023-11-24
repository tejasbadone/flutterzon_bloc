part of 'save_for_later_bloc.dart';

sealed class SaveForLaterEvent extends Equatable {
  const SaveForLaterEvent();

  @override
  List<Object> get props => [];
}

class SaveForLaterE extends SaveForLaterEvent {
  final Product product;

  const SaveForLaterE({required this.product});

  @override
  List<Object> get props => [product];
}
