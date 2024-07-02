import 'package:flutter/cupertino.dart';

class HorizontalScrollView extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? margin;

  const HorizontalScrollView({required this.children, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        // scrollDirection: Axis.horizontal,
        child: Row(children: children),
      ),
    );
  }
}
