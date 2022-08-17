// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'http.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RequestResultTearOff {
  const _$RequestResultTearOff();

  _Success<T> success<T>({required int statusCode, required T data}) {
    return _Success<T>(
      statusCode: statusCode,
      data: data,
    );
  }

  _Cancelled<T> cancelled<T>({required StackTrace stackTrace}) {
    return _Cancelled<T>(
      stackTrace: stackTrace,
    );
  }

  _NetworkError<T> networkError<T>({required StackTrace stackTrace}) {
    return _NetworkError<T>(
      stackTrace: stackTrace,
    );
  }

  _ResponseError<T> serverError<T>(
      {required int statusCode,
      dynamic data,
      String? message,
      required StackTrace stackTrace}) {
    return _ResponseError<T>(
      statusCode: statusCode,
      data: data,
      message: message,
      stackTrace: stackTrace,
    );
  }

  _UnhandledException<T> unhandledError<T>(
      {required Object exception, required StackTrace stackTrace}) {
    return _UnhandledException<T>(
      exception: exception,
      stackTrace: stackTrace,
    );
  }
}

/// @nodoc
const $RequestResult = _$RequestResultTearOff();

/// @nodoc
mixin _$RequestResult<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int statusCode, T data) success,
    required TResult Function(StackTrace stackTrace) cancelled,
    required TResult Function(StackTrace stackTrace) networkError,
    required TResult Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)
        serverError,
    required TResult Function(Object exception, StackTrace stackTrace)
        unhandledError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int statusCode, T data)? success,
    TResult Function(StackTrace stackTrace)? cancelled,
    TResult Function(StackTrace stackTrace)? networkError,
    TResult Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)?
        serverError,
    TResult Function(Object exception, StackTrace stackTrace)? unhandledError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int statusCode, T data)? success,
    TResult Function(StackTrace stackTrace)? cancelled,
    TResult Function(StackTrace stackTrace)? networkError,
    TResult Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)?
        serverError,
    TResult Function(Object exception, StackTrace stackTrace)? unhandledError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<T> value) success,
    required TResult Function(_Cancelled<T> value) cancelled,
    required TResult Function(_NetworkError<T> value) networkError,
    required TResult Function(_ResponseError<T> value) serverError,
    required TResult Function(_UnhandledException<T> value) unhandledError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Success<T> value)? success,
    TResult Function(_Cancelled<T> value)? cancelled,
    TResult Function(_NetworkError<T> value)? networkError,
    TResult Function(_ResponseError<T> value)? serverError,
    TResult Function(_UnhandledException<T> value)? unhandledError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success<T> value)? success,
    TResult Function(_Cancelled<T> value)? cancelled,
    TResult Function(_NetworkError<T> value)? networkError,
    TResult Function(_ResponseError<T> value)? serverError,
    TResult Function(_UnhandledException<T> value)? unhandledError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestResultCopyWith<T, $Res> {
  factory $RequestResultCopyWith(
          RequestResult<T> value, $Res Function(RequestResult<T>) then) =
      _$RequestResultCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$RequestResultCopyWithImpl<T, $Res>
    implements $RequestResultCopyWith<T, $Res> {
  _$RequestResultCopyWithImpl(this._value, this._then);

  final RequestResult<T> _value;
  // ignore: unused_field
  final $Res Function(RequestResult<T>) _then;
}

/// @nodoc
abstract class _$SuccessCopyWith<T, $Res> {
  factory _$SuccessCopyWith(
          _Success<T> value, $Res Function(_Success<T>) then) =
      __$SuccessCopyWithImpl<T, $Res>;
  $Res call({int statusCode, T data});
}

/// @nodoc
class __$SuccessCopyWithImpl<T, $Res>
    extends _$RequestResultCopyWithImpl<T, $Res>
    implements _$SuccessCopyWith<T, $Res> {
  __$SuccessCopyWithImpl(_Success<T> _value, $Res Function(_Success<T>) _then)
      : super(_value, (v) => _then(v as _Success<T>));

  @override
  _Success<T> get _value => super._value as _Success<T>;

  @override
  $Res call({
    Object? statusCode = freezed,
    Object? data = freezed,
  }) {
    return _then(_Success<T>(
      statusCode: statusCode == freezed
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_Success<T> implements _Success<T> {
  _$_Success({required this.statusCode, required this.data});

  @override
  final int statusCode;
  @override
  final T data;

  @override
  String toString() {
    return 'RequestResult<$T>.success(statusCode: $statusCode, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Success<T> &&
            const DeepCollectionEquality()
                .equals(other.statusCode, statusCode) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(statusCode),
      const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  _$SuccessCopyWith<T, _Success<T>> get copyWith =>
      __$SuccessCopyWithImpl<T, _Success<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int statusCode, T data) success,
    required TResult Function(StackTrace stackTrace) cancelled,
    required TResult Function(StackTrace stackTrace) networkError,
    required TResult Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)
        serverError,
    required TResult Function(Object exception, StackTrace stackTrace)
        unhandledError,
  }) {
    return success(statusCode, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int statusCode, T data)? success,
    TResult Function(StackTrace stackTrace)? cancelled,
    TResult Function(StackTrace stackTrace)? networkError,
    TResult Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)?
        serverError,
    TResult Function(Object exception, StackTrace stackTrace)? unhandledError,
  }) {
    return success?.call(statusCode, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int statusCode, T data)? success,
    TResult Function(StackTrace stackTrace)? cancelled,
    TResult Function(StackTrace stackTrace)? networkError,
    TResult Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)?
        serverError,
    TResult Function(Object exception, StackTrace stackTrace)? unhandledError,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(statusCode, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<T> value) success,
    required TResult Function(_Cancelled<T> value) cancelled,
    required TResult Function(_NetworkError<T> value) networkError,
    required TResult Function(_ResponseError<T> value) serverError,
    required TResult Function(_UnhandledException<T> value) unhandledError,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Success<T> value)? success,
    TResult Function(_Cancelled<T> value)? cancelled,
    TResult Function(_NetworkError<T> value)? networkError,
    TResult Function(_ResponseError<T> value)? serverError,
    TResult Function(_UnhandledException<T> value)? unhandledError,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success<T> value)? success,
    TResult Function(_Cancelled<T> value)? cancelled,
    TResult Function(_NetworkError<T> value)? networkError,
    TResult Function(_ResponseError<T> value)? serverError,
    TResult Function(_UnhandledException<T> value)? unhandledError,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success<T> implements RequestResult<T> {
  factory _Success({required int statusCode, required T data}) = _$_Success<T>;

  int get statusCode;
  T get data;
  @JsonKey(ignore: true)
  _$SuccessCopyWith<T, _Success<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$CancelledCopyWith<T, $Res> {
  factory _$CancelledCopyWith(
          _Cancelled<T> value, $Res Function(_Cancelled<T>) then) =
      __$CancelledCopyWithImpl<T, $Res>;
  $Res call({StackTrace stackTrace});
}

/// @nodoc
class __$CancelledCopyWithImpl<T, $Res>
    extends _$RequestResultCopyWithImpl<T, $Res>
    implements _$CancelledCopyWith<T, $Res> {
  __$CancelledCopyWithImpl(
      _Cancelled<T> _value, $Res Function(_Cancelled<T>) _then)
      : super(_value, (v) => _then(v as _Cancelled<T>));

  @override
  _Cancelled<T> get _value => super._value as _Cancelled<T>;

  @override
  $Res call({
    Object? stackTrace = freezed,
  }) {
    return _then(_Cancelled<T>(
      stackTrace: stackTrace == freezed
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
    ));
  }
}

/// @nodoc

class _$_Cancelled<T> implements _Cancelled<T> {
  _$_Cancelled({required this.stackTrace});

  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'RequestResult<$T>.cancelled(stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Cancelled<T> &&
            const DeepCollectionEquality()
                .equals(other.stackTrace, stackTrace));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(stackTrace));

  @JsonKey(ignore: true)
  @override
  _$CancelledCopyWith<T, _Cancelled<T>> get copyWith =>
      __$CancelledCopyWithImpl<T, _Cancelled<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int statusCode, T data) success,
    required TResult Function(StackTrace stackTrace) cancelled,
    required TResult Function(StackTrace stackTrace) networkError,
    required TResult Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)
        serverError,
    required TResult Function(Object exception, StackTrace stackTrace)
        unhandledError,
  }) {
    return cancelled(stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int statusCode, T data)? success,
    TResult Function(StackTrace stackTrace)? cancelled,
    TResult Function(StackTrace stackTrace)? networkError,
    TResult Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)?
        serverError,
    TResult Function(Object exception, StackTrace stackTrace)? unhandledError,
  }) {
    return cancelled?.call(stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int statusCode, T data)? success,
    TResult Function(StackTrace stackTrace)? cancelled,
    TResult Function(StackTrace stackTrace)? networkError,
    TResult Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)?
        serverError,
    TResult Function(Object exception, StackTrace stackTrace)? unhandledError,
    required TResult orElse(),
  }) {
    if (cancelled != null) {
      return cancelled(stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<T> value) success,
    required TResult Function(_Cancelled<T> value) cancelled,
    required TResult Function(_NetworkError<T> value) networkError,
    required TResult Function(_ResponseError<T> value) serverError,
    required TResult Function(_UnhandledException<T> value) unhandledError,
  }) {
    return cancelled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Success<T> value)? success,
    TResult Function(_Cancelled<T> value)? cancelled,
    TResult Function(_NetworkError<T> value)? networkError,
    TResult Function(_ResponseError<T> value)? serverError,
    TResult Function(_UnhandledException<T> value)? unhandledError,
  }) {
    return cancelled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success<T> value)? success,
    TResult Function(_Cancelled<T> value)? cancelled,
    TResult Function(_NetworkError<T> value)? networkError,
    TResult Function(_ResponseError<T> value)? serverError,
    TResult Function(_UnhandledException<T> value)? unhandledError,
    required TResult orElse(),
  }) {
    if (cancelled != null) {
      return cancelled(this);
    }
    return orElse();
  }
}

