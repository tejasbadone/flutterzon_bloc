import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/admin_repository.dart';

part 'admin_add_products_images_event.dart';
part 'admin_add_products_images_state.dart';

class AdminAddProductsImagesBloc
    extends Bloc<AdminAddProductsImagesEvent, AdminAddProductsImagesState> {
  final AdminRepository adminRepository;
  AdminAddProductsImagesBloc(this.adminRepository)
      : super(AdminAddProductsInitialS()) {
    on<SelectImagesPressedE>(_onSelectImagesPressedHandler);
    on<ClearImagesPressedE>(_onClearImagesPressedEHandler);
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

  void _onClearImagesPressedEHandler(event, emit) {
    emit(AdminAddProductsClearImagesS());
  }
}
