// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
    TResult? Function()? accessDenied,
    TResult? Function()? network,
    TResult? Function()? unknown,
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
    TResult? Function(LoginAccessDenied value)? accessDenied,
    TResult? Function(LoginNetworkError value)? network,
    TResult? Function(LoginUnknownError value)? unknown,
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
      _$LoginFailureCopyWithImpl<$Res, LoginFailure>;
}

/// @nodoc
class _$LoginFailureCopyWithImpl<$Res, $Val extends LoginFailure>
    implements $LoginFailureCopyWith<$Res> {
  _$LoginFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoginAccessDeniedCopyWith<$Res> {
  factory _$$LoginAccessDeniedCopyWith(
          _$LoginAccessDenied value, $Res Function(_$LoginAccessDenied) then) =
      __$$LoginAccessDeniedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginAccessDeniedCopyWithImpl<$Res>
    extends _$LoginFailureCopyWithImpl<$Res, _$LoginAccessDenied>
    implements _$$LoginAccessDeniedCopyWith<$Res> {
  __$$LoginAccessDeniedCopyWithImpl(
      _$LoginAccessDenied _value, $Res Function(_$LoginAccessDenied) _then)
      : super(_value, _then);
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
        (other.runtimeType == runtimeType && other is _$LoginAccessDenied);
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
    TResult? Function()? accessDenied,
    TResult? Function()? network,
    TResult? Function()? unknown,
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
    TResult? Function(LoginAccessDenied value)? accessDenied,
    TResult? Function(LoginNetworkError value)? network,
    TResult? Function(LoginUnknownError value)? unknown,
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
abstract class _$$LoginNetworkErrorCopyWith<$Res> {
  factory _$$LoginNetworkErrorCopyWith(
          _$LoginNetworkError value, $Res Function(_$LoginNetworkError) then) =
      __$$LoginNetworkErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginNetworkErrorCopyWithImpl<$Res>
    extends _$LoginFailureCopyWithImpl<$Res, _$LoginNetworkError>
    implements _$$LoginNetworkErrorCopyWith<$Res> {
  __$$LoginNetworkErrorCopyWithImpl(
      _$LoginNetworkError _value, $Res Function(_$LoginNetworkError) _then)
      : super(_value, _then);
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
        (other.runtimeType == runtimeType && other is _$LoginNetworkError);
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
    TResult? Function()? accessDenied,
    TResult? Function()? network,
    TResult? Function()? unknown,
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
    TResult? Function(LoginAccessDenied value)? accessDenied,
    TResult? Function(LoginNetworkError value)? network,
    TResult? Function(LoginUnknownError value)? unknown,
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
abstract class _$$LoginUnknownErrorCopyWith<$Res> {
  factory _$$LoginUnknownErrorCopyWith(
          _$LoginUnknownError value, $Res Function(_$LoginUnknownError) then) =
      __$$LoginUnknownErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginUnknownErrorCopyWithImpl<$Res>
    extends _$LoginFailureCopyWithImpl<$Res, _$LoginUnknownError>
    implements _$$LoginUnknownErrorCopyWith<$Res> {
  __$$LoginUnknownErrorCopyWithImpl(
      _$LoginUnknownError _value, $Res Function(_$LoginUnknownError) _then)
      : super(_value, _then);
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
        (other.runtimeType == runtimeType && other is _$LoginUnknownError);
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
    TResult? Function()? accessDenied,
    TResult? Function()? network,
    TResult? Function()? unknown,
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
    TResult? Function(LoginAccessDenied value)? accessDenied,
    TResult? Function(LoginNetworkError value)? network,
    TResult? Function(LoginUnknownError value)? unknown,
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
