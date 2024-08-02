// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SettingsModel {
  bool get biggerFont => throw _privateConstructorUsedError;
  bool get dailyFavorite => throw _privateConstructorUsedError;
  int get language => throw _privateConstructorUsedError;
  int get theme => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettingsModelCopyWith<SettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsModelCopyWith<$Res> {
  factory $SettingsModelCopyWith(
          SettingsModel value, $Res Function(SettingsModel) then) =
      _$SettingsModelCopyWithImpl<$Res>;
  $Res call({bool biggerFont, bool dailyFavorite, int language, int theme});
}

/// @nodoc
class _$SettingsModelCopyWithImpl<$Res>
    implements $SettingsModelCopyWith<$Res> {
  _$SettingsModelCopyWithImpl(this._value, this._then);

  final SettingsModel _value;
  // ignore: unused_field
  final $Res Function(SettingsModel) _then;

  @override
  $Res call({
    Object? biggerFont = freezed,
    Object? dailyFavorite = freezed,
    Object? language = freezed,
    Object? theme = freezed,
  }) {
    return _then(_value.copyWith(
      biggerFont: biggerFont == freezed
          ? _value.biggerFont
          : biggerFont // ignore: cast_nullable_to_non_nullable
              as bool,
      dailyFavorite: dailyFavorite == freezed
          ? _value.dailyFavorite
          : dailyFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      language: language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as int,
      theme: theme == freezed
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_SettingsModelCopyWith<$Res>
    implements $SettingsModelCopyWith<$Res> {
  factory _$$_SettingsModelCopyWith(
          _$_SettingsModel value, $Res Function(_$_SettingsModel) then) =
      __$$_SettingsModelCopyWithImpl<$Res>;
  @override
  $Res call({bool biggerFont, bool dailyFavorite, int language, int theme});
}

/// @nodoc
class __$$_SettingsModelCopyWithImpl<$Res>
    extends _$SettingsModelCopyWithImpl<$Res>
    implements _$$_SettingsModelCopyWith<$Res> {
  __$$_SettingsModelCopyWithImpl(
      _$_SettingsModel _value, $Res Function(_$_SettingsModel) _then)
      : super(_value, (v) => _then(v as _$_SettingsModel));

  @override
  _$_SettingsModel get _value => super._value as _$_SettingsModel;

  @override
  $Res call({
    Object? biggerFont = freezed,
    Object? dailyFavorite = freezed,
    Object? language = freezed,
    Object? theme = freezed,
  }) {
    return _then(_$_SettingsModel(
      biggerFont: biggerFont == freezed
          ? _value.biggerFont
          : biggerFont // ignore: cast_nullable_to_non_nullable
              as bool,
      dailyFavorite: dailyFavorite == freezed
          ? _value.dailyFavorite
          : dailyFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      language: language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as int,
      theme: theme == freezed
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_SettingsModel implements _SettingsModel {
  const _$_SettingsModel(
      {required this.biggerFont,
      required this.dailyFavorite,
      required this.language,
      required this.theme});

  @override
  final bool biggerFont;
  @override
  final bool dailyFavorite;
  @override
  final int language;
  @override
  final int theme;

  @override
  String toString() {
    return 'SettingsModel(biggerFont: $biggerFont, dailyFavorite: $dailyFavorite, language: $language, theme: $theme)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SettingsModel &&
            const DeepCollectionEquality()
                .equals(other.biggerFont, biggerFont) &&
            const DeepCollectionEquality()
                .equals(other.dailyFavorite, dailyFavorite) &&
            const DeepCollectionEquality().equals(other.language, language) &&
            const DeepCollectionEquality().equals(other.theme, theme));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(biggerFont),
      const DeepCollectionEquality().hash(dailyFavorite),
      const DeepCollectionEquality().hash(language),
      const DeepCollectionEquality().hash(theme));

  @JsonKey(ignore: true)
  @override
  _$$_SettingsModelCopyWith<_$_SettingsModel> get copyWith =>
      __$$_SettingsModelCopyWithImpl<_$_SettingsModel>(this, _$identity);
}

abstract class _SettingsModel implements SettingsModel {
  const factory _SettingsModel(
      {required final bool biggerFont,
      required final bool dailyFavorite,
      required final int language,
      required final int theme}) = _$_SettingsModel;

  @override
  bool get biggerFont => throw _privateConstructorUsedError;
  @override
  bool get dailyFavorite => throw _privateConstructorUsedError;
  @override
  int get language => throw _privateConstructorUsedError;
  @override
  int get theme => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_SettingsModelCopyWith<_$_SettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}
