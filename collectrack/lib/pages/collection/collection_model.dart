import 'package:collectrack/ui-kit/hive/object/dbobject_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection_model.freezed.dart';

@freezed
class CollectionModel with _$CollectionModel {
  const factory CollectionModel({
    required int hiveCollectionId,
    required String title,
    required String description,
    required String image,
    required bool condition,
    required bool material,
    required bool country,
    required bool weight,
    required bool year,
    required String filterText,
    required List<DbObjectModel> listDbObjects,
  }) = _CollectionModel;
}
