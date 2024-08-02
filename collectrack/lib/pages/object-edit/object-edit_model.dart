import 'package:freezed_annotation/freezed_annotation.dart';

part 'object-edit_model.freezed.dart';

@freezed
class ObjectEditModel with _$ObjectEditModel {
  const factory ObjectEditModel({
    required int objectId,
    required int collectionId,
    required String articlename,
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
    required int releaseyear,
  }) = _ObjectCreateModel;
}
