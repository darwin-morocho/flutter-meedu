---
sidebar_position: 2
---

# State Managment

You have to ways to manage the state of your widgets or pages:
- Using a  `SimpleNotifier` similiar to `ChangeNotifier` for a simple state.
- Using a `StateNotifier` for complex states.


# Auto dispose feature
The **life cycle** of a `SimpleNotifier` or a `StateNotifier` by default is attached to one `Route`. It means that our notifiers will be disposed when the `route` who created the `SimpleNotifier` or a `StateNotifier` is popped.

First **flutter_meedu** needs to listen the changes in your route navigator. This is very simple in your `main.dart` file add the next code

```dart {15} title="main.dart"
import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(    
       home: YourHomePage(),
       navigatorObservers: [
         router.observer,// <-- this allows to flutter_meedu listen the changes in your navigator
       ],
    );
  }
}
```
