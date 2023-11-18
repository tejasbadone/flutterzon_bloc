part of 'wish_list_cubit.dart';

sealed class WishListState extends Equatable {
  const WishListState();

  @override
  List<Object> get props => [];
}

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
