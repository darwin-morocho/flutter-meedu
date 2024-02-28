import 'package:flutter/material.dart';
import 'package:with_go_router/app/ui/pages/color/color_notifier.dart';

class ColorPage extends StatelessWidget {
  final bool isPrimary;
  final int colorIndex;
  final String tagName;
  ColorPage({
    super.key,
    required this.isPrimary,
    required this.colorIndex,
  }) : tagName = '$isPrimary-$colorIndex' {
    colorProvider.setArguments(
      colorIndex,
      tag: tagName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final index = colorProvider.read(tag: tagName).state;
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
