import 'package:flutter_movies_bloc/models/movie.dart';
import 'package:flutter_movies_bloc/services/network.dart';
import 'package:flutter_movies_bloc/utits/constants.dart';

abstract class AbstractMoviesListRepository {
  Future<List<Movie>> searchMovie(
      {String title, String type, String year, int page});
}

class MoviesListRepository implements AbstractMoviesListRepository {


  @override
  Future<List<Movie>> searchMovie(
      {String title, String type, String year, int page}) async {
    final String _apiUrl = baseUrl + apiKey;
    String finalURL = _apiUrl;

    if (title.isNotEmpty) {
      finalURL = finalURL + '&s=$title';
    }
    if (year.isNotEmpty && year != '') {
      int yearNumber = int.parse(year);
      if (yearNumber > 1900 && yearNumber < DateTime.now().year - 1) {
        finalURL = finalURL + '&y=$yearNumber';
      }
    }
    if (type.isNotEmpty && type != '') {
      if (type != 'all') finalURL = finalURL + '&type=$type';
    }
    if (page != null) finalURL = finalURL + '&page=$page';

    NetworkHelper networkHelper = NetworkHelper(finalURL);
    var data = await networkHelper.getData();
    bool resultsFound = data['Response'] == 'True';

    List<Movie> moviesFound = [];

    if (resultsFound ) {
      int totalResults =
          int.tryParse(data['totalResults']) ?? (resultsFound ? 1 : 0);
      if(totalResults >= 1){
        List movieList = data['Search'];
        for (var m in movieList) {
          moviesFound.add(Movie(
              totalResults: data['totalResults'],
              title: m['Title'],
              year: m['Year'],
              imdbID: m['imdbID'],
              type: m['Type'],
              posterURL: m['Poster'] == 'N/A'
                  ? 'https://images.unsplash.com/photo-1485846234645-a62644f84728?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'
                  : m['Poster']));
        }
        return moviesFound;
      }else{
        return [];
      }
    } else{
      if(data['Error'].toString().toLowerCase() == "movie not found!"){
        return [];
      }else{
        throw NetworkError();
      }
    }
  }
}

class NetworkError extends Error {}
