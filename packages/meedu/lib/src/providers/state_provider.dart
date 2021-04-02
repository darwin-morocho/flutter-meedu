import '../../state.dart';
import 'base_provider.dart';

typedef _LazyCallback<T extends StateController> = T Function();

class StateProvider<T extends StateController<S>, S> extends BaseProvider<T> {
  late S _oldState;
  S get oldState => _oldState;

  StateProvider(_LazyCallback<T> create) : super(create);

  void setOldState(S newState) {
    _oldState = newState;
  }
}
