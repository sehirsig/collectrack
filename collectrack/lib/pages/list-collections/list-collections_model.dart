import 'package:collectrack/ui-kit/hive/collection/dbcollection_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list-collections_model.freezed.dart';

@freezed
class ListCollectionsModel with _$ListCollectionsModel {
  const factory ListCollectionsModel({
    required List<DbCollectionModel> collections,
    required String filterText,
  }) = _ListCollectionsModel;
}
