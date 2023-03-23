import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/movie.dart';
import '../../services/movie_details_repository.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final AbstractMovieDetailsRepository abstractMovieRepository;

  MovieDetailsBloc(this.abstractMovieRepository) : super(MovieDetailsLoading()) {

    on<GetMovieDetails>((event, emit) async {
      emit(MovieDetailsLoading());
      try {
        Movie movie = await abstractMovieRepository.getMovieDetails(
            imdbID: event.imdbID,
            type: event.type,
            title: event.title,
            year: event.year,
            posterURL: event.posterURL);
        if(movie == null){
          emit(MovieDetailsError("Couldn't fetch Details. Is the device online?"));
        }else{
          emit(MovieDetailsLoaded(movie));
        }

      } on Error {
        emit(MovieDetailsError("Couldn't fetch Details. Is the device online?"));
      }
    });
  }

}
