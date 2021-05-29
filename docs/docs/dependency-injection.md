---
sidebar_position: 9
---

# Dependency Injection

With the `Get` module you can easy inject your dependencies as a singleton, lazy singleton or as a factory.

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


// creates a new instance of AuthRepositoryImpl 
// every time that Get.i.find<AuthRepository>() is called
Get.i.factoryPut<AuthRepository>(()=>new AuthRepositoryImpl());
```


## Testing
To avoid conflics with dependencies injected in the Get module you can clear the dependencies using a `setUp` or a `tearDown`  before or after each test.

```dart
setUp((){
 Get.i.clear(); // remove all dependencies
});
```