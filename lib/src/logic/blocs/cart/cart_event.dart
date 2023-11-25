part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetCartPressed extends CartEvent {}

class AddToCart extends CartEvent {
  final Product product;

  const AddToCart({required this.product});

  @override
  List<Object> get props => [product];
}

class AddToCartFromBottomSheet extends CartEvent {
  final Product product;

  const AddToCartFromBottomSheet({required this.product});

  @override
  List<Object> get props => [product];
}

class RemoveFromCart extends CartEvent {
  final Product product;

  const RemoveFromCart({required this.product});

  @override
  List<Object> get props => [product];
}

class DeleteFromCart extends CartEvent {
  final Product product;

  const DeleteFromCart({required this.product});

  @override
  List<Object> get props => [product];
}

class SaveForLaterE extends CartEvent {
  final Product product;

  const SaveForLaterE({required this.product});

  @override
  List<Object> get props => [product];
}

class DeleteFromLaterE extends CartEvent {
  final Product product;

  const DeleteFromLaterE({required this.product});

  @override
  List<Object> get props => [product];
}

class MoveToCartE extends CartEvent {
  final Product product;

  const MoveToCartE({required this.product});

  @override
  List<Object> get props => [product];
}
