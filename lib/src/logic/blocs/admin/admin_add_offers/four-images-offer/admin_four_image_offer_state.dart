part of 'admin_four_image_offer_cubit.dart';

sealed class AdminFourImageOfferState extends Equatable {
  const AdminFourImageOfferState();

  @override
  List<Object> get props => [];
}

final class AdminFourImageOfferInitialS extends AdminFourImageOfferState {}

final class AdminFourImageOfferLoadingS extends AdminFourImageOfferState {}

final class AdminAddFourImageOfferSuccessS extends AdminFourImageOfferState {}

final class AdminGetFourImageOfferSuccessS extends AdminFourImageOfferState {
  final List<FourImagesOffer> fourImagesOfferList;

  const AdminGetFourImageOfferSuccessS({required this.fourImagesOfferList});
  @override
  List<Object> get props => [fourImagesOfferList];
}

final class AdminFourImageOfferErrorS extends AdminFourImageOfferState {
  final String errorString;

  const AdminFourImageOfferErrorS({required this.errorString});

  @override
  List<Object> get props => [errorString];
}
