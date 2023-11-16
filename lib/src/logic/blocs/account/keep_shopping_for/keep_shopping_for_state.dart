part of 'keep_shopping_for_bloc.dart';

sealed class KeepShoppingForState extends Equatable {
  const KeepShoppingForState();

  @override
  List<Object> get props => [];
}

final class KeepShoppingForLoadingS extends KeepShoppingForState {}

final class KeepShoppingForSuccessS extends KeepShoppingForState {
  final List<Product> productList;

  const KeepShoppingForSuccessS({required this.productList});

  @override
  List<Object> get props => [productList];
}

final class KeepShoppingForErrorS extends KeepShoppingForState {
  final String errorString;

  const KeepShoppingForErrorS({required this.errorString});

  @override
  List<Object> get props => [errorString];
}
