import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_movies_bloc/models/movie.dart';
import 'package:flutter_movies_bloc/services/movies_list_repository.dart';
import 'movies_list_event.dart';
import 'movies_list_state.dart';

class MoviesListBloc extends Bloc<MoviesListEvent, MoviesListState> {
  final AbstractMoviesListRepository abstractMovieRepository;

  MoviesListBloc(this.abstractMovieRepository) : super(MovieInitial()) {
    on<SearchMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        final List<Movie> moviesFound =
        await abstractMovieRepository.searchMovie(
            title: event.title,
            page: event.page,
            year: event.year,
            type: event.type);
        if(moviesFound.isEmpty){
          emit(MovieEmpty());
        }else{
          emit(MovieSearched(moviesFound: moviesFound));
        }
      } on Error {
        emit(MovieError("Couldn't fetch Movies. Is the device online?"));
      }
    });
  }
}
