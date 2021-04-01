import '../../state.dart';
import 'base_provider.dart';

typedef _LazyCallback<T extends BaseController> = T Function();

class SimpleProvider<T extends BaseController> extends BaseProvider<T> {
  final List<String> ids;
  SimpleProvider(_LazyCallback<T> create, {this.ids = const []}) : super(create);
}
