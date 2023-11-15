import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/search_products_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchProductsRepository searchProductsRepository;

  SearchBloc(this.searchProductsRepository) : super(SearchLoadingS()) {
    on<SearchEvent>(_searchEventHandler);
  }

  void _searchEventHandler(event, emit) async {
    List<Product> searchProducts;

    try {
      emit(SearchLoadingS());

      searchProducts =
          await searchProductsRepository.searchProducts(event.searchQuery);

      emit(SearchSuccessS(searchProducts: searchProducts));
    } catch (e) {
      emit(SearchErrorS(errorString: e.toString()));
    }
  }
}
