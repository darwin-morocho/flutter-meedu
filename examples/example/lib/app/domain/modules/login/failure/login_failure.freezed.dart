// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'login_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$LoginFailureTearOff {
  const _$LoginFailureTearOff();

  LoginAccessDenied accessDenied() {
    return const LoginAccessDenied();
  }

  LoginNetworkError network() {
    return const LoginNetworkError();
  }

  LoginUnknownError unknown() {
    return const LoginUnknownError();
  }
}

/// @nodoc
const $LoginFailure = _$LoginFailureTearOff();

/// @nodoc
mixin _$LoginFailure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() accessDenied,
    required TResult Function() network,
    required TResult Function() unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? accessDenied,
    TResult Function()? network,
    TResult Function()? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? accessDenied,
    TResult Function()? network,
    TResult Function()? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginAccessDenied value) accessDenied,
    required TResult Function(LoginNetworkError value) network,
    required TResult Function(LoginUnknownError value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LoginAccessDenied value)? accessDenied,
    TResult Function(LoginNetworkError value)? network,
    TResult Function(LoginUnknownError value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginAccessDenied value)? accessDenied,
    TResult Function(LoginNetworkError value)? network,
    TResult Function(LoginUnknownError value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginFailureCopyWith<$Res> {
  factory $LoginFailureCopyWith(
          LoginFailure value, $Res Function(LoginFailure) then) =
      _$LoginFailureCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoginFailureCopyWithImpl<$Res> implements $LoginFailureCopyWith<$Res> {
  _$LoginFailureCopyWithImpl(this._value, this._then);

  final LoginFailure _value;
  // ignore: unused_field
  final $Res Function(LoginFailure) _then;
}

/// @nodoc
abstract class $LoginAccessDeniedCopyWith<$Res> {
  factory $LoginAccessDeniedCopyWith(
          LoginAccessDenied value, $Res Function(LoginAccessDenied) then) =
      _$LoginAccessDeniedCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoginAccessDeniedCopyWithImpl<$Res>
    extends _$LoginFailureCopyWithImpl<$Res>
    implements $LoginAccessDeniedCopyWith<$Res> {
  _$LoginAccessDeniedCopyWithImpl(
      LoginAccessDenied _value, $Res Function(LoginAccessDenied) _then)
      : super(_value, (v) => _then(v as LoginAccessDenied));

  @override
  LoginAccessDenied get _value => super._value as LoginAccessDenied;
}

/// @nodoc

class _$LoginAccessDenied extends LoginAccessDenied {
  const _$LoginAccessDenied() : super._();

  @override
  String toString() {
    return 'LoginFailure.accessDenied()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoginAccessDenied);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() accessDenied,
    required TResult Function() network,
    required TResult Function() unknown,
  }) {
    return accessDenied();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? accessDenied,
    TResult Function()? network,
    TResult Function()? unknown,
  }) {
    return accessDenied?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? accessDenied,
    TResult Function()? network,
    TResult Function()? unknown,
    required TResult orElse(),
  }) {
    if (accessDenied != null) {
      return accessDenied();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginAccessDenied value) accessDenied,
    required TResult Function(LoginNetworkError value) network,
    required TResult Function(LoginUnknownError value) unknown,
  }) {
    return accessDenied(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LoginAccessDenied value)? accessDenied,
    TResult Function(LoginNetworkError value)? network,
    TResult Function(LoginUnknownError value)? unknown,
  }) {
    return accessDenied?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginAccessDenied value)? accessDenied,
    TResult Function(LoginNetworkError value)? network,
    TResult Function(LoginUnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (accessDenied != null) {
      return accessDenied(this);
    }
    return orElse();
  }
}

abstract class LoginAccessDenied extends LoginFailure {
  const factory LoginAccessDenied() = _$LoginAccessDenied;
  const LoginAccessDenied._() : super._();
}

/// @nodoc
abstract class $LoginNetworkErrorCopyWith<$Res> {
  factory $LoginNetworkErrorCopyWith(
          LoginNetworkError value, $Res Function(LoginNetworkError) then) =
      _$LoginNetworkErrorCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoginNetworkErrorCopyWithImpl<$Res>
    extends _$LoginFailureCopyWithImpl<$Res>
    implements $LoginNetworkErrorCopyWith<$Res> {
  _$LoginNetworkErrorCopyWithImpl(
      LoginNetworkError _value, $Res Function(LoginNetworkError) _then)
      : super(_value, (v) => _then(v as LoginNetworkError));

  @override
  LoginNetworkError get _value => super._value as LoginNetworkError;
}

/// @nodoc

class _$LoginNetworkError extends LoginNetworkError {
  const _$LoginNetworkError() : super._();

  @override
  String toString() {
    return 'LoginFailure.network()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoginNetworkError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() accessDenied,
    required TResult Function() network,
    required TResult Function() unknown,
  }) {
    return network();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? accessDenied,
    TResult Function()? network,
    TResult Function()? unknown,
  }) {
    return network?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? accessDenied,
    TResult Function()? network,
    TResult Function()? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginAccessDenied value) accessDenied,
    required TResult Function(LoginNetworkError value) network,
    required TResult Function(LoginUnknownError value) unknown,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LoginAccessDenied value)? accessDenied,
    TResult Function(LoginNetworkError value)? network,
    TResult Function(LoginUnknownError value)? unknown,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginAccessDenied value)? accessDenied,
    TResult Function(LoginNetworkError value)? network,
    TResult Function(LoginUnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class LoginNetworkError extends LoginFailure {
  const factory LoginNetworkError() = _$LoginNetworkError;
  const LoginNetworkError._() : super._();
}

/// @nodoc
abstract class $LoginUnknownErrorCopyWith<$Res> {
  factory $LoginUnknownErrorCopyWith(
          LoginUnknownError value, $Res Function(LoginUnknownError) then) =
      _$LoginUnknownErrorCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoginUnknownErrorCopyWithImpl<$Res>
    extends _$LoginFailureCopyWithImpl<$Res>
    implements $LoginUnknownErrorCopyWith<$Res> {
  _$LoginUnknownErrorCopyWithImpl(
      LoginUnknownError _value, $Res Function(LoginUnknownError) _then)
      : super(_value, (v) => _then(v as LoginUnknownError));

  @override
  LoginUnknownError get _value => super._value as LoginUnknownError;
}

/// @nodoc

class _$LoginUnknownError extends LoginUnknownError {
  const _$LoginUnknownError() : super._();

  @override
  String toString() {
    return 'LoginFailure.unknown()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoginUnknownError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() accessDenied,
    required TResult Function() network,
    required TResult Function() unknown,
  }) {
    return unknown();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? accessDenied,
    TResult Function()? network,
    TResult Function()? unknown,
  }) {
    return unknown?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? accessDenied,
    TResult Function()? network,
    TResult Function()? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginAccessDenied value) accessDenied,
    required TResult Function(LoginNetworkError value) network,
    required TResult Function(LoginUnknownError value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LoginAccessDenied value)? accessDenied,
    TResult Function(LoginNetworkError value)? network,
    TResult Function(LoginUnknownError value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginAccessDenied value)? accessDenied,
    TResult Function(LoginNetworkError value)? network,
    TResult Function(LoginUnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class LoginUnknownError extends LoginFailure {
  const factory LoginUnknownError() = _$LoginUnknownError;
  const LoginUnknownError._() : super._();
}
