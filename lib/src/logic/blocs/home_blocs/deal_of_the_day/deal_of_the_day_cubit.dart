import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/products_repository.dart';

part 'deal_of_the_day_state.dart';

class DealOfTheDayCubit extends Cubit<DealOfTheDayState> {
  final ProductsRepository productsRepository;
  DealOfTheDayCubit(this.productsRepository) : super(DealOfTheDayInitialS());

  Future<void> getDealOfTheDay(int? imageIndex) async {
    try {
      Product product = await productsRepository.getDealOfTheDay();

      emit(DealOfTheDaySuccessS(product: product, imageIndex: imageIndex!));
    } catch (e) {
      emit(DealOfTheDayErrorS(errorString: e.toString()));
    }
  }

  void changeDealOfTheDayImage(int index) {
    Product product = (state as DealOfTheDaySuccessS).product;

    emit(DealOfTheDaySuccessS(product: product, imageIndex: index));
  }
}
