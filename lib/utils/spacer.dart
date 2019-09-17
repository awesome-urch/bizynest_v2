import 'package:flutter/material.dart';

final _spacer = Container(
  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
);

final _spacerSmall = Container(
  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
);

final _spacerVertical = Container(
  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
);

final _spacerVerticalSmall = Container(
  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
);

class MySpacer extends StatelessWidget {
  static const int MEDIUM = 0;
  static const int SMALL = 1;

  final bool isVertical;
  final int size;

  MySpacer({
    Key key,
    this.isVertical = false,
    this.size = MEDIUM,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double padding;
    switch (size) {
      case SMALL:
        padding = 5;
        break;
      case MEDIUM:
      default:
        padding = 10;
        break;
    }

    // TODO: implement build
    return Container(
      padding: isVertical
          ? EdgeInsets.fromLTRB(padding, 0, padding, 0)
          : EdgeInsets.fromLTRB(0, padding, 0, padding),
    );
  }
}
