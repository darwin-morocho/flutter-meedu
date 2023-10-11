---
sidebar_position: 9
---

# Testing

## Overriding providers
Consider the next provider
```dart
final loginProvider = StateProvider<LoginController, LoginState>(
  (_) => LoginController(),
);
```

So, maybe in one test you need mock the LoginController behavior then you can use the `overrideProvider` method.
```dart
import 'package:mocktail/mocktail.dart';

final loginProvider = StateProvider<LoginController, LoginState>(
  (_) => LoginController(),
);

class MockLoginController extends Mock implements LoginController {}
```

Next before your test you can use the `setUp` method.
```dart
setUp((){
  loginProvider.overrideProvider(
    (_) => MockLoginController(),
  );
});
```

## Cleaning your providers
Before or after each test you will need the default state of all SimpleNotifier or StateNotifier. So you can use `ProviderScope.clear();` to clear all provider saved in the ProviderScope.

```dart
setUp((){
  ProviderScope.clear();
});

or 


tearDown((){
  ProviderScope.clear();
});
```