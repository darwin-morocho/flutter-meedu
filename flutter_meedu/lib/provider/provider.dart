part of 'base_provider.dart';

/// A provider that always returns the same Element each time the [read] getter is called
///
/// Auto dispose is not available for these providers
class Provider<E> extends BaseProvider<E, dynamic> {
  Provider(super.creator);

  static ProviderWithArguments<E, A> withArguments<E, A>(
    Creator<E, A> creator,
  ) {
    return ProviderWithArguments(
      creator,
    );
  }

  static ProviderFactory<E> factory<E>(
    Creator<E, dynamic> creator,
  ) {
    return ProviderFactory<E>(creator);
  }

  static ProviderFactoryWithArguments<E, A> factoryWithArguments<E, A>(
    Creator<E, A> creator,
  ) {
    return ProviderFactoryWithArguments(creator);
  }
}

/// A provider that always returns the same Element with an argument in its [Ref] each time the [read] getter is called
///
/// Auto dispose is not available for these providers
class ProviderWithArguments<E, A> extends BaseProvider<E, A> {
  ProviderWithArguments(super.creator);
}

/// A provider that allways returns a new Element each time the [read] getter is called
///
/// Auto dispose is not available for these providers
class ProviderFactory<E> extends BaseProvider<E, dynamic> {
  ProviderFactory(super.creator);

  @override
  E get read {
    return (_overriddenCreator ?? _creator)(Ref());
  }
}

/// A provider that allways returns a new Element with an argument in its [Ref] each time the [get] function is called
///
/// Auto dispose is not available for these providers
class ProviderFactoryWithArguments<E, A> extends BaseProvider<E, A> {
  ProviderFactoryWithArguments(super.creator);

  late A _arguments;

  E get(A arguments) {
    _arguments = arguments;
    return read;
  }

  @override
  @protected
  E get read {
    return (_overriddenCreator ?? _creator)(
      Ref().._setArguments(_arguments),
    );
  }
}
