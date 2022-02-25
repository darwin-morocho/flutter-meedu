import 'package:flutter/material.dart';
import 'package:with_go_router/app/ui/pages/color/color_controller.dart';

class ColorPage extends StatelessWidget {
  final bool isPrimary;
  final int colorIndex;
  final String tagName;
  ColorPage({
    Key? key,
    required this.isPrimary,
    required this.colorIndex,
  })  : tagName = '$isPrimary-$colorIndex',
        super(key: key) {
    colorProvider.setArguments(
      tagName,
      colorIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final index = colorProvider.find(tagName).read.color;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: (isPrimary ? Colors.primaries : Colors.accents)[index],
        child: Center(
          child: Text(tagName),
        ),
      ),
    );
  }
}
