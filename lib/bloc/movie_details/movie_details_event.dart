import 'package:equatable/equatable.dart';

abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetMovieDetails extends MovieDetailsEvent {
  final String imdbID, title, type, year, posterURL;
  const GetMovieDetails(
      {this.posterURL, this.year, this.type, this.title, this.imdbID});

  @override
  List<Object> get props => [posterURL,year, type, title, imdbID];
}
