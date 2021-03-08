import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meedu/meedu.dart';

void main() {
  group('provider page', () {
    test('provider create assert', () {
      expect(() {
        Provider(create: null);
      }, throwsAssertionError);
    });

    testWidgets('provider page', (test) async {
      await test.pumpWidget(
        MaterialApp(
          home: HomePage(),
        ),
      );

      expect(find.text("0"), findsOneWidget);
      await test.tap(find.text("add"));
      await test.pump();
      expect(find.text("1"), findsOneWidget);
    });
  });
}

class HomePage extends ProviderPage<Controller> {
  @override
  Controller create(BuildContext context) => Controller();

  @override
  void onInit(BuildContext context, Controller controller) {
    super.onInit(context, controller);
    print("👏 provider page test onInit");
    print("GetPlatform.isAndroid ${GetPlatform.isAndroid}");
    print("GetPlatform.isIOS ${GetPlatform.isIOS}");
    print("GetPlatform.isFuchsia ${GetPlatform.isFuchsia}");
    print("GetPlatform.isLinux ${GetPlatform.isLinux}");
    print("GetPlatform.isMacOS ${GetPlatform.isMacOS}");
    print("GetPlatform.isWindows ${GetPlatform.isWindows}");
    print("GetPlatform.isWeb ${GetPlatform.isWeb}");
    print("GetPlatform.isDesktop ${GetPlatform.isDesktop}");
    print("GetPlatform.isMobile ${GetPlatform.isMobile}");
  }

  @override
  void onAfterFirstLayout(BuildContext context, Controller controller) {
    super.onAfterFirstLayout(context, controller);
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
    print("context.isLargeTablet ${context.isLargeTablet}");
    print("context.isTablet ${context.isTablet}");
    print("context.width ${context.width}");
    print("context.height ${context.height}");
    print("context.textScaleFactor ${context.textScaleFactor}");
    print("context.showNavbar ${context.showNavbar}");
    print("context.heightTransformer(dividedBy: 3) ${context.heightTransformer(dividedBy: 3)}");
    print("context.widthTransformer(dividedBy: 3) ${context.widthTransformer(dividedBy: 3)}");
    print("context.ratio(dividedBy: 3) ${context.ratio(dividedBy: 3)}");
  }

  @override
  Widget buildPage(BuildContext context, Controller controller) {
    return Scaffold(
      body: SimpleBuilder<Controller>(
        builder: (_) => Text("${_.counter}"),
      ),
      floatingActionButton: FlatButton(
        child: Text("add"),
        onPressed: controller.imcrement,
      ),
    );
  }
}

class Controller extends SimpleController {
  int counter = 0;

  void imcrement() {
    counter++;
    update();
  }
}
