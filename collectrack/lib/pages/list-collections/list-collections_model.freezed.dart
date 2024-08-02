// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'list-collections_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ListCollectionsModel {
  List<DbCollectionModel> get collections => throw _privateConstructorUsedError;
  String get filterText => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ListCollectionsModelCopyWith<ListCollectionsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListCollectionsModelCopyWith<$Res> {
  factory $ListCollectionsModelCopyWith(ListCollectionsModel value,
          $Res Function(ListCollectionsModel) then) =
      _$ListCollectionsModelCopyWithImpl<$Res>;
  $Res call({List<DbCollectionModel> collections, String filterText});
}

/// @nodoc
class _$ListCollectionsModelCopyWithImpl<$Res>
    implements $ListCollectionsModelCopyWith<$Res> {
  _$ListCollectionsModelCopyWithImpl(this._value, this._then);

  final ListCollectionsModel _value;
  // ignore: unused_field
  final $Res Function(ListCollectionsModel) _then;

  @override
  $Res call({
    Object? collections = freezed,
    Object? filterText = freezed,
  }) {
    return _then(_value.copyWith(
      collections: collections == freezed
          ? _value.collections
          : collections // ignore: cast_nullable_to_non_nullable
              as List<DbCollectionModel>,
      filterText: filterText == freezed
          ? _value.filterText
          : filterText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ListCollectionsModelCopyWith<$Res>
    implements $ListCollectionsModelCopyWith<$Res> {
  factory _$$_ListCollectionsModelCopyWith(_$_ListCollectionsModel value,
          $Res Function(_$_ListCollectionsModel) then) =
      __$$_ListCollectionsModelCopyWithImpl<$Res>;
  @override
  $Res call({List<DbCollectionModel> collections, String filterText});
}

/// @nodoc
class __$$_ListCollectionsModelCopyWithImpl<$Res>
    extends _$ListCollectionsModelCopyWithImpl<$Res>
    implements _$$_ListCollectionsModelCopyWith<$Res> {
  __$$_ListCollectionsModelCopyWithImpl(_$_ListCollectionsModel _value,
      $Res Function(_$_ListCollectionsModel) _then)
      : super(_value, (v) => _then(v as _$_ListCollectionsModel));

  @override
  _$_ListCollectionsModel get _value => super._value as _$_ListCollectionsModel;

  @override
  $Res call({
    Object? collections = freezed,
    Object? filterText = freezed,
  }) {
    return _then(_$_ListCollectionsModel(
      collections: collections == freezed
          ? _value._collections
          : collections // ignore: cast_nullable_to_non_nullable
              as List<DbCollectionModel>,
      filterText: filterText == freezed
          ? _value.filterText
          : filterText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ListCollectionsModel implements _ListCollectionsModel {
  const _$_ListCollectionsModel(
      {required final List<DbCollectionModel> collections,
      required this.filterText})
      : _collections = collections;

  final List<DbCollectionModel> _collections;
  @override
  List<DbCollectionModel> get collections {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_collections);
  }

  @override
  final String filterText;

  @override
  String toString() {
    return 'ListCollectionsModel(collections: $collections, filterText: $filterText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ListCollectionsModel &&
            const DeepCollectionEquality()
                .equals(other._collections, _collections) &&
            const DeepCollectionEquality()
                .equals(other.filterText, filterText));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_collections),
      const DeepCollectionEquality().hash(filterText));

  @JsonKey(ignore: true)
  @override
  _$$_ListCollectionsModelCopyWith<_$_ListCollectionsModel> get copyWith =>
      __$$_ListCollectionsModelCopyWithImpl<_$_ListCollectionsModel>(
          this, _$identity);
}

abstract class _ListCollectionsModel implements ListCollectionsModel {
  const factory _ListCollectionsModel(
      {required final List<DbCollectionModel> collections,
      required final String filterText}) = _$_ListCollectionsModel;

  @override
  List<DbCollectionModel> get collections => throw _privateConstructorUsedError;
  @override
  String get filterText => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ListCollectionsModelCopyWith<_$_ListCollectionsModel> get copyWith =>
      throw _privateConstructorUsedError;
}
