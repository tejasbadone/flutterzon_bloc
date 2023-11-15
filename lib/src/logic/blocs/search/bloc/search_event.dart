part of 'search_bloc.dart';

class SearchEvent extends Equatable {
  final String searchQuery;

  const SearchEvent({required this.searchQuery});

  @override
  List<Object> get props => [searchQuery];
}
