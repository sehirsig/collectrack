import 'package:freezed_annotation/freezed_annotation.dart';

part 'object_model.freezed.dart';

@freezed
class ObjectModel with _$ObjectModel {
  const factory ObjectModel({
    required String articleName,
    required String description,
    required String image,
    required bool pic,
    required int condition,
    required double cost,
    required String material,
    required String country,
    required double weight,
    required DateTime obtained,
    required bool favourite,
    required int releaseYear,
    required int hiveCollectionId,
    required int hiveObjectId,
  }) = _ObjectModel;
}