abstract class _Cancelled<T> implements RequestResult<T> {
  factory _Cancelled({required StackTrace stackTrace}) = _$_Cancelled<T>;

  StackTrace get stackTrace;
  @JsonKey(ignore: true)
  _$CancelledCopyWith<T, _Cancelled<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$NetworkErrorCopyWith<T, $Res> {
  factory _$NetworkErrorCopyWith(
          _NetworkError<T> value, $Res Function(_NetworkError<T>) then) =
      __$NetworkErrorCopyWithImpl<T, $Res>;
  $Res call({StackTrace stackTrace});
}

/// @nodoc
class __$NetworkErrorCopyWithImpl<T, $Res>
    extends _$RequestResultCopyWithImpl<T, $Res>
    implements _$NetworkErrorCopyWith<T, $Res> {
  __$NetworkErrorCopyWithImpl(
      _NetworkError<T> _value, $Res Function(_NetworkError<T>) _then)
      : super(_value, (v) => _then(v as _NetworkError<T>));

  @override
  _NetworkError<T> get _value => super._value as _NetworkError<T>;

  @override
  $Res call({
    Object? stackTrace = freezed,
  }) {
    return _then(_NetworkError<T>(
      stackTrace: stackTrace == freezed
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
    ));
  }
}

/// @nodoc

class _$_NetworkError<T> implements _NetworkError<T> {
  _$_NetworkError({required this.stackTrace});

  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'RequestResult<$T>.networkError(stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NetworkError<T> &&
            const DeepCollectionEquality()
                .equals(other.stackTrace, stackTrace));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(stackTrace));

  @JsonKey(ignore: true)
  @override
  _$NetworkErrorCopyWith<T, _NetworkError<T>> get copyWith =>
      __$NetworkErrorCopyWithImpl<T, _NetworkError<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int statusCode, T data) success,
    required TResult Function(StackTrace stackTrace) cancelled,
    required TResult Function(StackTrace stackTrace) networkError,
    required TResult Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)
        serverError,
    required TResult Function(Object exception, StackTrace stackTrace)
        unhandledError,
  }) {
    return networkError(stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int statusCode, T data)? success,
    TResult Function(StackTrace stackTrace)? cancelled,
    TResult Function(StackTrace stackTrace)? networkError,
    TResult Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)?
        serverError,
    TResult Function(Object exception, StackTrace stackTrace)? unhandledError,
  }) {
    return networkError?.call(stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int statusCode, T data)? success,
    TResult Function(StackTrace stackTrace)? cancelled,
    TResult Function(StackTrace stackTrace)? networkError,
    TResult Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)?
        serverError,
    TResult Function(Object exception, StackTrace stackTrace)? unhandledError,
    required TResult orElse(),
  }) {
    if (networkError != null) {
      return networkError(stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<T> value) success,
    required TResult Function(_Cancelled<T> value) cancelled,
    required TResult Function(_NetworkError<T> value) networkError,
    required TResult Function(_ResponseError<T> value) serverError,
    required TResult Function(_UnhandledException<T> value) unhandledError,
  }) {
    return networkError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Success<T> value)? success,
    TResult Function(_Cancelled<T> value)? cancelled,
    TResult Function(_NetworkError<T> value)? networkError,
    TResult Function(_ResponseError<T> value)? serverError,
    TResult Function(_UnhandledException<T> value)? unhandledError,
  }) {
    return networkError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success<T> value)? success,
    TResult Function(_Cancelled<T> value)? cancelled,
    TResult Function(_NetworkError<T> value)? networkError,
    TResult Function(_ResponseError<T> value)? serverError,
    TResult Function(_UnhandledException<T> value)? unhandledError,
    required TResult orElse(),
  }) {
    if (networkError != null) {
      return networkError(this);
    }
    return orElse();
  }
}

