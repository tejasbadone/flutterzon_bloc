part of 'page_redirection_cubit.dart';

sealed class PageRedirectionState extends Equatable {
  const PageRedirectionState();

  @override
  List<Object> get props => [];
}

final class PageRedirectionInitial extends PageRedirectionState {}

final class PageRedirectionSuccess extends PageRedirectionState {
  final bool isValid;
  final String userType;

  const PageRedirectionSuccess({required this.isValid, required this.userType});
  @override
  List<Object> get props => [isValid, userType];
}

final class PageRedirectionInvalid extends PageRedirectionState {
  final bool isValid;
  final String userType;
  const PageRedirectionInvalid({required this.isValid, required this.userType});
  @override
  List<Object> get props => [isValid, userType];
}
