part of 'wish_list_cubit.dart';

sealed class WishListState extends Equatable {
  const WishListState();

  @override
  List<Object> get props => [];
}

// Get keep shopping for
final class GetWishListLoadingS extends WishListState {}

final class GetWishListSuccessS extends WishListState {
  final List<Product> wishList;
  final List<double> averageRatingList;

  const GetWishListSuccessS(
      {required this.wishList, required this.averageRatingList});

  @override
  List<Object> get props => [wishList];
}

final class GetWishListErrorS extends WishListState {
  final String errorString;

  const GetWishListErrorS({required this.errorString});

  @override
  List<Object> get props => [errorString];
}

// Add keep shopping for
class AddKeepShoppingForPressedS extends WishListState {
  final Product product;

  const AddKeepShoppingForPressedS({required this.product});
  @override
  List<Object> get props => [product];
}

class AddKeepShoppingForLoadingS extends WishListState {}

class AddKeepShoppingForSuccessS extends WishListState {
  final Product product;

  const AddKeepShoppingForSuccessS({required this.product});
  @override
  List<Object> get props => [product];
}

class AddKeepShoppingForErrorS extends WishListState {
  final String errorString;

  const AddKeepShoppingForErrorS({required this.errorString});

  @override
  List<Object> get props => [errorString];
}
