import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/admin_repository.dart';

part 'admin_delete_four_images_offer_state.dart';

class AdminDeleteFourImagesOfferCubit
    extends Cubit<AdminDeleteFourImagesOfferState> {
  final AdminRepository adminRepository;
  AdminDeleteFourImagesOfferCubit(this.adminRepository)
      : super(AdminDeleteFourImagesOfferInitialS());
}
