import 'package:equatable/equatable.dart';
import 'package:flutter_movies_bloc/models/movie.dart';

abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();
  @override
  List<Object> get props => [];
}

class MovieDetailsInitial extends MovieDetailsState {
  @override
  List<Object> get props => [];
}

class MovieDetailsLoading extends MovieDetailsState {
  const MovieDetailsLoading();
  @override
  List<Object> get props => [];
}




class MovieDetailsLoaded extends MovieDetailsState {
  final Movie movie;

  const MovieDetailsLoaded(this.movie);
  @override
  List<Object> get props => [movie];
}

class MovieDetailsError extends MovieDetailsState {
  final String message;
  const MovieDetailsError(this.message);
  @override
  List<Object> get props => [message];
}
