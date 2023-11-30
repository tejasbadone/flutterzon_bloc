import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/admin_repository.dart';

part 'admin_sell_product_state.dart';

class AdminSellProductCubit extends Cubit<AdminSellProductState> {
  final AdminRepository adminRepository;
  AdminSellProductCubit(this.adminRepository)
      : super(AdminSellProductInitial());

  Future<void> sellProduct({
    required String name,
    required String description,
    required double price,
    required int quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      emit(AdminSellProductsLoadingS());

      await adminRepository.adminAddProduct(
          name: name,
          description: description,
          price: price,
          quantity: quantity,
          category: category,
          images: images);

      emit(AdminSellProductSuccessS());
    } catch (e) {
      emit(AdminSellProductErrorS(errorString: e.toString()));
    }
  }
}
