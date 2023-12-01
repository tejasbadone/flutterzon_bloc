import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'carousel_image_event.dart';
part 'carousel_image_state.dart';

class CarouselImageBloc extends Bloc<CarouselImageEvent, CarouselImageState> {
  CarouselImageBloc() : super(CarouselImageChangeState(index: 0)) {
    on<CarouselImageChangedEvent>((event, emit) {
      emit(CarouselImageChangeState(index: event.index));
    });

    on<ResetCarouselEvent>(
      (event, emit) {
        emit(ResetCarouselState());
      },
    );
  }
}
