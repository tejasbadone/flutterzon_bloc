part of 'bottom_bar_bloc.dart';

@immutable
sealed class BottomBarState extends Equatable {}

// ignore: must_be_immutable
class BottomBarPageState extends BottomBarState {
  final int index;

  BottomBarPageState({required this.index});

  @override
  List<Object?> get props => [index];
}

final class BottomBarMoreClickedState extends BottomBarState {
  final int index;
  final bool isOpen;

  BottomBarMoreClickedState(this.index, this.isOpen);

  @override
  List<Object?> get props => [index, isOpen];
}
