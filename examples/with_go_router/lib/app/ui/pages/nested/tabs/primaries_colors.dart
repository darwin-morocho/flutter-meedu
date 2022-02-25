import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/routes.dart';

class PrimariesColors extends StatefulWidget {
  final int tabIndex;
  const PrimariesColors({Key? key, required this.tabIndex}) : super(key: key);

  @override
  State<PrimariesColors> createState() => _PrimariesColorsState();
}

class _PrimariesColorsState extends State<PrimariesColors> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemBuilder: (_, index) {
        return InkWell(
          onTap: () {
            context.go('${Routes.NESTED}/${widget.tabIndex}/primaries/$index');
          },
          child: Container(
            color: Colors.primaries[index],
          ),
        );
      },
      itemExtent: 100,
      itemCount: Colors.primaries.length,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
