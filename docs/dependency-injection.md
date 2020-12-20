Just import the `Get` module


```dart
import 'package:meedu/get.dart';
```


Now you can inject your dependencies using `Get.instance` or `Get.i`

```dart
// inject the dependency as a singleton
Get.i.put<AuthRepository>(new AuthRepositoryImpl());

// get the dependency
Get.i.find<AuthRepository>();

// delete the dependency
Get.i.remove<AuthRepository>();

// use a lazy put to get a new instance every time that you call to MGet.i.lazyFind
Get.i.lazyPut<AuthRepository>(()=>new AuthRepositoryImpl());
Get.i.lazyFind<AuthRepository>();
Get.i.lazyRemove<AuthRepository>();
```

## Put vs LazyPut
Using `Get.i.put<...>(...)` for dependency injection will do that when you call `Get.i.find<...>(...)` you allways get the same instance.


Using `Get.i.lazyPut<...>(...)` for dependency injection will do that when you call `Get.i.lazyFind<...>(...)` you allways get a new instance.

In both `Get.i.put<...>(...)` and `Get.i.lazyPut<...>(...)` you can use the `tag` parameter to inject multiples instances of the same class but each one will be unique.