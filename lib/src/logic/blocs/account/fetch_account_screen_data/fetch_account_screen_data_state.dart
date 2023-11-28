part of 'fetch_account_screen_data_cubit.dart';

sealed class FetchAccountScreenDataState extends Equatable {
  const FetchAccountScreenDataState();

  @override
  List<Object> get props => [];
}

final class FetchAccountScreenDataLoadingS
    extends FetchAccountScreenDataState {}

final class FetchAccountScreenDataSuccessS extends FetchAccountScreenDataState {
  final List<Order> ordersList;
  final List<Product> keepShoppingForList;
  final List<Product> wishListProducts;
  final List<double> averageRatingList;

  const FetchAccountScreenDataSuccessS({
    required this.ordersList,
    required this.keepShoppingForList,
    required this.wishListProducts,
    required this.averageRatingList,
  });

  @override
  List<Object> get props =>
      [ordersList, keepShoppingForList, wishListProducts, averageRatingList];
}

final class FetchAccountScreenDataErrorS extends FetchAccountScreenDataState {
  final String errorString;

  const FetchAccountScreenDataErrorS({required this.errorString});

  @override
  List<Object> get props => [errorString];
}

final class FetchAccountScreenDataEmptyS extends FetchAccountScreenDataState {
  final String emptyStringMessage;

  const FetchAccountScreenDataEmptyS({required this.emptyStringMessage});

  @override
  List<Object> get props => [emptyStringMessage];
}
