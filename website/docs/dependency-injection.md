# Dependency Injection

Consider the following class that defines the basic structure for a login using the repository pattern:

```dart
abstract class AuthRepository{
  Future<String?> login(String email, String password);
}
```

Now, we define a class that implements our repository:

```dart
class AuthRepositoryImpl implements AuthRepository{

  AuthRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<String?> login(String email, String password) async {
    final response = await _dio.post(
      ..
      .
      .
    );
    return someData;
  }
}
```

Next, we need to use our `AuthRepository` in a way that makes our code maintainable and testable. In this case, we can use the `Provider` class to create an instance of `AuthRepository`.

We define our repository as a global variable:

```dart
final authRepository = Provider(
  (_) => AuthRepositoryImpl(
    Dio(),
  ),
);

```

With this, we can now use our repository in our views or notifiers.

For example, let's imagine we have a `LoginNotifier` class that extends `StateNotifier` and needs our `AuthRepository` to perform the login action:

```dart {4}
final loginProvider = StateNotifierProvider<LoginNotifier,LoginState>(
  (_) => LoginNotifier(
    LoginState(),
    authRepository.read(),
  ),
);


class LoginNotifier extends StateNotifier<LoginState>{
  LoginNotifier(super.initialState, this._repository);
  final AuthRepository _repository;

  Future<String?> login() async {
      /// SOME CODE HERE
  }
}

```

Now, if we want to write the respective test, we'll notice that we need to mock the behavior of the Dio class. For this, we simply use the `overrideCreator` function:

```dart

setUp(
  (){
    authRepository.overrideCreator(
      (_) => AuthRepositoryImpl(
        DioMock(), // mocked data
      ),
    );
  },
);
```


:::note
Unlike the `StateNotifierProvider` and `StateNotifierArgumentsProvider` classes, the `auto-dispose` feature is not available for the `Provider` class and its variants such as `ArgumentsProvider`, `FactoryProvider`, and `FactoryArgumentsProvider`. You must manually release the resources of these classes using the `dispose` function.

For example, if we update the definition of our `authRepository` to execute code for resource cleanup, this would be the result:

```dart
final authRepository = Provider(
  (ref) {
    final repo =AuthRepositoryImpl(
      Dio(),
    );

    ref.onDispose(
      (){
          /// YOUR CODE HERE
      },
    );

    return repo;

  },
);

.
.
.

// to delete the element created by our authRepository we need to call to dispose
authRepository.dispose()
```
:::