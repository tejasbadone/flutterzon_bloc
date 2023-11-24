import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/user_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final UserRepository userRepository;
  CartBloc(this.userRepository) : super(CartLoadingS()) {
    on<GetCartPressed>(_onGetCartHandler);
    on<AddToCart>(_onAddToCartHandler);
    on<RemoveFromCart>(_onRemoveFromCartHandler);
    on<DeleteFromCart>(_onDeleteFromCartHandler);
  }

  Future<List<dynamic>> tryBlockCode({required dynamic userRepository}) async {
    List<List> items;
    List<Product> cartProducts;
    List<int> productsQuantity;
    double sum = 0;

    items = await userRepository;
    cartProducts = items[0] as List<Product>;
    productsQuantity = items[1] as List<int>;

    for (int i = 0; i < cartProducts.length; i++) {
      sum += cartProducts[i].price;
    }

    return [sum, cartProducts, productsQuantity];
  }

  void _onGetCartHandler(event, emit) async {
    try {
      List<dynamic> items =
          await tryBlockCode(userRepository: await userRepository.getCart());
      emit(CartProductSuccessS(items[0], items[1], items[2]));
    } catch (e) {
      emit(CartProductErrorS(errorString: e.toString()));
    }
  }

  void _onAddToCartHandler(event, emit) async {
    try {
      List<dynamic> items = await tryBlockCode(
          userRepository:
              await userRepository.addToCart(product: event.product));
      emit(CartProductSuccessS(items[0], items[1], items[2]));
    } catch (e) {
      emit(CartProductErrorS(errorString: e.toString()));
    }
  }

  void _onRemoveFromCartHandler(event, emit) async {
    try {
      List<dynamic> items = await tryBlockCode(
          userRepository:
              await userRepository.removeFromCart(product: event.product));
      emit(CartProductSuccessS(items[0], items[1], items[2]));
    } catch (e) {
      emit(CartProductErrorS(errorString: e.toString()));
    }
  }

  void _onDeleteFromCartHandler(event, emit) async {
    try {
      List<dynamic> items = await tryBlockCode(
          userRepository:
              await userRepository.deleteFromCart(product: event.product));
      emit(CartProductSuccessS(items[0], items[1], items[2]));
    } catch (e) {
      emit(CartProductErrorS(errorString: e.toString()));
    }
  }
}
