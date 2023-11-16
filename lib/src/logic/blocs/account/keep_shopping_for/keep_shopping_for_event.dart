part of 'keep_shopping_for_bloc.dart';

sealed class KeepShoppingForEvent extends Equatable {
  const KeepShoppingForEvent();

  @override
  List<Object> get props => [];
}

class KeepShoppingForTriggered extends KeepShoppingForEvent {
  final Product product;

  const KeepShoppingForTriggered({required this.product});

  @override
  List<Object> get props => [product];
}