abstract class _NetworkError<T> implements RequestResult<T> {
  factory _NetworkError({required StackTrace stackTrace}) = _$_NetworkError<T>;

  StackTrace get stackTrace;
  @JsonKey(ignore: true)
  _$NetworkErrorCopyWith<T, _NetworkError<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ResponseErrorCopyWith<T, $Res> {
  factory _$ResponseErrorCopyWith(
          _ResponseError<T> value, $Res Function(_ResponseError<T>) then) =
      __$ResponseErrorCopyWithImpl<T, $Res>;
  $Res call(
      {int statusCode, dynamic data, String? message, StackTrace stackTrace});
}

/// @nodoc
class __$ResponseErrorCopyWithImpl<T, $Res>
    extends _$RequestResultCopyWithImpl<T, $Res>
    implements _$ResponseErrorCopyWith<T, $Res> {
  __$ResponseErrorCopyWithImpl(
      _ResponseError<T> _value, $Res Function(_ResponseError<T>) _then)
      : super(_value, (v) => _then(v as _ResponseError<T>));

  @override
  _ResponseError<T> get _value => super._value as _ResponseError<T>;

  @override
  $Res call({
    Object? statusCode = freezed,
    Object? data = freezed,
    Object? message = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_ResponseError<T>(
      statusCode: statusCode == freezed
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      stackTrace: stackTrace == freezed
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
    ));
  }
}

/// @nodoc

class _$_ResponseError<T> implements _ResponseError<T> {
  _$_ResponseError(
      {required this.statusCode,
      this.data,
      this.message,
      required this.stackTrace});

