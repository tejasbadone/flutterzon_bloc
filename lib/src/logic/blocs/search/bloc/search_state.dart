part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchLoadingS extends SearchState {}

final class SearchSuccessS extends SearchState {
  final List<Product> searchProducts;
  final List<double> averageRatingList;

  const SearchSuccessS(
      {required this.searchProducts, required this.averageRatingList});

  @override
  List<Object> get props => [searchProducts, averageRatingList];
}

final class SearchErrorS extends SearchState {
  final String errorString;

  const SearchErrorS({required this.errorString});

  @override
  List<Object> get props => [errorString];
}
