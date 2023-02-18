// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'one_datetime_textfield.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$OneDateTimeValueTearOff {
  const _$OneDateTimeValueTearOff();

  _OneDateTimeValue call({DateTime? dateTime, String? errorText, bool isEnable = true}) {
    return _OneDateTimeValue(
      dateTime: dateTime,
      errorText: errorText,
      isEnable: isEnable,
    );
  }
}

/// @nodoc
const $OneDateTimeValue = _$OneDateTimeValueTearOff();

/// @nodoc
mixin _$OneDateTimeValue {
  DateTime? get dateTime => throw _privateConstructorUsedError;
  String? get errorText => throw _privateConstructorUsedError;
  bool get isEnable => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OneDateTimeValueCopyWith<OneDateTimeValue> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OneDateTimeValueCopyWith<$Res> {
  factory $OneDateTimeValueCopyWith(OneDateTimeValue value, $Res Function(OneDateTimeValue) then) = _$OneDateTimeValueCopyWithImpl<$Res>;
  $Res call({DateTime? dateTime, String? errorText, bool isEnable});
}

/// @nodoc
class _$OneDateTimeValueCopyWithImpl<$Res> implements $OneDateTimeValueCopyWith<$Res> {
  _$OneDateTimeValueCopyWithImpl(this._value, this._then);

  final OneDateTimeValue _value;
  // ignore: unused_field
  final $Res Function(OneDateTimeValue) _then;

  @override
  $Res call({
    Object? dateTime = freezed,
    Object? errorText = freezed,
    Object? isEnable = freezed,
  }) {
    return _then(_value.copyWith(
      dateTime: dateTime == freezed
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      errorText: errorText == freezed
          ? _value.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String?,
      isEnable: isEnable == freezed
          ? _value.isEnable
          : isEnable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$OneDateTimeValueCopyWith<$Res> implements $OneDateTimeValueCopyWith<$Res> {
  factory _$OneDateTimeValueCopyWith(_OneDateTimeValue value, $Res Function(_OneDateTimeValue) then) = __$OneDateTimeValueCopyWithImpl<$Res>;
  @override
  $Res call({DateTime? dateTime, String? errorText, bool isEnable});
}

/// @nodoc
class __$OneDateTimeValueCopyWithImpl<$Res> extends _$OneDateTimeValueCopyWithImpl<$Res> implements _$OneDateTimeValueCopyWith<$Res> {
  __$OneDateTimeValueCopyWithImpl(_OneDateTimeValue _value, $Res Function(_OneDateTimeValue) _then) : super(_value, (v) => _then(v as _OneDateTimeValue));

  @override
  _OneDateTimeValue get _value => super._value as _OneDateTimeValue;

  @override
  $Res call({
    Object? dateTime = freezed,
    Object? errorText = freezed,
    Object? isEnable = freezed,
  }) {
    return _then(_OneDateTimeValue(
      dateTime: dateTime == freezed
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      errorText: errorText == freezed
          ? _value.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String?,
      isEnable: isEnable == freezed
          ? _value.isEnable
          : isEnable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_OneDateTimeValue extends _OneDateTimeValue {
  _$_OneDateTimeValue({this.dateTime, this.errorText, this.isEnable = true}) : super._();

  @override
  final DateTime? dateTime;
  @override
  final String? errorText;
  @JsonKey(defaultValue: true)
  @override
  final bool isEnable;

  @override
  String toString() {
    return 'OneDateTimeValue(dateTime: $dateTime, errorText: $errorText, isEnable: $isEnable)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OneDateTimeValue &&
            (identical(other.dateTime, dateTime) || other.dateTime == dateTime) &&
            (identical(other.errorText, errorText) || other.errorText == errorText) &&
            (identical(other.isEnable, isEnable) || other.isEnable == isEnable));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dateTime, errorText, isEnable);

  @JsonKey(ignore: true)
  @override
  _$OneDateTimeValueCopyWith<_OneDateTimeValue> get copyWith => __$OneDateTimeValueCopyWithImpl<_OneDateTimeValue>(this, _$identity);
}

abstract class _OneDateTimeValue extends OneDateTimeValue {
  factory _OneDateTimeValue({DateTime? dateTime, String? errorText, bool isEnable}) = _$_OneDateTimeValue;
  _OneDateTimeValue._() : super._();

  @override
  DateTime? get dateTime;
  @override
  String? get errorText;
  @override
  bool get isEnable;
  @override
  @JsonKey(ignore: true)
  _$OneDateTimeValueCopyWith<_OneDateTimeValue> get copyWith => throw _privateConstructorUsedError;
}
