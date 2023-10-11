---
sidebar_position: 3
---

# Avoid rebuilds using filters

Sometimes our app has some UI components that consume a lot of resources, and it is very important to prevent unnecessary UI rebuilds or code execution to improve app performance. In that case, you can use the `select` and the `when` filters.

## `.select` filter

If you have multiple `Consumer` widgets in your Views and you only want to rebuild a certain `Consumer` to improve your app's performance, you can use the `.select` filter.

Consider the following example where we use the `.select` filter to only rebuild our `Consumer` when the `email` value in our state has been changed.

```dart {4-6}
Consumer(
  builder: (_, ref, __) {
      final email = ref.watch(
        loginProvider.select(
          (state) => state.email,
        ),
      ).state.email;

      return Text(email);
  }
)
```

If you want direct access to the value returned by `loginProvider.select((state) => state.email)` you can use `ref.select`

```dart {4-6}
Consumer(
  builder: (_, ref, __) {
    final email = ref.select(
      loginProvider.select(
        (state) => state.email,
      ),
    );
    return Text(email);
  },
)
```

## `.when` filter

The `.when` filter is useful when we need to compare our current state with the previous to decide if our consumers must be rebuilt.

:::note
The `.when` filter only can be used with `ref.watch`.
:::

In the next example, our `Consumer` is only rebuilt if the previous password state is different from the current password state.

```dart {4-6}
Consumer(
  builder: (_, ref, __) {
    final notifier = ref.watch(
      loginProvider.when(
        (prev, current) => prev.password != current.password,
      ),
    );
    return Text(notifier.state.password);
  },
)
```

## `.select` filter with boolean values

Considere the next example

```dart
Consumer(
  builder: (_, ref, __) {
    final counter = ref.watch(
            counterProvider.select(
              (state) => state > 5,
            ),
          ).state;
    return Text("${counter}");
  },
);
```

In the example above, the `.select` filter returns a Boolean value in its callback. One might think that our `Consumer` will be rebuilt every time the condition `state > 5` is met. However, this is not the case. By default the `.select` filter compares the value returned by the callback with a previously stored value. In other words, our consumer will be rebuilt if the returned value changes from `true` to `false` or from `false` to `true`.

If we want our `Consumer` to be rebuilt every time the condition `state > 5` is met, we should use the `booleanCallback` parameter of our filter to indicate that every time our filter returns a Boolean value, it should rebuild our `Consumer.

The next code rebuilds the `Consumer` only when the counter is highest than 5.

```dart {6}
Consumer(
  builder: (_, ref, __) {
    final counter = ref.watch(
            counterProvider.select(
              (state) => state > 5,
              booleanCallback: true,
            ),
          ).state;
    return Text("${counter}");
  },
);
```

:::note
Also we can use `ref.listen` with filters
```dart
class CounterView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {

    ref.listen(
      loginProvider.select(
        (state) => state.value,
      ),
      callback: (notifier) {
        // YOUR ACTION HERE
      },
    );
   
    return MY_WIDGET;
  }
}
```
:::

:::warning IMPORTANT
Never use `ref.watch`, `ref.select` or `ref.listen` inside conditionals

```dart {4-6}
Consumer(
  builder: (_, ref, __) {
    /// NEVER DO THIS
    if(someCondition){
      ref.listen(...);
      final counter = ref.watch(...);
    }

    
    return MY_WIDGET;
  },
);
```

:::
