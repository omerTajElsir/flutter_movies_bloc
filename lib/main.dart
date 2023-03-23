import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_movies_bloc/services/movies_list_repository.dart';
import 'UI/home/home_screen.dart';
import 'bloc/movies_list/movies_list_bloc.dart';
import 'package:sizer/sizer.dart';
Future<void> main() async {
  await dotenv.load(fileName: ".env" );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Movies App',
            home: BlocProvider(
              create: (context) => MoviesListBloc(MoviesListRepository()),
              child: HomeScreen(),
            ),
            theme: ThemeData(
                fontFamily: GoogleFonts.lato().fontFamily,
                scaffoldBackgroundColor: Colors.white,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                primaryColor: Colors.white,
                textTheme:
                TextTheme().apply(fontFamily: GoogleFonts.lato().fontFamily)),
          );
        }
    );
  }
}
