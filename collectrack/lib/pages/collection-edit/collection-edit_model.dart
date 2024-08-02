import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection-edit_model.freezed.dart';

@freezed
class CollectionEditModel with _$CollectionEditModel {
  const factory CollectionEditModel({
    required int collectionHiveId,
    required String articlename,
    required String description,
    required String image,
    required bool pic,
    required bool condition,
    required bool material,
    required bool country,
    required bool weight,
    required bool year,
  }) = _CollectionEditModel;
}
