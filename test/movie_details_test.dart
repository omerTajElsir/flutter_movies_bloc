import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_movies_bloc/bloc/movie_details/movie_details_bloc.dart';
import 'package:flutter_movies_bloc/bloc/movie_details/movie_details_event.dart';
import 'package:flutter_movies_bloc/bloc/movie_details/movie_details_state.dart';
import 'package:flutter_movies_bloc/models/movie.dart';
import 'package:flutter_movies_bloc/services/movie_details_repository.dart';


class MockMovieDetailsRepository extends Mock
    implements AbstractMovieDetailsRepository {}

void main() {
  group('MovieDetailsBloc', ()
  {
    AbstractMovieDetailsRepository mockMovieDetailsRepository;
    MovieDetailsBloc movieDetailsBloc;

    Movie movieDetails =  Movie(title: 'Inception',
      year: '2010',
      imdbID: 'tt1375666',
      type: 'movie',
      posterURL: 'https://m.media-amazon.com/images/M/MV5BMjAxMjE5NzgxNF5BMl5BanBnXkFtZTYwNTY0MDg5._V1_SX300.jpg',);

    setUp(() {
      mockMovieDetailsRepository = MockMovieDetailsRepository();
      movieDetailsBloc = MovieDetailsBloc(mockMovieDetailsRepository);
    });

    test('initial state is correct', () {
      expect(movieDetailsBloc.state, MovieDetailsLoading());
    });

    blocTest<MovieDetailsBloc, MovieDetailsState>(
      'emits [MovieDetailsLoading, MovieDetailsLoaded] when GetMovieDetails event is added and movie is found',
      build: () {
        when(mockMovieDetailsRepository.getMovieDetails(
            imdbID:"1", title: 'inception', year: '', type: 'all',posterURL: ""))
            .thenAnswer((_) async => movieDetails);
        return movieDetailsBloc;
      },
      act: (bloc) => bloc.add(GetMovieDetails(
      imdbID:"1", title: 'inception', year: '', type: 'all',posterURL: "")),
      expect:() => [
        MovieDetailsLoading(),
        MovieDetailsLoaded(movieDetails),
      ],
    );

    blocTest<MovieDetailsBloc, MovieDetailsState>(
      'emits [MovieDetailsLoading, MovieDetailsError] when GetMovieDetails event is added and movie in not found',
      build: () {
        when(mockMovieDetailsRepository.getMovieDetails(
            imdbID:"99982772", title: 'sdfsfsdfsdf', year: '', type: 'all',posterURL: ""))
            .thenThrow(NetworkError());
        return movieDetailsBloc;
      },
      act: (bloc) => bloc.add(GetMovieDetails(
          imdbID:"12", title: 'sdfsfsdfsdf', year: '', type: 'all',posterURL: "")),
      expect:() => [
        MovieDetailsLoading(),
        MovieDetailsError("Couldn't fetch Details. Is the device online?"),
      ],
    );
  });

}
