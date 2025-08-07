// ignore_for_file: hash_and_equals

import 'package:meta/meta.dart';

import 'providers_container.dart';

/// base class for all Providers
///
///

interface class BaseTagProvider {}

abstract class BaseProvider<E, A> {
  BaseProvider(
    CreatorCallback<E, A> callback, {
    bool autoDispose = true,
  }) : _creator = Creator(
          callback,
          autoDispose,
        );

  /// defines how an [E] is created
  late final Creator<E, A> _creator;

  @protected
  Creator<E, A> get creator => _creator;

  /// elements saved inside the [ProvidersContainer]
  @protected
  Map<String, Element> get containerElements =>
      ProvidersContainer.instance.elements;

  /// For testing use this to override a provider behavior
  @protected
  @visibleForTesting
  void overrideCreator(
    CreatorCallback<E, A> callback, {
    bool? autoDispose,
  }) {
    // ignore: invalid_use_of_protected_member
    _creator.overrideCreator(
      callback,
      autoDispose: autoDispose,
    );

    ProvidersContainer.instance.overriddenCreators.putIfAbsent(
      _creator.hashCode,
      () => _creator,
    );
  }

  /// save arguments into the provider [Ref]
  void setArguments(
    A args, {
    String? tag,
  }) {
    final key = getKey(tag);
    final element = containerElements.putIfAbsent(
      key,
      () => Element<E>(
        ref: Ref<A>(tag: tag),
      ),
    );
    element.ref.setArguments(args);
  }

  /// check  if the current provider has a valid Element value into the
  ///[ProvidersContainer]
  bool mounted({
    String? tag,
  }) {
    return containerElements[getKey(tag)]?.valueAssigned ?? false;
  }

  /// return the [E] associated to the provider, if the [E] is not
  /// saved into the [ProvidersContainer] the Element will be created
  E read({
    String? tag,
  }) {
    final key = getKey(tag);
    final element = containerElements[key] as Element<E>?;
    if (element?.value != null) {
      return element!.value!;
    }

    final ref = element?.ref as Ref<A>? ?? Ref<A>(tag: tag);

    final createdElement = element ?? Element(ref: ref);

    if (createdElement.valueAssigned) {
      return createdElement.value as E;
    }

    createdElement.set(
      _creator.callback(ref),
    );

    containerElements[key] = createdElement;
    onElementValueAssigned(
      createdElement,
      _creator.autoDispose,
    );
    return createdElement.value as E;
  }

  @protected
  void onElementValueAssigned(Element<E> element, bool autoDispose);

  /// generate a key to be used into the [ProvidersContainer]
  @protected
  String getKey(String? tag) {
    return '$_cachedHash${tag ?? ''}';
  }

  @mustCallSuper
  Element<E>? dispose({String? tag}) {
    if (mounted(tag: tag)) {
      final key = getKey(tag);
      final element = containerElements[key]!;
      // ignore: invalid_use_of_protected_member
      element.ref.dispose();

      return containerElements.remove(key) as Element<E>;
    }
    return null;
  }

  // Custom implementation of hash code optimized for reading providers.
  @override // coverage:ignore-line
  int get hashCode => _cachedHash; // coverage:ignore-line
  final int _cachedHash = _nextHashCode = (_nextHashCode + 1) % 0xffffff;
  static int _nextHashCode = 1;
}
