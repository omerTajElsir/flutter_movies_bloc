import 'package:flutter_movies_bloc/models/movie.dart';
import 'package:flutter_movies_bloc/services/network.dart';
import 'package:flutter_movies_bloc/utits/constants.dart';

abstract class AbstractMovieDetailsRepository {
  Future<Movie> getMovieDetails(
      {String imdbID,
      String title,
      String type,
      String year,
      String posterURL});
}

class MovieDetailsRepository implements AbstractMovieDetailsRepository {
  @override
  Future<Movie> getMovieDetails(
      {String imdbID,
      String title,
      String type,
      String year,
      String posterURL}) async {
    final String _apiUrl = baseUrl + apiKey;
    String finalURL = _apiUrl;
    finalURL = finalURL + '&i=$imdbID';
    finalURL = finalURL + '&plot=long';
    NetworkHelper networkHelper = NetworkHelper(finalURL);
    var data = await networkHelper.getData();
    bool resultsFound = data['Response'] == 'True';
    if (resultsFound) {
      return Movie(
          title: data['Title'] ?? 'N/A',
          year: data['Year'] ?? 'N/A',
          rated: data['Rated'] ?? 'N/A',
          released: data['Released'] ?? '',
          runTime: data['Runtime'] ?? 'N/A',
          genre: data['Genre'] ?? 'N/A',
          director: data['Director'] ?? 'N/A',
          writer: data['Writer'] ?? 'N/A',
          actors: data['Actors'] ?? 'N/A',
          plot: data['Plot'] ?? 'N/A',
          language: data['Language'] ?? 'N/A',
          country: data['Country'] ?? 'N/A',
          awards: data['Awards'] ?? 'N/A',
          ratings: data['Ratings'] ?? 'N/A',
          metaScore: data['Metascore'] ?? 'N/A',
          imdbRating: data['imdbRating'] ?? 'N/A',
          imdbVotes: data['imdbVotes'] ?? 'N/A',
          imdbID: data['imdbID'] ?? 'N/A',
          type: data['Type'] ?? 'N/A',
          dvd: data['DVD'] ?? 'N/A',
          boxOffice: data['BoxOffice'] ?? 'N/A',
          production: data['Production'] ?? 'N/A',
          website: data['Website'] ?? 'N/A',
          response: data['Response'],
          posterURL: data['Poster'] == 'N/A'
              ? 'https://images.unsplash.com/photo-1485846234645-a62644f84728?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'
              : data['Poster']);
    } else
      throw NetworkError();


  }

}

class NetworkError extends Error {}
