// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'home_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeModel {
  bool get switchShowcase => throw _privateConstructorUsedError;
  String get objectName => throw _privateConstructorUsedError;
  String get objectImage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeModelCopyWith<HomeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeModelCopyWith<$Res> {
  factory $HomeModelCopyWith(HomeModel value, $Res Function(HomeModel) then) =
      _$HomeModelCopyWithImpl<$Res>;
  $Res call({bool switchShowcase, String objectName, String objectImage});
}

/// @nodoc
class _$HomeModelCopyWithImpl<$Res> implements $HomeModelCopyWith<$Res> {
  _$HomeModelCopyWithImpl(this._value, this._then);

  final HomeModel _value;
  // ignore: unused_field
  final $Res Function(HomeModel) _then;

  @override
  $Res call({
    Object? switchShowcase = freezed,
    Object? objectName = freezed,
    Object? objectImage = freezed,
  }) {
    return _then(_value.copyWith(
      switchShowcase: switchShowcase == freezed
          ? _value.switchShowcase
          : switchShowcase // ignore: cast_nullable_to_non_nullable
              as bool,
      objectName: objectName == freezed
          ? _value.objectName
          : objectName // ignore: cast_nullable_to_non_nullable
              as String,
      objectImage: objectImage == freezed
          ? _value.objectImage
          : objectImage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_HomeModelCopyWith<$Res> implements $HomeModelCopyWith<$Res> {
  factory _$$_HomeModelCopyWith(
          _$_HomeModel value, $Res Function(_$_HomeModel) then) =
      __$$_HomeModelCopyWithImpl<$Res>;
  @override
  $Res call({bool switchShowcase, String objectName, String objectImage});
}

/// @nodoc
class __$$_HomeModelCopyWithImpl<$Res> extends _$HomeModelCopyWithImpl<$Res>
    implements _$$_HomeModelCopyWith<$Res> {
  __$$_HomeModelCopyWithImpl(
      _$_HomeModel _value, $Res Function(_$_HomeModel) _then)
      : super(_value, (v) => _then(v as _$_HomeModel));

  @override
  _$_HomeModel get _value => super._value as _$_HomeModel;

  @override
  $Res call({
    Object? switchShowcase = freezed,
    Object? objectName = freezed,
    Object? objectImage = freezed,
  }) {
    return _then(_$_HomeModel(
      switchShowcase: switchShowcase == freezed
          ? _value.switchShowcase
          : switchShowcase // ignore: cast_nullable_to_non_nullable
              as bool,
      objectName: objectName == freezed
          ? _value.objectName
          : objectName // ignore: cast_nullable_to_non_nullable
              as String,
      objectImage: objectImage == freezed
          ? _value.objectImage
          : objectImage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_HomeModel implements _HomeModel {
  const _$_HomeModel(
      {required this.switchShowcase,
      required this.objectName,
      required this.objectImage});

  @override
  final bool switchShowcase;
  @override
  final String objectName;
  @override
  final String objectImage;

  @override
  String toString() {
    return 'HomeModel(switchShowcase: $switchShowcase, objectName: $objectName, objectImage: $objectImage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomeModel &&
            const DeepCollectionEquality()
                .equals(other.switchShowcase, switchShowcase) &&
            const DeepCollectionEquality()
                .equals(other.objectName, objectName) &&
            const DeepCollectionEquality()
                .equals(other.objectImage, objectImage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(switchShowcase),
      const DeepCollectionEquality().hash(objectName),
      const DeepCollectionEquality().hash(objectImage));

  @JsonKey(ignore: true)
  @override
  _$$_HomeModelCopyWith<_$_HomeModel> get copyWith =>
      __$$_HomeModelCopyWithImpl<_$_HomeModel>(this, _$identity);
}

abstract class _HomeModel implements HomeModel {
  const factory _HomeModel(
      {required final bool switchShowcase,
      required final String objectName,
      required final String objectImage}) = _$_HomeModel;

  @override
  bool get switchShowcase => throw _privateConstructorUsedError;
  @override
  String get objectName => throw _privateConstructorUsedError;
  @override
  String get objectImage => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_HomeModelCopyWith<_$_HomeModel> get copyWith =>
      throw _privateConstructorUsedError;
}
