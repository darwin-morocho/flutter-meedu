import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/routes.dart';

class AccentsColors extends StatefulWidget {
  final int tabIndex;
  const AccentsColors({Key? key, required this.tabIndex}) : super(key: key);

  @override
  State<AccentsColors> createState() => _AccentsColorsState();
}

class _AccentsColorsState extends State<AccentsColors> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemBuilder: (_, index) {
        return InkWell(
          onTap: () {
            context.go('${Routes.NESTED}/${widget.tabIndex}/accents/$index');
          },
          child: Container(
            color: Colors.accents[index],
          ),
        );
      },
      itemExtent: 100,
      itemCount: Colors.accents.length,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
