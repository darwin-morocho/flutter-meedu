import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_meedu/ui.dart';

void main() {
  testWidgets('screen utils', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: _Page(),
      ),
    );
    await tester.pump();
    expect(find.text("isPhone: false"), findsOneWidget);
  });
}

class _Page extends StatefulWidget {
  const _Page({Key? key}) : super(key: key);

  @override
  __PageState createState() => __PageState();
}

class __PageState extends State<_Page> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then(
      (_) {
        print("👏 provider page test onAfterFirstLayout");
        print("context.mediaQuery ${context.mediaQuery}");
        print("context.theme ${context.theme}");
        print("context.textTheme ${context.textTheme}");
        print("context.mediaQueryPadding ${context.mediaQueryPadding}");
        print("context.devicePixelRatio ${context.devicePixelRatio}");
        print("context.mediaQueryShortestSide ${context.mediaQueryShortestSide}");
        print("context.mediaQuerySize ${context.mediaQuerySize}");
        print("context.mediaQueryViewInsets ${context.mediaQueryViewInsets}");
        print("context.mediaQueryViewPadding ${context.mediaQueryViewPadding}");
        print("context.isPortrait ${context.isPortrait}");
        print("context.isLandscape ${context.isLandscape}");
        print("context.isPhone ${context.isPhone}");
        print("context.isPhone ${context.isSmallPhone}");
        print("context.isLargeTablet ${context.isLargeTablet}");
        print("context.isTablet ${context.isTablet}");
        print("context.width ${context.width}");
        print("context.height ${context.height}");
        print("context.textScaleFactor ${context.textScaleFactor}");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("isPhone: ${context.isPhone}"),
      ),
    );
  }
}
