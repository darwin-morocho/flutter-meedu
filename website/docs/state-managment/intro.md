---
sidebar_position: 2
---

# Configuration

## How it works?

You have to ways to manage the state of your widgets or pages:
- Using a  `SimpleNotifier` similiar to `ChangeNotifier` for a simple state.
- Using a `StateNotifier` for complex states.

:::success
If you are using **visual studio code** you can use this [extension](https://marketplace.visualstudio.com/items?itemName=meedu.meedu) for a fast development with flutter_meedu
:::


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


:::info With Navigator 2.0
If you are using navigator 2.0 or any package to navigate using navigator 2.0 to enable the auto dispose feature you must add the meedu observer (`router.observer`) inside the navigatorObservers of your delegate or your Navigator widget.
:::