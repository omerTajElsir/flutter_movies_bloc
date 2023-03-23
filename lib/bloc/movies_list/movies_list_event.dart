import 'package:equatable/equatable.dart';

abstract class MoviesListEvent extends Equatable {
  const MoviesListEvent();
  @override
  List<Object> get props => [];
}

class SearchMovies extends MoviesListEvent {
  final String title, type, year;
  final int page;
  const SearchMovies({this.title, this.type, this.year, this.page});

  @override
  List<Object> get props => [title, type, year, page];
}


