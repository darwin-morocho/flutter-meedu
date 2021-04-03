import 'dart:async';
import 'package:meta/meta.dart' show sealed;
import '../notifiers/base_notifier.dart';
import '../notifiers/simple_notifier.dart';
import '../notifiers/state_notifier.dart';
import '../instance_manager/instance_manager.dart';

part 'simple_provider.dart';
part 'state_provider.dart';

typedef _LazyCallback<T extends BaseNotifier> = T Function(ProviderReference ref);

const String meeduProviderTag = 'meedu-provider';

@sealed
abstract class BaseProvider<T extends BaseNotifier> {
  /// callback to create one Instance of [T] when it was need it
  _LazyCallback<T> _create;
  bool _initialized = false;
  final bool autoDispose;
  BaseProvider(this._create, {this.autoDispose = false});

  T get read;

  // Custom implementation of hash code optimized for reading providers.
  @override
  int get hashCode => _cachedHash;
  final int _cachedHash = _nextHashCode = (_nextHashCode + 1) % 0xffffff;
  static int _nextHashCode = 1;
}

class ProviderReference {
  T read<T extends BaseNotifier>(BaseProvider<T> provider) {
    return provider.read;
  }

  /// called when the provider is destroyed
  void onDispose(void Function() cb) {
    cb();
  }
}

mixin NotifyManager<T> {
  StreamController<T> streamController = StreamController();
  final _subscriptions = <Stream, List<StreamSubscription>>{};

  close() {
    _subscriptions.forEach((stream, subscriptions) {
      for (final subscription in subscriptions) {
        subscription.cancel();
      }
    });
    _subscriptions.clear();
  }
}
