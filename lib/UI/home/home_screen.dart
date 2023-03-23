import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/movies_list/movies_list_bloc.dart';
import '../../../bloc/movies_list/movies_list_event.dart';
import '../../../bloc/movies_list/movies_list_state.dart';
import 'widgets/erros_search_result.dart';
import 'widgets/success_search_result.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedPage = 1;
  int pages = 1;

  final _fullSearchKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();

  String type = 'all';

  String year = '';

  MoviesListBloc _bloc;
  //
  @override
  void initState() {

    _bloc = BlocProvider.of<MoviesListBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Form(
              key: _fullSearchKey,
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 15, 15, 8),
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: TextFormField(
                          controller: controller,
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            hintText: 'Search',
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            errorStyle: TextStyle(color: Colors.grey),
                          ),
                          onChanged: (v) {
                            _fullSearchKey.currentState.validate();
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter keyword to search';
                            }

                            if (value.length < 3) {
                              return 'Please enter more than 3 characters';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 15, 8),
                        child: Row(
                          children: <Widget>[
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width / 3,
                                  minHeight: 50,
                                  maxHeight: 70),
                              child: TextFormField(
                                initialValue: year,
                                onChanged: onYearChanged,
                                decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: 'Year',
                                  contentPadding: EdgeInsets.all(8),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                    BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                    BorderSide(color: Colors.transparent),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                    BorderSide(color: Colors.transparent),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                    BorderSide(color: Colors.transparent),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                    BorderSide(color: Colors.transparent),
                                  ),
                                  errorStyle: TextStyle(color: Colors.grey),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value.isNotEmpty) if (value.length != 4) {
                                    return 'Please enter valid year';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width / 3,
                                  maxHeight: 70,
                                  minHeight: 50),
                              child: DropdownButton(
                                value: type,
                                onChanged: onTypeChanged,
                                elevation: 0,
                                underline: SizedBox(),
                                dropdownColor: Colors.grey.shade100,
                                focusColor: Colors.red,
                                items: [
                                  DropdownMenuItem(
                                    child: Text('All'),
                                    value: 'all',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Movie'),
                                    value: 'movie',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Series'),
                                    value: 'series',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Episode'),
                                    value: 'episode',
                                  )
                                ],
                              ),
                            ),
                            const Expanded(child: const SizedBox()),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  if (_fullSearchKey.currentState.validate()) {
                                    setState(() {
                                      selectedPage = 1;
                                      pages = 1;
                                    });
                                    startSearch(
                                        context: context,
                                        title: controller.text,
                                        page: 1,
                                        type: type,
                                        year: year);
                                  }else
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.grey.shade200,
                                        content: Text(
                                          'Enter required fields',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    );
                                },
                                icon: Icon(Icons.search),
                                label: Text(
                                  'Search',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),

                ],
              ),
            ),
            Expanded(
              child: BlocListener<MoviesListBloc, MoviesListState>(
                  listener: (context, state) {
                    if (state is MovieError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                    if(state is MovieSearched){
                      int totalResults = int.parse(state.moviesFound[0].totalResults);
                      pages = (totalResults / 10).ceil();
                      setState(() {
                      });
                    }
                  },
                  child: BlocBuilder<MoviesListBloc, MoviesListState>(
                    builder: (context, state) {
                      if (state is MovieInitial)
                        return ErrorsSearchResult(title: "Movie finder!",desc: "start by searching your favorite movie",icon: "assets/images/search.png",);
                      else if (state is MovieError)
                        return ErrorsSearchResult(title: "Something went wrong!",desc: "Please check your internet connection and try again",icon: "assets/images/error.png",);
                       else if (state is MovieLoading)
                        return buildLoading();
                      else if (state is MovieEmpty)
                        return ErrorsSearchResult(title: "No movie found!",desc: "Please enter different parameters",icon: "assets/images/empty.png",);
                      else if (state is MovieSearched)
                        return SuccessearchResult(moviesFound: state.moviesFound);
                       else
                        return ErrorsSearchResult(title: "Something went wrong!",desc: "Please check your internet connection and try again",icon: "assets/images/error.png",);
                    },
                  ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                selectedPage > 1
                    ? Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        selectedPage--;
                        startSearch(
                            context: context,
                            title: controller.text,
                            page: selectedPage,
                            type: type,
                            year: year);
                      },
                      icon: Icon(Icons.navigate_before),
                      // color: Color(0xff4A148C),
                      // textColor: Colors.white,
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(10)),
                      label: Text('Previous Page')),
                )
                    : SizedBox(),
                selectedPage < pages
                    ? Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          selectedPage++;
                        });
                        startSearch(
                            context: context,
                            title: controller.text,
                            page: selectedPage,
                            type: type,
                            year: year);
                      },
                      icon: Icon(Icons.navigate_next),
                      // color: Color(0xff4A148C),
                      // textColor: Colors.white,
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(10)),
                      label: Text('Next Page')),
                )
                    : SizedBox()
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onYearChanged(v) {
                                year = v;
                              }

  void onTypeChanged(v) {
                                setState(() {
                                  type = v;
                                });

                              }
  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void startSearch(

      {BuildContext context,
        String title,
        String year,
        int page,
        String type}) {
    // ignore: close_sinks
    _bloc
        .add(SearchMovies(title: title, year: year, page: page, type: type));
  }
}
