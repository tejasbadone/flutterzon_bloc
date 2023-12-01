part of 'admin_delete_four_images_offer_cubit.dart';

sealed class AdminDeleteFourImagesOfferState extends Equatable {
  const AdminDeleteFourImagesOfferState();

  @override
  List<Object> get props => [];
}

final class AdminDeleteFourImagesOfferInitialS
    extends AdminDeleteFourImagesOfferState {}

final class AdminDeleteFourImagesOfferSuccessS
    extends AdminDeleteFourImagesOfferState {}

final class AdminDeleteFourImagesOfferErrorS
    extends AdminDeleteFourImagesOfferState {
  final String errorString;

  const AdminDeleteFourImagesOfferErrorS({required this.errorString});

  @override
  List<Object> get props => [errorString];
}