  @override
  final int statusCode;
  @override
  final dynamic data;
  @override
  final String? message;
  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'RequestResult<$T>.serverError(statusCode: $statusCode, data: $data, message: $message, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ResponseError<T> &&
            const DeepCollectionEquality()
                .equals(other.statusCode, statusCode) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality()
                .equals(other.stackTrace, stackTrace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(statusCode),
      const DeepCollectionEquality().hash(data),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(stackTrace));

  @JsonKey(ignore: true)
  @override
  _$ResponseErrorCopyWith<T, _ResponseError<T>> get copyWith =>
      __$ResponseErrorCopyWithImpl<T, _ResponseError<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int statusCode, T data) success,
    required TResult Function(StackTrace stackTrace) cancelled,
    required TResult Function(StackTrace stackTrace) networkError,
    required TResult Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)
        serverError,
    required TResult Function(Object exception, StackTrace stackTrace)
        unhandledError,
  }) {
    return serverError(statusCode, data, message, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int statusCode, T data)? success,
    TResult Function(StackTrace stackTrace)? cancelled,
    TResult Function(StackTrace stackTrace)? networkError,
    TResult Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)?
        serverError,
    TResult Function(Object exception, StackTrace stackTrace)? unhandledError,
  }) {
    return serverError?.call(statusCode, data, message, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int statusCode, T data)? success,
    TResult Function(StackTrace stackTrace)? cancelled,
    TResult Function(StackTrace stackTrace)? networkError,
    TResult Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)?
        serverError,
    TResult Function(Object exception, StackTrace stackTrace)? unhandledError,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(statusCode, data, message, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<T> value) success,
    required TResult Function(_Cancelled<T> value) cancelled,
    required TResult Function(_NetworkError<T> value) networkError,
    required TResult Function(_ResponseError<T> value) serverError,
    required TResult Function(_UnhandledException<T> value) unhandledError,
  }) {
    return serverError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Success<T> value)? success,
    TResult Function(_Cancelled<T> value)? cancelled,
    TResult Function(_NetworkError<T> value)? networkError,
    TResult Function(_ResponseError<T> value)? serverError,
    TResult Function(_UnhandledException<T> value)? unhandledError,
  }) {
    return serverError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success<T> value)? success,
    TResult Function(_Cancelled<T> value)? cancelled,
    TResult Function(_NetworkError<T> value)? networkError,
    TResult Function(_ResponseError<T> value)? serverError,
    TResult Function(_UnhandledException<T> value)? unhandledError,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(this);
    }
    return orElse();
  }
}

