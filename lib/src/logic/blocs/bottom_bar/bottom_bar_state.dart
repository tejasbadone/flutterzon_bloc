part of 'bottom_bar_bloc.dart';

@immutable
sealed class BottomBarState extends Equatable {}

final class BottomBarPageState extends BottomBarState {
  final int index;

  BottomBarPageState({required this.index});

  @override
  List<Object?> get props => [index];
}

final class BottomBarMoreClickedState extends BottomBarState {
  final int index;

  BottomBarMoreClickedState({required this.index});

  @override
  List<Object?> get props => [index];
}
