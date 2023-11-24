import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/user_repository.dart';

part 'save_for_later_event.dart';
part 'save_for_later_state.dart';

class SaveForLaterBloc extends Bloc<SaveForLaterEvent, SaveForLaterState> {
  final UserRepository userRepository;
  SaveForLaterBloc(this.userRepository) : super(SaveForLaterLoadingS()) {
    on<SaveForLaterE>(_onSaveForLaterHandler);
  }

  void _onSaveForLaterHandler(event, emit) async {
    try {
      emit(SaveForLaterLoadingS());
      List<Product> saveForLaterProducts;
      saveForLaterProducts =
          await userRepository.saveForLater(product: event.product);

      print(saveForLaterProducts.length);

      emit(SaveForLaterSuccessS(saveForLaterProducts: saveForLaterProducts));
    } catch (e) {
      emit(SaveForLaterErrorS(errorString: e.toString()));
    }
  }
}
