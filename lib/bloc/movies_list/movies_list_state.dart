import 'package:equatable/equatable.dart';
import 'package:flutter_movies_bloc/models/movie.dart';

abstract class MoviesListState extends Equatable {
  const MoviesListState();
  @override
  List<Object> get props => [];
}

class MovieInitial extends MoviesListState {
  @override
  List<Object> get props => [];
}

class MovieLoading extends MoviesListState {
  const MovieLoading();
  @override
  List<Object> get props => [];
}

class MovieEmpty extends MoviesListState {
  const MovieEmpty();
  @override
  List<Object> get props => [];
}

class MovieSearched extends MoviesListState {
  final List<Movie> moviesFound;

  const MovieSearched({
    this.moviesFound,
  });
  @override
  List<Object> get props => [
        moviesFound,
      ];
}

class MovieError extends MoviesListState {
  final String message;
  const MovieError(this.message);
  @override
  List<Object> get props => [message];
}
