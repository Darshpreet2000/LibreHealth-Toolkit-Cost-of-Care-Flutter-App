import 'package:flutter/material.dart';

class StarDisplay extends StatelessWidget {
  final String value;

  const StarDisplay({Key key, this.value = "N/A"})
      : assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      int intValue = int.parse(value);
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(5, (index) {
              return Icon(
                index < intValue ? Icons.star : Icons.star_border,
              );
            }),
          ));
    } catch (e) {
      return Text("N/A");
    }
  }
}
