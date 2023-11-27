part of 'page_redirection_cubit.dart';

sealed class PageRedirectionState extends Equatable {
  const PageRedirectionState();

  @override
  List<Object> get props => [];
}

final class PageRedirectionInitial extends PageRedirectionState {}

final class PageRedirectionSuccess extends PageRedirectionState {
  final bool isLoggedIn;

  const PageRedirectionSuccess({required this.isLoggedIn});
  @override
  List<Object> get props => [isLoggedIn];
}
