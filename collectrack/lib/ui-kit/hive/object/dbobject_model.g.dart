// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbobject_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DbObjectModelAdapter extends TypeAdapter<_$_DbObjectModel> {
  @override
  final int typeId = 1;

  @override
  _$_DbObjectModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_DbObjectModel(
      id: fields[0] as int,
      collectionid: fields[1] as int,
      articlename: fields[2] as String,
      description: fields[3] as String,
      image: fields[4] as String,
      condition: fields[5] as int,
      cost: fields[6] as double,
      material: fields[7] as String,
      country: fields[8] as String,
      weight: fields[9] as double,
      obtaineddate: fields[10] as DateTime,
      favourite: fields[11] as bool,
      releaseyear: fields[12] as int,
      picenabled: fields[13] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, _$_DbObjectModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.collectionid)
      ..writeByte(2)
      ..write(obj.articlename)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.condition)
      ..writeByte(6)
      ..write(obj.cost)
      ..writeByte(7)
      ..write(obj.material)
      ..writeByte(8)
      ..write(obj.country)
      ..writeByte(9)
      ..write(obj.weight)
      ..writeByte(10)
      ..write(obj.obtaineddate)
      ..writeByte(11)
      ..write(obj.favourite)
      ..writeByte(12)
      ..write(obj.releaseyear)
      ..writeByte(13)
      ..write(obj.picenabled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DbObjectModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DbObjectModel _$$_DbObjectModelFromJson(Map<String, dynamic> json) =>
    _$_DbObjectModel(
      id: json['id'] as int,
      collectionid: json['collectionid'] as int,
      articlename: json['articlename'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      condition: json['condition'] as int,
      cost: (json['cost'] as num).toDouble(),
      material: json['material'] as String,
      country: json['country'] as String,
      weight: (json['weight'] as num).toDouble(),
      obtaineddate: DateTime.parse(json['obtaineddate'] as String),
      favourite: json['favourite'] as bool,
      releaseyear: json['releaseyear'] as int,
      picenabled: json['picenabled'] as bool,
    );

Map<String, dynamic> _$$_DbObjectModelToJson(_$_DbObjectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'collectionid': instance.collectionid,
      'articlename': instance.articlename,
      'description': instance.description,
      'image': instance.image,
      'condition': instance.condition,
      'cost': instance.cost,
      'material': instance.material,
      'country': instance.country,
      'weight': instance.weight,
      'obtaineddate': instance.obtaineddate.toIso8601String(),
      'favourite': instance.favourite,
      'releaseyear': instance.releaseyear,
      'picenabled': instance.picenabled,
    };
