import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

import 'controller.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final controller = homeTabProvider.read;
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RxBuilder(
            (_) => Text("${controller.counter.value}"),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              controller.counter.value++;
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
