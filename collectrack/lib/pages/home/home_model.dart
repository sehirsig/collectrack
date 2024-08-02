import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_model.freezed.dart';

@freezed
class HomeModel with _$HomeModel {
  const factory HomeModel({
    required bool switchShowcase,
    required String objectName,
    required String objectImage,
  }) = _HomeModel;
}
