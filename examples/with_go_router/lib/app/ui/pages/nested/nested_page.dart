import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:with_go_router/app/ui/pages/nested/tabs/accents_colors.dart';
import 'package:with_go_router/app/ui/pages/nested/tabs/primaries_colors.dart';
import 'package:with_go_router/app/ui/routes/routes.dart';

class NestedPage extends StatefulWidget {
  final int index;
  const NestedPage({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<NestedPage> createState() => _NestedPageState();
}

class _NestedPageState extends State<NestedPage> with TickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 2,
      initialIndex: widget.index,
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(covariant NestedPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.index = widget.index;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap(index) {
    context.go("${Routes.NESTED}/$index");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title(context),
        ),
        bottom: TabBar(
          controller: _controller,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white24,
          tabs: const [
            Tab(
              icon: Icon(Icons.palette),
            ),
            Tab(
              icon: Icon(Icons.favorite),
            ),
          ],
          onTap: _onTap,
        ),
      ),
      body: TabBarView(
        children: const [
          PrimariesColors(
            tabIndex: 0,
          ),
          AccentsColors(
            tabIndex: 1,
          ),
        ],
        controller: _controller,
      ),
    );
  }

  String _title(BuildContext context) {
    return (context as Element).findAncestorWidgetOfExactType<MaterialApp>()!.title;
  }
}
