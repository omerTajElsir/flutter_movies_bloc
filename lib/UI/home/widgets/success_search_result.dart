import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_bloc/bloc/movie_details/movie_details_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../bloc/movies_list/movies_list_bloc.dart';
import '../../../../bloc/movies_list/movies_list_event.dart';
import '../../../../models/movie.dart';
import '../../../../services/movie_details_repository.dart';
import '../../../../utits/constants.dart';
import '../../movie_details/movie_details.dart';

class SuccessearchResult extends StatefulWidget {
  final List<Movie> moviesFound;
  SuccessearchResult({Key key, this.moviesFound}) : super(key: key);

  @override
  State<SuccessearchResult> createState() => _SuccessearchResultState();
}

class _SuccessearchResultState extends State<SuccessearchResult> {


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.moviesFound.length,
      itemBuilder: (ctx, index) {
        return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) =>
                    BlocProvider(
                      create: (context) =>
                          MovieDetailsBloc(MovieDetailsRepository()),
                      child: MovieDetailsPage(
                        movieData: widget.moviesFound[index],
                      ),
                    ),
              ));
            },
          child: Container(
            height: SizerUtil.deviceType == DeviceType.mobile?80:120,
            child:
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                widget.moviesFound[index].posterURL,
                              )),
                          borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                      ),
                    ),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.moviesFound[index].title,style: inlineTesxtStyle,),
                        SizedBox(height: 4,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(widget.moviesFound[index].year,style: lightTextStyle,),
                            Text(
                              ' (' + widget.moviesFound[index].type + ')',
                              style: lightTextStyle.copyWith(color: Colors.grey),
                            )
                          ],
                        )
                      ],
                    ))
                  ],
                ),
          ),
        );
      },
    );
  }
}
