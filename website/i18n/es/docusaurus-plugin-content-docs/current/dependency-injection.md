# Inyección de dependencias

Con el modulo `Get` puede facilmente injectar sus dependencias como un singleton, lazy singleton o un factory.

## Singletons

```dart
import 'package:flutter_meedu/meedu.dart';

// inyecta la dependencia como un singleton
// pero esta es creada y almacenada en memoria inmediatamente
Get.put<AuthRepository>(AuthRepositoryImpl());

// inyecta la dependencia como un singleton pero solo sera creada
// en el momento de la llamada a Get.find<AuthRepository>()
Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl());

// En cualquier parte de su codigo puede recupar su dependencia
// usando
Get.find<AuthRepository>();
// o
final AuthRepository auth = Get.find();


// use este metodo para eliminar su dependencia
Get.remove<AuthRepository>();
```

## Auto remove
Primero asegurese de agregar el observer de flutter_meedu en su MaterialApp o en sus navigator. [Más info.](/docs/state-management/intro#how-it-works).

Ahora cuando llame a `Get.put` o `Get.lazyPut` puede usar el parámetro `autoRemove` y de esta manera cuando la ruta que creo su singleton sea eliminada del Stack su dependencia también será removido del modulo `Get`.
```dart
Get.lazyPut<AuthRepository>(
  () => AuthRepositoryImpl(),
  autoRemove: true,
);
```

## Escuchando cuando un singleton es removido
Puede usar el parámetro `onRemove` para definir un callback que sera llamado cuando su singleton sea removido.

```dart
Get.lazyPut<AuthRepository>(
  () => AuthRepositoryImpl(),
  onRemove: (authRepository) {
      /// YOUR CODE HERE
    authRepository.dispose();
  }
);
```


## Factory
Si desea recuperar una nueva instancia en lugar de un singleton use el método `factoryPut`

```dart
class AuthRepository {
  final String apiHost;
  Person([this.apiHost = 'https://dev.api.com']);
}

// register a factory
Get.factoryPut<AuthRepository, void>((_) => AuthRepository());

// get a new instance of AuthRepository
final repository = Get.factoryFind<AuthRepository, void>();
```

:::success NOTE

Si queremos pasar un argumento a nuestro **AuthRepository**

```dart
Get.factoryPut<AuthRepository, String>(
    (String? arguments) => AuthRepository(arguments!),
);

// get a new instance of AuthRepository with a initial value
final testRepo = Get.factoryFind<AuthRepository, String>(
  arguments:"https://test.api.com",
);
final liveRepo = Get.factoryFind<AuthRepository, String>(
  arguments:"https://live.api.com",
);
```

:::

## Testing
Para evitar conflictos con las dependencias inyectadas use el método `clear` en un `setUp` o un `tearDown` antes o despues de cada test.

```dart
setUp((){
 Get.i.clear(); // remove all dependencies
});
```
