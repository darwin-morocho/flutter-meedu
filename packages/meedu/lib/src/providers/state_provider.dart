import '../../state.dart';
import 'base_provider.dart';

typedef _LazyCallback<T extends StateController> = T Function();

class StateProvider<T extends StateController<S>, S> extends BaseProvider<T> {
  late S _oldState;
  S get oldState => _oldState;
  final bool Function(S oldState, S newState)? buildWhen;
  StateProvider(_LazyCallback<T> create, {this.buildWhen}) : super(create);

  void setOldState(S newState) {
    _oldState = newState;
  }
}
