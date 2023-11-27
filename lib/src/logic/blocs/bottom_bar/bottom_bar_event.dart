part of 'bottom_bar_bloc.dart';

@immutable
sealed class BottomBarEvent extends Equatable {}

class BottomBarClickedEvent extends BottomBarEvent {
  final int index;

  BottomBarClickedEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class BottomBarMoreClickedEvent extends BottomBarEvent {
  final int index;

  BottomBarMoreClickedEvent({required this.index});

  @override
  List<Object?> get props => [index];
}
