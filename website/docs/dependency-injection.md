# Dependency Injection

With the `Get` module you can easy inject your dependencies as a singleton, lazy singleton or as a factory.

## Singletons

```dart
import 'package:flutter_meedu/meedu.dart';

// inject the dependency as a singleton
Get.i.put<AuthRepository>(new AuthRepositoryImpl());


// whenever part of your code you can get the dependency
Get.i.find<AuthRepository>();


// remove the dependency
Get.i.remove<AuthRepository>();


// use a lazy put to inject the dependency as a singleton
// but it only will be created until Get.i.find<AuthRepository>() is called
Get.i.lazyPut<AuthRepository>(()=>new AuthRepositoryImpl());
```

## Factory

If you want to get a new instance every time you call find in that case you could use `factoryPut`

```dart
class AuthRepository {
  final String apiHost;
  Person([this.apiHost = 'https://dev.api.com']);
}

// register a factory
Get.i.factoryPut<AuthRepository, void>((_) => AuthRepository());

// get a new instance of AuthRepository
final repository = Get.i.factoryFind<AuthRepository, void>();
```

:::success NOTE

If you want pass an initial value to **AuthRepository**

```dart
Get.i.factoryPut<AuthRepository, String>(
    (String? arguments) => AuthRepository(arguments ?? "https://dev.api.com"),
);

// get a new instance of AuthRepository with a initial value
final testRepo = Get.i.factoryFind<AuthRepository, String>(arguments:"https://test.api.com");
final liveRepo = Get.i.factoryFind<AuthRepository, String>(arguments:"https://live.api.com");
```

:::

## Testing

To avoid conflics with dependencies injected in the Get module you can clear the dependencies using a `setUp` or a `tearDown` before or after each test.

```dart
setUp((){
 Get.i.clear(); // remove all dependencies
});
```
