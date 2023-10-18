---
sidebar_position: 8
---

# Listen when a provider has disposed a Notifier

```dart
final counterProvider = Provider.state<CounterNotifier,int>(
  (ref) {
    ref.onDispose(() {
      // YOUR CODE HERE
    });
    return CounterNotifier();
  },
);
```
