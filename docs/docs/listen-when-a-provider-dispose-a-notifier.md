---
sidebar_position: 6
---

# Listen when a provider has disposed a Notifier

```dart
final counterProvider = SimpleProvider<CounterController>(
  (ref) {
    ref.onDispose(() {
      // YOUR CODE HERE
    });
    return CounterController();
  },
);
```