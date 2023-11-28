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
  final bool isOpen;

  BottomBarMoreClickedEvent(this.index, this.isOpen);

  @override
  List<Object?> get props => [index, isOpen];
}
