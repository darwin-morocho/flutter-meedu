import 'package:flutter/material.dart';
import 'package:meedu/state.dart';
import 'package:meedu/rx.dart';
import 'package:meedu_example/modules/numbers/numbers_controller.dart';

class NumbersPage extends StatelessWidget {
  static const routeName = "/numbers";
  const NumbersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MeeduBuilder<NumbersController>(
      controller: NumbersController(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: RxBuilder(
            observables: [
              _.counter,
            ],
            builder: () => Text(
              "counter ${_.counter.value}",
              style: TextStyle(fontSize: 18),
            ),
          ),
          actions: [
            FlatButton(
              onPressed: _.addItem,
              child: Text("Add list item"),
            )
          ],
        ),
        body: RxBuilder(
          observables: [_.items],
          builder: () => ListView.builder(
            itemBuilder: (__, index) {
              final item = _.items.value[index];
              return ListTile(
                title: Text(item),
              );
            },
            itemCount: _.items.value.length,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _.increment,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
