import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/datasources/api/account_apis.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/account_repository.dart';

part 'keep_shopping_for_event.dart';
part 'keep_shopping_for_state.dart';

class KeepShoppingForBloc
    extends Bloc<KeepShoppingForEvent, KeepShoppingForState> {
  final AccountRepository accountRepository;

  KeepShoppingForBloc(this.accountRepository)
      : super(KeepShoppingForLoadingS()) {
    on<KeepShoppingForEvent>(_onKeepShoppingForHandler);
  }

  void _onKeepShoppingForHandler(event, emit) async {
    try {
      List<Product> keepShoppingForList;

      emit(KeepShoppingForLoadingS());

      accountRepository.keepShoppingFor(product: event.product);
    } catch (e) {}
  }
}