abstract class _ResponseError<T> implements RequestResult<T> {
  factory _ResponseError(
      {required int statusCode,
      dynamic data,
      String? message,
      required StackTrace stackTrace}) = _$_ResponseError<T>;

  int get statusCode;
  dynamic get data;
  String? get message;
  StackTrace get stackTrace;
  @JsonKey(ignore: true)
  _$ResponseErrorCopyWith<T, _ResponseError<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$UnhandledExceptionCopyWith<T, $Res> {
  factory _$UnhandledExceptionCopyWith(_UnhandledException<T> value,
          $Res Function(_UnhandledException<T>) then) =
      __$UnhandledExceptionCopyWithImpl<T, $Res>;
  $Res call({Object exception, StackTrace stackTrace});
}

/// @nodoc
class __$UnhandledExceptionCopyWithImpl<T, $Res>
    extends _$RequestResultCopyWithImpl<T, $Res>
    implements _$UnhandledExceptionCopyWith<T, $Res> {
  __$UnhandledExceptionCopyWithImpl(_UnhandledException<T> _value,
      $Res Function(_UnhandledException<T>) _then)
      : super(_value, (v) => _then(v as _UnhandledException<T>));

  @override
  _UnhandledException<T> get _value => super._value as _UnhandledException<T>;

  @override
  $Res call({
    Object? exception = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_UnhandledException<T>(
      exception: exception == freezed
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as Object,
      stackTrace: stackTrace == freezed
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
    ));
  }
}

/// @nodoc

class _$_UnhandledException<T> implements _UnhandledException<T> {
  _$_UnhandledException({required this.exception, required this.stackTrace});

  @override
  final Object exception;
  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'RequestResult<$T>.unhandledError(exception: $exception, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnhandledException<T> &&
            const DeepCollectionEquality().equals(other.exception, exception) &&
            const DeepCollectionEquality()
                .equals(other.stackTrace, stackTrace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(exception),
      const DeepCollectionEquality().hash(stackTrace));

  @JsonKey(ignore: true)
  @override
  _$UnhandledExceptionCopyWith<T, _UnhandledException<T>> get copyWith =>
      __$UnhandledExceptionCopyWithImpl<T, _UnhandledException<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int statusCode, T data) success,
    required TResult Function(StackTrace stackTrace) cancelled,
    required TResult Function(StackTrace stackTrace) networkError,
    required TResult Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)
        serverError,
    required TResult Function(Object exception, StackTrace stackTrace)
        unhandledError,
  }) {
    return unhandledError(exception, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int statusCode, T data)? success,
    TResult Function(StackTrace stackTrace)? cancelled,
    TResult Function(StackTrace stackTrace)? networkError,
    TResult Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)?
        serverError,
    TResult Function(Object exception, StackTrace stackTrace)? unhandledError,
  }) {
    return unhandledError?.call(exception, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int statusCode, T data)? success,
    TResult Function(StackTrace stackTrace)? cancelled,
    TResult Function(StackTrace stackTrace)? networkError,
    TResult Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)?
        serverError,
    TResult Function(Object exception, StackTrace stackTrace)? unhandledError,
    required TResult orElse(),
  }) {
    if (unhandledError != null) {
      return unhandledError(exception, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<T> value) success,
    required TResult Function(_Cancelled<T> value) cancelled,
    required TResult Function(_NetworkError<T> value) networkError,
    required TResult Function(_ResponseError<T> value) serverError,
    required TResult Function(_UnhandledException<T> value) unhandledError,
  }) {
    return unhandledError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Success<T> value)? success,
    TResult Function(_Cancelled<T> value)? cancelled,
    TResult Function(_NetworkError<T> value)? networkError,
    TResult Function(_ResponseError<T> value)? serverError,
    TResult Function(_UnhandledException<T> value)? unhandledError,
  }) {
    return unhandledError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success<T> value)? success,
    TResult Function(_Cancelled<T> value)? cancelled,
    TResult Function(_NetworkError<T> value)? networkError,
    TResult Function(_ResponseError<T> value)? serverError,
    TResult Function(_UnhandledException<T> value)? unhandledError,
    required TResult orElse(),
  }) {
    if (unhandledError != null) {
      return unhandledError(this);
    }
    return orElse();
  }
}

abstract class _UnhandledException<T> implements RequestResult<T> {
  factory _UnhandledException(
      {required Object exception,
      required StackTrace stackTrace}) = _$_UnhandledException<T>;

  Object get exception;
  StackTrace get stackTrace;
  @JsonKey(ignore: true)
  _$UnhandledExceptionCopyWith<T, _UnhandledException<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
