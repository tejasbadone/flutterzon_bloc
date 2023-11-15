import 'package:bloc/bloc.dart';

part 'carousel_image_event.dart';
part 'carousel_image_state.dart';

class CarouselImageBloc extends Bloc<CarouselImageEvent, CarouselImageState> {
  CarouselImageBloc() : super(CarouselImageState(index: 0)) {
    on<CarouselImageEvent>((event, emit) {
      emit(CarouselImageState(index: event.index));
    });
  }
}
