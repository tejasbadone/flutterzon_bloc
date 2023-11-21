part of 'keep_shopping_for_cubit.dart';

sealed class KeepShoppingForState extends Equatable {
  const KeepShoppingForState();

  @override
  List<Object> get props => [];
}

// Keep Shopping for
final class KeepShoppingForLoadingS extends KeepShoppingForState {}

final class KeepShoppingForSuccessS extends KeepShoppingForState {
  final List<Product> productList;
  final List<double> averageRatingList;

  const KeepShoppingForSuccessS(
      {required this.productList, required this.averageRatingList});

  @override
  List<Object> get props => [productList];
}

final class KeepShoppingForErrorS extends KeepShoppingForState {
  final String errorString;

  const KeepShoppingForErrorS({required this.errorString});

  @override
  List<Object> get props => [errorString];
}

// Add keep shopping for
class AddKeepShoppingForLoadingS extends KeepShoppingForState {}

class AddKeepShoppingForSuccessS extends KeepShoppingForState {
  final Product product;

  const AddKeepShoppingForSuccessS({required this.product});
  @override
  List<Object> get props => [product];
}

class AddKeepShoppingForErrorS extends KeepShoppingForState {
  final String errorString;

  const AddKeepShoppingForErrorS({required this.errorString});

  @override
  List<Object> get props => [errorString];
}
