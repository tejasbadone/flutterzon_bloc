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

// product details screen - wishlist

class NotAddedToWishListS extends WishListState {
  final Product product;

  const NotAddedToWishListS({required this.product});

  @override
  List<Object> get props => [product];
}

class AddedToWishListS extends WishListState {
  final Product product;

  const AddedToWishListS({required this.product});

  @override
  List<Object> get props => [product];
}

class DeletedFromWishListS extends WishListState {
  final Product product;

  const DeletedFromWishListS({required this.product});

  @override
  List<Object> get props => [product];
}

// class AddToWishListSuccessS extends WishListState {}

class WishListErrorS extends WishListState {
  final String errorString;

  const WishListErrorS({required this.errorString});

  @override
  List<Object> get props => [errorString];
}

// wish list screen

final class LoadingWishListScreenS extends WishListState {}

final class AddedToCartWishListScreenS extends WishListState {}

final class RemovedFromWishListScreenS extends WishListState {}
