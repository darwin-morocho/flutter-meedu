// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'http.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
    TResult? Function(int statusCode, T data)? success,
    TResult? Function(StackTrace stackTrace)? cancelled,
    TResult? Function(StackTrace stackTrace)? networkError,
    TResult? Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)?
        serverError,
    TResult? Function(Object exception, StackTrace stackTrace)? unhandledError,
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
    TResult? Function(_Success<T> value)? success,
    TResult? Function(_Cancelled<T> value)? cancelled,
    TResult? Function(_NetworkError<T> value)? networkError,
    TResult? Function(_ResponseError<T> value)? serverError,
    TResult? Function(_UnhandledException<T> value)? unhandledError,
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
      _$RequestResultCopyWithImpl<T, $Res, RequestResult<T>>;
}

/// @nodoc
class _$RequestResultCopyWithImpl<T, $Res, $Val extends RequestResult<T>>
    implements $RequestResultCopyWith<T, $Res> {
  _$RequestResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_SuccessCopyWith<T, $Res> {
  factory _$$_SuccessCopyWith(
          _$_Success<T> value, $Res Function(_$_Success<T>) then) =
      __$$_SuccessCopyWithImpl<T, $Res>;
  @useResult
  $Res call({int statusCode, T data});
}

/// @nodoc
class __$$_SuccessCopyWithImpl<T, $Res>
    extends _$RequestResultCopyWithImpl<T, $Res, _$_Success<T>>
    implements _$$_SuccessCopyWith<T, $Res> {
  __$$_SuccessCopyWithImpl(
      _$_Success<T> _value, $Res Function(_$_Success<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? data = freezed,
  }) {
    return _then(_$_Success<T>(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      data: freezed == data
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
            other is _$_Success<T> &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, statusCode, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SuccessCopyWith<T, _$_Success<T>> get copyWith =>
      __$$_SuccessCopyWithImpl<T, _$_Success<T>>(this, _$identity);

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
    TResult? Function(int statusCode, T data)? success,
    TResult? Function(StackTrace stackTrace)? cancelled,
    TResult? Function(StackTrace stackTrace)? networkError,
    TResult? Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)?
        serverError,
    TResult? Function(Object exception, StackTrace stackTrace)? unhandledError,
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
    TResult? Function(_Success<T> value)? success,
    TResult? Function(_Cancelled<T> value)? cancelled,
    TResult? Function(_NetworkError<T> value)? networkError,
    TResult? Function(_ResponseError<T> value)? serverError,
    TResult? Function(_UnhandledException<T> value)? unhandledError,
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
  factory _Success({required final int statusCode, required final T data}) =
      _$_Success<T>;

  int get statusCode;
  T get data;
  @JsonKey(ignore: true)
  _$$_SuccessCopyWith<T, _$_Success<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_CancelledCopyWith<T, $Res> {
  factory _$$_CancelledCopyWith(
          _$_Cancelled<T> value, $Res Function(_$_Cancelled<T>) then) =
      __$$_CancelledCopyWithImpl<T, $Res>;
  @useResult
  $Res call({StackTrace stackTrace});
}

/// @nodoc
class __$$_CancelledCopyWithImpl<T, $Res>
    extends _$RequestResultCopyWithImpl<T, $Res, _$_Cancelled<T>>
    implements _$$_CancelledCopyWith<T, $Res> {
  __$$_CancelledCopyWithImpl(
      _$_Cancelled<T> _value, $Res Function(_$_Cancelled<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
  }) {
    return _then(_$_Cancelled<T>(
      stackTrace: null == stackTrace
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
            other is _$_Cancelled<T> &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CancelledCopyWith<T, _$_Cancelled<T>> get copyWith =>
      __$$_CancelledCopyWithImpl<T, _$_Cancelled<T>>(this, _$identity);

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
    TResult? Function(int statusCode, T data)? success,
    TResult? Function(StackTrace stackTrace)? cancelled,
    TResult? Function(StackTrace stackTrace)? networkError,
    TResult? Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)?
        serverError,
    TResult? Function(Object exception, StackTrace stackTrace)? unhandledError,
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
    TResult? Function(_Success<T> value)? success,
    TResult? Function(_Cancelled<T> value)? cancelled,
    TResult? Function(_NetworkError<T> value)? networkError,
    TResult? Function(_ResponseError<T> value)? serverError,
    TResult? Function(_UnhandledException<T> value)? unhandledError,
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
  factory _Cancelled({required final StackTrace stackTrace}) = _$_Cancelled<T>;

  StackTrace get stackTrace;
  @JsonKey(ignore: true)
  _$$_CancelledCopyWith<T, _$_Cancelled<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_NetworkErrorCopyWith<T, $Res> {
  factory _$$_NetworkErrorCopyWith(
          _$_NetworkError<T> value, $Res Function(_$_NetworkError<T>) then) =
      __$$_NetworkErrorCopyWithImpl<T, $Res>;
  @useResult
  $Res call({StackTrace stackTrace});
}

/// @nodoc
class __$$_NetworkErrorCopyWithImpl<T, $Res>
    extends _$RequestResultCopyWithImpl<T, $Res, _$_NetworkError<T>>
    implements _$$_NetworkErrorCopyWith<T, $Res> {
  __$$_NetworkErrorCopyWithImpl(
      _$_NetworkError<T> _value, $Res Function(_$_NetworkError<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stackTrace = null,
  }) {
    return _then(_$_NetworkError<T>(
      stackTrace: null == stackTrace
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
            other is _$_NetworkError<T> &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stackTrace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NetworkErrorCopyWith<T, _$_NetworkError<T>> get copyWith =>
      __$$_NetworkErrorCopyWithImpl<T, _$_NetworkError<T>>(this, _$identity);

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
    TResult? Function(int statusCode, T data)? success,
    TResult? Function(StackTrace stackTrace)? cancelled,
    TResult? Function(StackTrace stackTrace)? networkError,
    TResult? Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)?
        serverError,
    TResult? Function(Object exception, StackTrace stackTrace)? unhandledError,
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
    TResult? Function(_Success<T> value)? success,
    TResult? Function(_Cancelled<T> value)? cancelled,
    TResult? Function(_NetworkError<T> value)? networkError,
    TResult? Function(_ResponseError<T> value)? serverError,
    TResult? Function(_UnhandledException<T> value)? unhandledError,
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
  factory _NetworkError({required final StackTrace stackTrace}) =
      _$_NetworkError<T>;

  StackTrace get stackTrace;
  @JsonKey(ignore: true)
  _$$_NetworkErrorCopyWith<T, _$_NetworkError<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ResponseErrorCopyWith<T, $Res> {
  factory _$$_ResponseErrorCopyWith(
          _$_ResponseError<T> value, $Res Function(_$_ResponseError<T>) then) =
      __$$_ResponseErrorCopyWithImpl<T, $Res>;
  @useResult
  $Res call(
      {int statusCode, dynamic data, String? message, StackTrace stackTrace});
}

/// @nodoc
class __$$_ResponseErrorCopyWithImpl<T, $Res>
    extends _$RequestResultCopyWithImpl<T, $Res, _$_ResponseError<T>>
    implements _$$_ResponseErrorCopyWith<T, $Res> {
  __$$_ResponseErrorCopyWithImpl(
      _$_ResponseError<T> _value, $Res Function(_$_ResponseError<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? data = freezed,
    Object? message = freezed,
    Object? stackTrace = null,
  }) {
    return _then(_$_ResponseError<T>(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      stackTrace: null == stackTrace
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
            other is _$_ResponseError<T> &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, statusCode,
      const DeepCollectionEquality().hash(data), message, stackTrace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ResponseErrorCopyWith<T, _$_ResponseError<T>> get copyWith =>
      __$$_ResponseErrorCopyWithImpl<T, _$_ResponseError<T>>(this, _$identity);

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
    TResult? Function(int statusCode, T data)? success,
    TResult? Function(StackTrace stackTrace)? cancelled,
    TResult? Function(StackTrace stackTrace)? networkError,
    TResult? Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)?
        serverError,
    TResult? Function(Object exception, StackTrace stackTrace)? unhandledError,
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
    TResult? Function(_Success<T> value)? success,
    TResult? Function(_Cancelled<T> value)? cancelled,
    TResult? Function(_NetworkError<T> value)? networkError,
    TResult? Function(_ResponseError<T> value)? serverError,
    TResult? Function(_UnhandledException<T> value)? unhandledError,
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
      {required final int statusCode,
      final dynamic data,
      final String? message,
      required final StackTrace stackTrace}) = _$_ResponseError<T>;

  int get statusCode;
  dynamic get data;
  String? get message;
  StackTrace get stackTrace;
  @JsonKey(ignore: true)
  _$$_ResponseErrorCopyWith<T, _$_ResponseError<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_UnhandledExceptionCopyWith<T, $Res> {
  factory _$$_UnhandledExceptionCopyWith(_$_UnhandledException<T> value,
          $Res Function(_$_UnhandledException<T>) then) =
      __$$_UnhandledExceptionCopyWithImpl<T, $Res>;
  @useResult
  $Res call({Object exception, StackTrace stackTrace});
}

/// @nodoc
class __$$_UnhandledExceptionCopyWithImpl<T, $Res>
    extends _$RequestResultCopyWithImpl<T, $Res, _$_UnhandledException<T>>
    implements _$$_UnhandledExceptionCopyWith<T, $Res> {
  __$$_UnhandledExceptionCopyWithImpl(_$_UnhandledException<T> _value,
      $Res Function(_$_UnhandledException<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exception = null,
    Object? stackTrace = null,
  }) {
    return _then(_$_UnhandledException<T>(
      exception: null == exception ? _value.exception : exception,
      stackTrace: null == stackTrace
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
            other is _$_UnhandledException<T> &&
            const DeepCollectionEquality().equals(other.exception, exception) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(exception), stackTrace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UnhandledExceptionCopyWith<T, _$_UnhandledException<T>> get copyWith =>
      __$$_UnhandledExceptionCopyWithImpl<T, _$_UnhandledException<T>>(
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
    TResult? Function(int statusCode, T data)? success,
    TResult? Function(StackTrace stackTrace)? cancelled,
    TResult? Function(StackTrace stackTrace)? networkError,
    TResult? Function(int statusCode, dynamic data, String? message,
            StackTrace stackTrace)?
        serverError,
    TResult? Function(Object exception, StackTrace stackTrace)? unhandledError,
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
    TResult? Function(_Success<T> value)? success,
    TResult? Function(_Cancelled<T> value)? cancelled,
    TResult? Function(_NetworkError<T> value)? networkError,
    TResult? Function(_ResponseError<T> value)? serverError,
    TResult? Function(_UnhandledException<T> value)? unhandledError,
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
      {required final Object exception,
      required final StackTrace stackTrace}) = _$_UnhandledException<T>;

  Object get exception;
  StackTrace get stackTrace;
  @JsonKey(ignore: true)
  _$$_UnhandledExceptionCopyWith<T, _$_UnhandledException<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
