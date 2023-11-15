part of 'bottom_bar_bloc.dart';

@immutable
sealed class BottomBarEvent {}

class BottomBarClickedEvent extends BottomBarEvent {
  final int index;

  BottomBarClickedEvent({required this.index});
}

class BottomBarMoreClickedEvent extends BottomBarEvent {
  final int index;

  BottomBarMoreClickedEvent({required this.index});
}
