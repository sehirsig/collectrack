import 'package:collectrack/ui-kit/hive/collection/dbcollection_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection-create_model.freezed.dart';

@freezed
class CollectionCreateModel with _$CollectionCreateModel {
  const factory CollectionCreateModel({
    required List<DbCollectionModel> collections,
    required String articlename,
    required String description,
    required String image,
    required bool pic,
    required bool condition,
    required bool material,
    required bool country,
    required bool weight,
    required bool year,
  }) = _CollectionCreateModel;
}
