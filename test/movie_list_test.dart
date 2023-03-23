import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_movies_bloc/bloc/movies_list/movies_list_bloc.dart';
import 'package:flutter_movies_bloc/bloc/movies_list/movies_list_event.dart';
import 'package:flutter_movies_bloc/bloc/movies_list/movies_list_state.dart';
import 'package:flutter_movies_bloc/models/movie.dart';
import 'package:flutter_movies_bloc/services/movies_list_repository.dart';


class MockMoviesListRepository extends Mock
    implements AbstractMoviesListRepository {}

void main() {
  group('MoviesListBloc', ()
  {
    AbstractMoviesListRepository mockMoviesListRepository;
    MoviesListBloc moviesListBloc;

    final List<Movie> moviesList = [
      Movie(title: 'Inception',
        year: '2010',
        imdbID: 'tt1375666',
        type: 'movie',
        posterURL: 'https://m.media-amazon.com/images/M/MV5BMjAxMjE5NzgxNF5BMl5BanBnXkFtZTYwNTY0MDg5._V1_SX300.jpg',),
      Movie(title: 'The Dark Knight',
        year: '2008',
        imdbID: 'tt0468569',
        type: 'movie',
        posterURL: 'https://m.media-amazon.com/images/M/MV5BMTMxNTM3MTk4Ml5BMl5BanBnXkFtZTYwNjU5MzY5._V1_SX300.jpg',),
    ];

    setUp(() {
      mockMoviesListRepository = MockMoviesListRepository();
      moviesListBloc = MoviesListBloc(mockMoviesListRepository);
    });

    test('initial state is correct', () {
      expect(moviesListBloc.state, MovieInitial());
    });

    blocTest<MoviesListBloc, MoviesListState>(
      'emits [MovieLoading, MovieSearched] when SearchMovies event is added and movies are found',
      build: () {
        when(mockMoviesListRepository.searchMovie(
            title: 'inception', page: 1, year: '', type: 'all'))
            .thenAnswer((_) async => moviesList);
        return moviesListBloc;
      },
      act: (bloc) => bloc.add(SearchMovies(title: 'inception', page: 1,year: '', type: 'all')),
      expect:() => [
        MovieLoading(),
        MovieSearched(moviesFound: moviesList),
      ],
    );

    blocTest<MoviesListBloc, MoviesListState>(
      'emits [MovieLoading, MovieEmpty] when SearchMovies event is added and no movies are found',
      build: () {
        when(mockMoviesListRepository.searchMovie(
            title: 'aaasss', page: 1, year: '', type: 'all'))
            .thenAnswer((_) async => []);
        return moviesListBloc;
      },
      act: (bloc) => bloc.add(SearchMovies(title: 'aaasss', page: 1,year: '', type: 'all')),
      expect: () =>[
        MovieLoading(),
        MovieEmpty(),
      ],
    );

    blocTest<MoviesListBloc, MoviesListState>(
        'emits [MovieLoading, MovieError] when SearchMovies event is added and there is a network error',
        build: () {
          when(mockMoviesListRepository.searchMovie(
              title: 'sdfgsdfgsdgfsdfg', page: 1, year: '', type: 'test'))
              .thenThrow(NetworkError());
          return moviesListBloc;
        },
        act: (bloc) => bloc.add(SearchMovies(title: 'inception', page: 1)),
        expect: () =>[
          MovieLoading(),
          MovieError("Couldn't fetch Movies. Is the device online?")]
    );
  });}
