import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/user_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final UserRepository userRepository;
  final AccountRepository accountRepository = AccountRepository();
  CartBloc(this.userRepository) : super(CartLoadingS()) {
    on<GetCartPressed>(_onGetCartHandler);
    on<AddToCart>(_onAddToCartHandler);
    on<AddToCartFromBottomSheet>(_onAddToCartFromBottomSheetHandler);
    on<RemoveFromCart>(_onRemoveFromCartHandler);
    on<DeleteFromCart>(_onDeleteFromCartHandler);
    on<SaveForLaterE>(_onSaveForLaterHandler);
    on<DeleteFromLaterE>(_onDeleteFromLaterHandler);
    on<MoveToCartE>(_onMoveToCartHandler);
  }

  Future<List<dynamic>> tryBlockCode(
      {required dynamic customUserRepository}) async {
    List<List> items;
    List<Product> cartProducts;
    List<Product> saveForLaterProducts;
    List<int> productsQuantity;
    List<double> averageRatingList = [];
    double rating;
    double sum = 0;

    items = await customUserRepository;
    cartProducts = items[0] as List<Product>;
    productsQuantity = items[1] as List<int>;

    saveForLaterProducts = await userRepository.getSaveForLater();

    for (int i = 0; i < cartProducts.length; i++) {
      sum += cartProducts[i].price * productsQuantity[i];

      rating = await accountRepository.getAverageRating(cartProducts[i].id!);

      averageRatingList.add(rating);
    }

    return [
      sum,
      cartProducts,
      averageRatingList,
      productsQuantity,
      saveForLaterProducts
    ];
  }

  void _onGetCartHandler(event, emit) async {
    try {
      emit(CartLoadingS());
      List<dynamic> items = await tryBlockCode(
          customUserRepository: await userRepository.getCart());
      emit(CartProductSuccessS(
          total: items[0],
          cartProducts: items[1],
          averageRatingList: items[2],
          productsQuantity: items[3],
          saveForLaterProducts: items[4]));
    } catch (e) {
      emit(CartProductErrorS(errorString: e.toString()));
    }
  }

  void _onAddToCartHandler(event, emit) async {
    try {
      emit(CartLoadingS());
      List<dynamic> items = await tryBlockCode(
          customUserRepository:
              await userRepository.addToCart(product: event.product));
      emit(CartProductSuccessS(
          total: items[0],
          cartProducts: items[1],
          averageRatingList: items[2],
          productsQuantity: items[3],
          saveForLaterProducts: items[4]));
    } catch (e) {
      emit(CartProductErrorS(errorString: e.toString()));
    }
  }

  void _onAddToCartFromBottomSheetHandler(event, emit) async {
    try {
      emit(CartLoadingS());
      List<dynamic> items = await tryBlockCode(
          customUserRepository:
              await userRepository.addToCart(product: event.product));
      emit(CartProductSuccessS(
          total: items[0],
          cartProducts: items[1],
          averageRatingList: items[2],
          productsQuantity: items[3],
          saveForLaterProducts: items[4]));
    } catch (e) {
      emit(CartProductErrorS(errorString: e.toString()));
    }
  }

  void _onRemoveFromCartHandler(event, emit) async {
    try {
      emit(CartLoadingS());
      List<dynamic> items = await tryBlockCode(
          customUserRepository:
              await userRepository.removeFromCart(product: event.product));
      emit(CartProductSuccessS(
          total: items[0],
          cartProducts: items[1],
          averageRatingList: items[2],
          productsQuantity: items[3],
          saveForLaterProducts: items[4]));
    } catch (e) {
      emit(CartProductErrorS(errorString: e.toString()));
    }
  }

  void _onDeleteFromCartHandler(event, emit) async {
    try {
      emit(CartLoadingS());
      List<dynamic> items = await tryBlockCode(
          customUserRepository:
              await userRepository.deleteFromCart(product: event.product));
      emit(CartProductSuccessS(
          total: items[0],
          cartProducts: items[1],
          averageRatingList: items[2],
          productsQuantity: items[3],
          saveForLaterProducts: items[4]));
    } catch (e) {
      emit(CartProductErrorS(errorString: e.toString()));
    }
  }

  void _onSaveForLaterHandler(event, emit) async {
    try {
      emit(CartLoadingS());
      List<dynamic> items = await tryBlockCode(
          customUserRepository:
              await userRepository.saveForLater(product: event.product));
      emit(CartProductSuccessS(
          total: items[0],
          cartProducts: items[1],
          averageRatingList: items[2],
          productsQuantity: items[3],
          saveForLaterProducts: items[4]));
    } catch (e) {
      emit(CartProductErrorS(errorString: e.toString()));
    }
  }

  void _onDeleteFromLaterHandler(event, emit) async {
    try {
      emit(CartLoadingS());
      List<dynamic> items = await tryBlockCode(
          customUserRepository:
              await userRepository.deleteFromLater(product: event.product));
      emit(CartProductSuccessS(
          total: items[0],
          cartProducts: items[1],
          averageRatingList: items[2],
          productsQuantity: items[3],
          saveForLaterProducts: items[4]));
    } catch (e) {
      emit(CartProductErrorS(errorString: e.toString()));
    }
  }

  void _onMoveToCartHandler(event, emit) async {
    try {
      emit(CartLoadingS());
      List<dynamic> items = await tryBlockCode(
          customUserRepository:
              await userRepository.moveToCart(product: event.product));
      emit(CartProductSuccessS(
          total: items[0],
          cartProducts: items[1],
          averageRatingList: items[2],
          productsQuantity: items[3],
          saveForLaterProducts: items[4]));
    } catch (e) {
      emit(CartProductErrorS(errorString: e.toString()));
    }
  }

  int get cartItemsLength {
    if (state is CartProductSuccessS) {
      return (state as CartProductSuccessS).cartProducts.length;
    } else {
      return -1;
    }
  }
}
