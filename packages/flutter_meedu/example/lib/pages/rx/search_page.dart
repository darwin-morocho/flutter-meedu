import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'package:meedu_example/pages/rx/search_controller.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<SearchController>(
      create: (_) => SearchController(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Builder(
              builder: (context) {
                final controller = Provider.of<SearchController>();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoTextField(
                      placeholder: 'debounce',
                      onChanged: controller.onTextChange,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
