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

// add to wish list

class AddToWishListPressedS extends WishListState {
  final Product product;

  const AddToWishListPressedS({required this.product});

  @override
  List<Object> get props => [product];
}

class AddToWishListSuccessS extends WishListState {}

class AddToWishListErrorS extends WishListState {
  final String errorString;

  const AddToWishListErrorS({required this.errorString});

  @override
  List<Object> get props => [errorString];
}

// delete from wish list

class DeleteFromWishListS extends WishListState {}
