import 'package:flutter/cupertino.dart';

import '../../../../utits/constants.dart';

class DetailWidget extends StatelessWidget {
  final String detail, value;
  const DetailWidget({
    Key key,
    this.detail,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          detail,
          style: lightTextStyle,
        ),
        Text(
          value,
          style:lightTextStyle,
        )
      ],
    );
  }
}