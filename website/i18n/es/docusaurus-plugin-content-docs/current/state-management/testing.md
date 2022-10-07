---
sidebar_position: 8
---

# Testing

## Overriding providers
Considere el siguiente provider
```dart
final loginProvider = StateProvider<LoginController, LoginState>(
  (_) => LoginController(),
);
```

En sus tests si necesita sobreescribir el callback de su provider
para pasar datos mockeados a sus Notifier puede usar el método `overrideProvider`.
```dart
import 'package:mocktail/mocktail.dart';

final loginProvider = StateProvider<LoginController, LoginState>(
  (_) => LoginController(),
);

class MockLoginController extends Mock implements LoginController {}
```

Antes de sus test puede usar un `setUp` y sobreescribir el callback de su provider.
```dart
setUp((){
  loginProvider.overrideProvider(
    (_) => MockLoginController(),
  );
});
```

## Reseteando sus providers
Antes o despues de cada uno de sus tests necesitara reiniciar sus providers a sus valores
por defecto para esto utilice `ProviderScope.clear();`

```dart
setUp((){
  ProviderScope.clear();
});

or 


tearDown((){
  ProviderScope.clear();
});
```