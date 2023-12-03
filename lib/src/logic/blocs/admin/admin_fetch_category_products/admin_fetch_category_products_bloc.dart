import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/product.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/admin_repository.dart';

part 'admin_fetch_category_products_event.dart';
part 'admin_fetch_category_products_state.dart';

class AdminFetchCategoryProductsBloc extends Bloc<
    AdminFetchCategoryProductsEvent, AdminFetchCategoryProductsState> {
  final AdminRepository adminRepository;
  AdminFetchCategoryProductsBloc(this.adminRepository)
      : super(AdminFetchCategoryProductsLoadingS()) {
    on<AdminFetchCategoryProductsPressedE>(
        _onAdminFetchCategoryProductsHandler);
    on<AdminDeleteProductPressedE>(_onAdminDeleteProductHandler);
  }

  void _onAdminFetchCategoryProductsHandler(event, emit) async {
    try {
      List<Product> categoryProducts;
      List<Product> tempCategoryProducts;
      emit(AdminFetchCategoryProductsLoadingS());

      tempCategoryProducts = await adminRepository.adminGetCategoryProducts(
          category: event.category);

      categoryProducts = tempCategoryProducts.reversed.toList();

      emit(AdminFetchCategoryProductsSuccessS(
          categoryProducts: categoryProducts));
    } catch (e) {
      emit(AdminFetchCategoryProductsErrorS(errorString: e.toString()));
    }
  }

  Future<void> _onAdminDeleteProductHandler(event, emit) async {
    try {
      emit(AdminFetchCategoryProductsLoadingS());

      List<Product> categoryProducts;
      await adminRepository.adminDeleteProduct(product: event.product);

      categoryProducts = await adminRepository.adminGetCategoryProducts(
          category: event.category);

      emit(AdminFetchCategoryProductsSuccessS(
          categoryProducts: categoryProducts));
    } catch (e) {
      emit(AdminFetchCategoryProductsErrorS(errorString: e.toString()));
    }
  }
}
