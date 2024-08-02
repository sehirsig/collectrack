import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection-filter_model.freezed.dart';

@freezed
class CollectionFilterModel with _$CollectionFilterModel {
  const factory CollectionFilterModel({
    required int sorting,
    required double value,
    required int conditionMin,
    required int conditionMax,
    required String material,
    required String country,
    required double weightMin,
    required double weightMax,
    required int year,
    required bool onlyFavorites,
    required bool applied,
    required bool materialApplied,
    required bool countryApplied,
    required bool weightApplied,
    required bool yearApplied,
    required bool valueApplied,
    required bool dateApplied,
    required DateTime beforeDate,
  }) = _CollectionFilterModel;
}
