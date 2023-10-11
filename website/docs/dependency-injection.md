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
final authRepository = Provider<AuthRepository>(
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
final authRepository = Provider<AuthRepository>(
  (ref) {
    final repo = AuthRepositoryImpl(
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

## Working with arguments

If you need to provide some values before the provider creates your data, you can use the `ArgumentsProvider` class.

```dart
final authRepository = ArgumentsProvider<AuthRepository, Dio>(
  (ref) => AuthRepositoryImpl(
    ref.arguments, //  ref.arguments is an instace of Dio
  ),
);


 //  OR


final authRepository = Provider.withArguments<AuthRepository, Dio>(
  (ref) => AuthRepositoryImpl(
    ref.arguments, //  ref.arguments is an instace of Dio
  ),
);
```

Now you can pass an instance of Dio as an argument using setArguments.

For example

```dart

void main(){
  initializeDependencies( Dio() );
  // SOME ADITIONAL CODE
}

void initializeDependencies({
  required Dio dio,
}){
  authRepository.setArguments(dio);
}

```

## FactoryProvider

If every time we retrieve the data from a provider, we need that data to always be a `new instance`, we should use the `FactoryProvider` class.

```dart
final authRepository = FactoryProvider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    Dio(),
  ),
);
```

Now, to retrieve the data of type `AuthRepository` from our global variable `authRepository`, we must use the `get` function.

```dart
authRepository.get();
```

:::note
One instance of `FactoryProvider` does not have a `dispose` function because every time we call get, we receive a new instance. In this case, the `get` function returns an instance of `FactoryElement`, and this class contains the `dispose` function.

Example:

```dart
final authRepository = FactoryProvider<AuthRepository>(
  (ref) {
    final repo = AuthRepositoryImpl(
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
// get the AuthRepository instance
final element = authRepository.get();
.
.
.
// dipose
element.dispose();
```

:::

## Factory with arguments

The `FactoryArgumentsProvider` works similarly to `FactoryProvider` but also allows us to pass arguments to be retrieved inside the creator callback.

```dart
final myRepo = FactoryArgumentsProvider<MyRepo, String>(
  (ref) => MyRepo(
      ref.arguments, // here ref.arguments is a Strung
  ),
);

// OR


final myRepo = FactoryProvider.withArguments<MyRepo, String>(
  (ref) => MyRepo(
      ref.arguments, // here ref.arguments is a Strung
  ),
);
```


## TIP
Instead of defining our repositories as global variables, we can define them as static data, achieving the same result but with much more readable code.

```dart
class Repositories{
  Repositories._(); // Use an internal constructor to restrict the creation of instances of Repositories 

  static final auth = Provider<AuthRepository>(
    (_) => AuthRepositoryImpl(
      Dio(),
    ),
  );
}

.
.
.
// Now we can use
Repositories.auth.read();

// or if we are using factories
Repositories.auth.get();
```