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
