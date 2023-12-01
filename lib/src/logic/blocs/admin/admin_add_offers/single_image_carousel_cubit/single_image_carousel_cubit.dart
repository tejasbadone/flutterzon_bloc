import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

part 'single_image_carousel_state.dart';

class SingleImageCubit extends Cubit<SingleImageState> {
  SingleImageCubit() : super(SingleImageInitial());

  void singleImage() async {
    try {
      File? image;

      FilePickerResult? imagePicked = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image,
      );

      if (imagePicked != null) {
        image = File(imagePicked.files[0].path!);
      }

      emit(SingleImageSelected(image: image!));
    } catch (e) {
      emit(SingleImageError(errorString: e.toString()));
    }
  }
}
