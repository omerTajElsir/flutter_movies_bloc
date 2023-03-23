import 'package:flutter/material.dart';

import '../../../../utits/constants.dart';

class ErrorsSearchResult extends StatefulWidget {
  final String title;
  final String desc;
  final String icon;
  ErrorsSearchResult({Key key,this.title,this.desc,this.icon}) : super(key: key);

  @override
  State<ErrorsSearchResult> createState() => _ErrorsSearchResultState();
}

class _ErrorsSearchResultState extends State<ErrorsSearchResult> {

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        Center(
          child: Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 4,
              child: Image.asset(widget.icon)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.title,
            style: headingStyle,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(8.0, 0, 8, 8),
          child: Text(
            widget.desc,
            style: bodyTextStyle,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }


}
