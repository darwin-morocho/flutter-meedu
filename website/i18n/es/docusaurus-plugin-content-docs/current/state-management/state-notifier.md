---
sidebar_position: 4
---

# StateNotifier
Para manejo de estados mas complejos considere usar un `StateNotifier` en lugar de un
`SimpleNotifier`.

Un `StateNotifier` almacena un único estado inmutable.

Un estado inmutable es una instancia de una clase que sobreescribe el operador  `==` y el  `hashCode`. Para esto puede usar [equatable](https://pub.dev/packages/equatable) o [freezed](https://pub.dev/packages/freezed) para crear clases inmutables.

### Usando equatable
Agregue `equatable` como dependencia en su archivo `pubspec.yaml`

```yaml
equatable: latest_version
```

Ahora puede crear una clase inmutable para su estado como se muestra 
a continuación
```dart
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String email, password;
  LoginState({
    required this.email,
    required this.password,
  });

  static LoginState get initialState => LoginState(email: '', password: '');

  LoginState copyWith({
    String? email,
    String? password,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [email, password];
}
```

### Usando Freezed

Para trabajar con freezed necesita [build_runner](https://pub.dev/packages/build_runner) y [freezed_annotation](https://pub.dev/packages/freezed_annotation)

Luego en su `pubspec.yaml` (reemplace `latest_version` con la ultima versión estable de freezed)

```yaml
dependencies:
  flutter:
    sdk: flutter
  freezed_annotation: latest_version

dev_dependencies:
  flutter_test:
    sdk: flutter

  build_runner: latest_version
  freezed: latest_version
```

Si tiene algún problema al tratar  de instalar y configurar frezeed consulte 
la documentación oficial https://pub.dev/packages/freezed

El siguiente código muestra como generar  una clase inmutable con frezee en
donde freezed generará el método `copyWith` por nosotros.
```dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const LoginState({
    @Default('') String email,
    @Default('') String password,
  }) = _LoginState;

  static LoginState get initialState => LoginState();
}
```

Ahora ejecute el siguiente comando para genrar los archivos con extensión `.frezeed.dart`

```shell
flutter pub run build_runner build --delete-conflicting-outputs
```

Ahora puede usar la clase `LoginState` para trabajar con una clase que extiende de `StateNotifier`

```dart
import 'package:flutter_meedu/meedu.dart';

class LoginController extends StateNotifier<LoginState> {
  // you need pass an inital state using super
  LoginController():super(LoginState.initialState);

  void onEmailChanged(String email) {
    state = state.copyWith(email: email);
  }

  void onPasswordChanged(String password) {
    state = state.copyWith(password: password);
  }
}
```

:::info
Un StateNotifier automaticamente notifica cuando la propiedad `state`  ha cambiado.

Si solo desea codificar el `state` de su `StateNotifier` sin notificar a los oyentes (sin reconstruir sus widgets `Consumer` y sin escuchar los cambios en un `ProviderListener`)
puede usar el método `onlyUpdate`de su `StateNotifier`.

```dart {7}
class LoginController extends StateNotifier<LoginState> {
  // you need pass an inital state using super
  LoginController():super(LoginState.initialState);

  void onEmailChanged(String email) {
    // only update the state without rebuil of Consumers or
    // listening in your ProviderListener
    onlyUpdate(state.copyWith(email: email));
  }
  .
  .
  .

}
```

:::

Ahora debe crear un provider usando la clase `StateProvider` a demás de definir los
`Generic Types` indicando que clase es la que extiende de `StateNotifier` y la clase usada
para el estado.

Para escuchar los cambios en su `StateNotifier` utilice el widget `Consumer`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';


final loginProvider = StateProvider<LoginController, LoginState>(
  (_) => LoginController(),
);


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                onChanged: loginProvider.read.onEmailChanged,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
              TextField(
                onChanged: loginProvider.read.onPasswordChanged,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
              ),
              SizedBox(height: 30),
              Consumer(
                builder: (_, ref, __) {
                  final controller = ref.watch(loginProvider);
                  final state = controller.state;

                  final email = state.email;
                  final password = state.password;

                  final enabled = email.isNotEmpty && password.isNotEmpty;

                  return ElevatedButton(
                    onPressed: enabled
                        ? () {
                            // YOUR CODE HERE
                          }
                        : null,
                    child: Text("SEND"),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
```

También puede usar el filtro `.select` para reconstruir sus `Consumer` solo cuando es necesario.

Por ejemplo el siguiente código actualiza el Consumer solo cuando la propiedad `email` 
en nuestro `LoginState` ha cambiado.

Aquí usamos `ref.select` para acceder directamente al valor retornado por `loginProvider.select` pero si desea acceder al notifier vinculado a `loginProvider` utilice `ref.watch` con `loginProvider.select`

```dart {4}
Consumer(
  builder: (_, ref, __) {
    final email = ref.select(
      loginProvider.select((_)=>_.email),
    );
    return Text(email);
  },
)
```

:::note
También puede usar el filtro `.when` para comprobar el estado actual y el estado
anterior y determinar si el widget Consumer debe actualizarse.

```dart {4}
Consumer(
  builder: (_, ref, __) {
    final email = ref.watch(
      loginProvider.when((prev, current) => prev.email != current.email),
    ).state.email;
    return Text(email);
  },
)
```

:::

:::info
De la misma manera puede escuchar los cambios en su `StateNofier` suando el widget `ProviderListener` o mediante un `StreamSubscription`
:::

También la clase `StateNotifier` le permite escuchar cuando el estado va a cambiar o ya cambio.

```dart
class LoginController extends StateNotifier<LoginState> {
  // you need pass an inital state using super
  LoginController() : super(LoginState.initialState);

  void onEmailChanged(String email) {
    state = state.copyWith(email: email);
  }

  void onPasswordChanged(String password) {
    state = state.copyWith(password: password);
  }

  @override
  void onStateChanged(LoginState oldState, LoginState currentState) {
    // YOUR CODE HERE
  }

  @override
  bool onStateWillChange(LoginState oldState, LoginState newState) {
    // YOUR CODE HERE
    return true; // you need to return a boolean to decide if the update of the state is allowed
  }
}
```
