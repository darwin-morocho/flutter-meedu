import '../notifiers/notifier.dart';
import 'base_provider.dart';

class NotifierProvider<N extends Notifier<S>, S> extends BaseProvider<N>
    implements ListeneableProvider<N> {
  NotifierProvider(
    super.creator, {
    super.autoDispose,
  });
}
