// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbcollection_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DbCollectionModelAdapter extends TypeAdapter<_$_DbCollectionModel> {
  @override
  final int typeId = 0;

  @override
  _$_DbCollectionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_DbCollectionModel(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      image: fields[3] as String,
      condition: fields[4] as bool,
      material: fields[5] as bool,
      country: fields[6] as bool,
      weight: fields[7] as bool,
      year: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, _$_DbCollectionModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.condition)
      ..writeByte(5)
      ..write(obj.material)
      ..writeByte(6)
      ..write(obj.country)
      ..writeByte(7)
      ..write(obj.weight)
      ..writeByte(8)
      ..write(obj.year);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DbCollectionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DbCollectionModel _$$_DbCollectionModelFromJson(Map<String, dynamic> json) =>
    _$_DbCollectionModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      condition: json['condition'] as bool,
      material: json['material'] as bool,
      country: json['country'] as bool,
      weight: json['weight'] as bool,
      year: json['year'] as bool,
    );

Map<String, dynamic> _$$_DbCollectionModelToJson(
        _$_DbCollectionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'condition': instance.condition,
      'material': instance.material,
      'country': instance.country,
      'weight': instance.weight,
      'year': instance.year,
    };
