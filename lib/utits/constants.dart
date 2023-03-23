import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sizer/sizer.dart';

String apiKey = dotenv.env['API_KEY'];
String baseUrl = dotenv.env['BASE_URL'];

 TextStyle headingStyle = TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700);
 TextStyle bodyTextStyle =
    TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w300);
 TextStyle lightTextStyle =
TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w200);
 TextStyle inlineTesxtStyle =
TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300);

enum Plot { short, full }

enum Type { movie, series, episode }
