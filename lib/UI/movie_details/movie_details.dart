import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_bloc/UI/movie_details/widgets/details_entry_widget.dart';
import 'package:flutter_movies_bloc/UI/movie_details/widgets/star_rating_widget.dart';
import 'package:flutter_movies_bloc/models/movie.dart';
import 'package:flutter_movies_bloc/utits/constants.dart';

import '../../../bloc/movie_details/movie_details_bloc.dart';
import '../../../bloc/movie_details/movie_details_event.dart';
import '../../../bloc/movie_details/movie_details_state.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movieData;
  const MovieDetailsPage({Key key, this.movieData}) : super(key: key);
  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {

  MovieDetailsBloc _bloc;
  //
  @override
  void initState() {

    _bloc = BlocProvider.of<MovieDetailsBloc>(context);
    _bloc
        .add(GetMovieDetails(
      posterURL: widget.movieData.posterURL,
      year: widget.movieData.year,
      title: widget.movieData.title,
      imdbID: widget.movieData.imdbID,
      type: widget.movieData.type,
    ));
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocListener<MovieDetailsBloc, MovieDetailsState>(
            listener: (context, state) {
              if (state is MovieDetailsError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
              builder: (context, state) {
                if (state is MovieDetailsLoaded)
                  return buildResults(context, state.movie);
                else if (state is MovieDetailsLoading){

                  return buildLoading();
                }
                else if (state is MovieDetailsError)
                  return buildError(state.message);
                else
                  return SizedBox();
              },
            ),


      ),
    );
  }

  Widget buildInitial() {
    return CircularProgressIndicator();
  }

  Widget buildError(String message) {
    return Center(
      child: Text(message),
    );
  }

  buildResults(BuildContext context, Movie movie) {
    return ListView(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter:
                  ColorFilter.mode(Colors.grey.shade300, BlendMode.screen),
              fit: BoxFit.cover,
              image: NetworkImage(movie.posterURL),
            ),
          ),
          child: Stack(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.8,
              ),
              Positioned.fill(
                bottom: 40,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(movie.posterURL),
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    height: MediaQuery.of(context).size.height / 2.7,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ),
              ),
              Positioned.fill(
                top: 45,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      movie.title,
                      textAlign: TextAlign.center,
                      style:
                          headingStyle,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.arrow_back_ios_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 2.0,
            ),
            child: Text(
              movie.imdbRating,
              style: headingStyle,
            ),
          ),
        ),
        Center(
          child: movie.imdbRating!="N/A"?StarRatingWidget(value: int.tryParse(
                  double.tryParse(movie.imdbRating).floor().toString())) :
              Text('N/A'),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            DetailWidget(
              detail: 'Length',
              value: movie.runTime,
            ),
            DetailWidget(
              detail: 'Language',
              value: movie.language.split(',')[0],
            ),
            DetailWidget(
              detail: 'Year',
              value: movie.year,
            ),
            DetailWidget(
              detail: 'Country',
              value: movie.country.split(',')[0],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15),
          child: Text(
            'Storyline',
            style: bodyTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
          child: Text(movie.plot,style: lightTextStyle,),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15),
          child: Text(
            'Genre',
            style: bodyTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
          child: Text(movie.genre,style: lightTextStyle,),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
          child: Text(
            'Ratings',
            style: bodyTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('IMDB : ',style: lightTextStyle,),
              Text(movie.imdbRating == 'N/A'
                  ? 'No Information'
                  : movie.imdbRating,style: lightTextStyle,),
              Text(' ( ${movie.imdbVotes} votes )',style: lightTextStyle,),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('MetaScore : ',style: lightTextStyle,),
              Text(movie.metaScore == 'N/A' ? 'Not rated' : movie.metaScore,style: lightTextStyle,)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15),
          child: Text(
            'Cast',
            style: bodyTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
          child: Text(movie.actors,style: lightTextStyle,),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15),
          child: Text(
            'Director',
            style: bodyTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
          child: Text(movie.director,style: lightTextStyle,),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15),
          child: Text(
            'Writer',
            style: bodyTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
          child: Text(movie.writer,style: lightTextStyle,),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15),
          child: Text(
            'Detailed Information',
            style: bodyTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, top: 15, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[Text('Released : '), Text(movie.released)],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[Text('Language : '), Text(movie.language)],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Rated : ',style: lightTextStyle,),
              Text(movie.rated == 'N/A' ? 'No Information' : movie.rated,style: lightTextStyle,)
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[Text('Country : ',style: lightTextStyle,), Text(movie.country,style: lightTextStyle,)],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Awards : ',style: lightTextStyle,),
              Expanded(
                  child: Text(
                      movie.awards == 'N/A' ? 'No Information' : movie.awards,style: lightTextStyle,))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('DVD : ',style: lightTextStyle,),
              Text(movie.dvd == 'N/A' ? 'No Information' : movie.dvd,style: lightTextStyle,)
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Box Office : ',style: lightTextStyle,),
              Text(
                  movie.boxOffice == 'N/A' ? 'No Information' : movie.boxOffice,style: lightTextStyle,)
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Production : ',style: lightTextStyle,),
              Text(movie.production == 'N/A'
                  ? 'No Information'
                  : movie.production,style: lightTextStyle,)
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Website : ',style: lightTextStyle,),
              Text(movie.website == 'N/A' ? 'No Information' : movie.website,style: lightTextStyle,)
            ],
          ),
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }


  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}




