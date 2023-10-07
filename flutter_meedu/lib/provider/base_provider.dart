
import 'package:meta/meta.dart';

import '../notifiers/base_notifier.dart';
import '../notifiers/state_notifier.dart';
part 'provider_reference.dart';

class BaseProvider<T> {
  BaseProvider(
    this.creator, {
    this.autoDispose = true,
  });

  final bool autoDispose;

  final T Function(ProviderReference ref) creator;
}

class StateNotifierProvider<N extends StateNotifier<S>, S>
    extends BaseProvider<N> {
  StateNotifierProvider(
    super.creator, {
    super.autoDispose,
  });
}
