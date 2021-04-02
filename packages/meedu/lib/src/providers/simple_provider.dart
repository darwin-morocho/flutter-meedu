import '../../state.dart';
import 'base_provider.dart';

typedef _LazyCallback<T extends BaseController> = T Function();

class SimpleProvider<T extends BaseController> extends BaseProvider<T> {
  SimpleProvider(_LazyCallback<T> create) : super(create);
}
