import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'bottom_bar_event.dart';
part 'bottom_bar_state.dart';

class BottomBarBloc extends Bloc<BottomBarEvent, BottomBarState> {
  BottomBarBloc() : super(BottomBarPageState(index: 0)) {
    on<BottomBarClickedEvent>(_bottomBarClickedHandler);
    on<BottomBarMoreClickedEvent>(_bottomBarClickedHandler);
  }
  void _bottomBarClickedHandler(event, emit) {
    if (event.index == 2) {
      emit(BottomBarMoreClickedState(index: event.index));
    } else {
      emit(BottomBarPageState(index: event.index));
    }
  }
}
