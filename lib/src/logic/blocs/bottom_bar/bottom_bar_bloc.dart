import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'bottom_bar_event.dart';
part 'bottom_bar_state.dart';

class BottomBarBloc extends Bloc<BottomBarEvent, BottomBarState> {
  BottomBarBloc() : super(BottomBarPageState(index: 0)) {
    on<BottomBarClickedEvent>(_onbottomBarClickedHandler);
    on<BottomBarMoreClickedEvent>(_onttomBarMoreClickedEvent);
  }
  void _onbottomBarClickedHandler(event, emit) {
    emit(BottomBarPageState(index: event.index));
  }

  void _onttomBarMoreClickedEvent(event, emit) {
    emit(BottomBarMoreClickedState(event.index, event.isOpen));
  }
}
