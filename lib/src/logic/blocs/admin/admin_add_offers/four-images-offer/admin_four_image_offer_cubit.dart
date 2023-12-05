import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/four_images_offer.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/admin_repository.dart';

part 'admin_four_image_offer_state.dart';

class AdminFourImageOfferCubit extends Cubit<AdminFourImageOfferState> {
  final AdminRepository adminRepository;
  AdminFourImageOfferCubit(this.adminRepository)
      : super(AdminFourImageOfferInitialS());

  Future<void> addFourImagesOffer({
    required String title,
    required List<File> images,
    required String label1,
    required String label2,
    required String label3,
    required String label4,
    required String category,
  }) async {
    try {
      emit(AdminFourImageOfferLoadingS());
      List<String> labels = [label1, label2, label3, label4];

      await adminRepository.adminAddFourImagesOffer(
          title: title, images: images, labels: labels, category: category);

      emit(AdminAddFourImageOfferSuccessS());
    } catch (e) {
      emit(AdminFourImageOfferErrorS(errorString: e.toString()));
    }
  }

  Future<void> adminGetFourImagesOffer({required bool isUser}) async {
    try {
      emit(AdminFourImageOfferLoadingS());

      List<FourImagesOffer> fourImagesOfferList;
      List<FourImagesOffer> tempFourImagesOfferList;

      tempFourImagesOfferList = await adminRepository.adminGetFourImagesOffer();

      if (isUser) {
        tempFourImagesOfferList.shuffle();
        fourImagesOfferList = tempFourImagesOfferList;
      } else {
        fourImagesOfferList = tempFourImagesOfferList.reversed.toList();
      }

      emit(AdminGetFourImageOfferSuccessS(
          fourImagesOfferList: fourImagesOfferList));
    } catch (e) {
      emit(AdminFourImageOfferErrorS(errorString: e.toString()));
    }
  }

  Future<void> adminDeleteFourImagesOffer({required String offerId}) async {
    try {
      List<FourImagesOffer> fourImagesOfferList;
      List<FourImagesOffer> tempFourImagesOfferList;

      tempFourImagesOfferList =
          await adminRepository.adminDeleteFourImagesOffer(offerId: offerId);

      fourImagesOfferList = tempFourImagesOfferList.reversed.toList();

      emit(AdminGetFourImageOfferSuccessS(
          fourImagesOfferList: fourImagesOfferList));
    } catch (e) {
      emit(AdminFourImageOfferErrorS(errorString: e.toString()));
    }
  }
}
