import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/admin_repository.dart';

part 'admin_add_products_event.dart';
part 'admin_add_products_state.dart';

class AdminAddProductsBloc
    extends Bloc<AdminAddProductsEvent, AdminAddProductsState> {
  final AdminRepository adminRepository;
  AdminAddProductsBloc(this.adminRepository)
      : super(AdminAddProductsInitialS()) {
    on<SelectImagesPressedE>(_onSelectImagesPressedHandler);
  }

  void _onSelectImagesPressedHandler(event, emit) async {
    try {
      List<File> imagesList = [];

      var images = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (images != null || images!.files.isNotEmpty) {
        for (int i = 0; i < images.files.length; i++) {
          imagesList.add(File(images.files[i].path!));
        }
      }

      emit(AdminAddProductsImagesSelectedS(imagesList: imagesList));
      imagesList.clear();
    } catch (e) {
      emit(AdminAddProductsErrorS(errorString: e.toString()));
    }
  }

  List<File>? get imagesList {
    if (state is AdminAddProductsImagesSelectedS) {
      return (state as AdminAddProductsImagesSelectedS).imagesList;
    } else {
      return null;
    }
  }
}
