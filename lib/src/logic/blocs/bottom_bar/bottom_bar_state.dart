part of 'bottom_bar_bloc.dart';

@immutable
sealed class BottomBarState {}

final class BottomBarPageState extends BottomBarState {
  final int index;

  BottomBarPageState({required this.index});
}

final class BottomBarMoreClickedState extends BottomBarState {
  final int index;

  BottomBarMoreClickedState({required this.index});
}
