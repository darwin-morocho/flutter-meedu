---
sidebar_position: 9
---

# Testing

## Cleaning your providers

Before or after each test you will need the default state of all `StateNotifier` or `Bloc`. So you can use `ProvidersContainer.clear();`

```dart
setUp((){
  ProviderScope.clear();
});

or


tearDown((){
  ProviderScope.clear();
});
```

## Overriding providers

Consider the next provider

```dart
final loginProvider = Provider.state<LoginNotifier, LoginState>(
  (_) => LoginNotifier(
    LoginState(),
    someRepo: SomeRepo(),
  ),
);
```

Sometimes, for our unit tests or widget tests, we need to mock the behavior of a certain class. In those cases, we can use the `overrideCreator` function to override the way our provider creates our notifiers.

```dart
class MockSomeRepo extends Mock implements SomeRepo {}
```

Next before your test you can use the `setUp` method.

```dart {5}
setUp((){
  loginProvider.overrideCreator(
    (_) => LoginNotifier(
      LoginState(),
      someRepo: MockSomeRepo(), // mocked repo
    ),
  );

});
```
