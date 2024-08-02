import 'package:collectrack/common/local_persistence/local_persistence_service.dart';
import 'package:collectrack/pages/object/object_model.dart';
import 'package:collectrack/pages/object/object_view.dart';
import 'package:collectrack/ui-kit/hive/object/dbobject_model.dart';
import 'package:flutter/material.dart';

class ObjectControllerImplementation extends ObjectController {
  final LocalPersistenceService _localPersistenceService;

  ObjectControllerImplementation(
      {required LocalPersistenceService localPersistenceService,
      ObjectModel? model})
      : _localPersistenceService = localPersistenceService,
        super(
          model ??
              ObjectModel(
                articleName: "Beispielsname",
                description: "Beispielsbeschreibung",
                image: "",
                pic: false,
                condition: 5,
                material: "",
                country: "",
                weight: 0.0,
                obtained: DateTime.now(),
                favourite: false,
                releaseYear: 2022,
                cost: 0.0,
                hiveCollectionId: 0,
                hiveObjectId: 1,
              ),
        );

  @override
  void navigate(BuildContext context, int value) {
    switch (value) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/list-collections');
        break;
      case 2:
        Navigator.pushNamed(context, '/settings');
        break;
      case 3:
        Navigator.pushNamed(context, '/object-edit');
        break;
    }
  }

  @override
  void reset() {
    state = state.copyWith(
      articleName: "Beispielsname",
      description: "Beispielsbeschreibung",
      image: "",
      pic: false,
      condition: 5,
      material: "",
      country: "",
      weight: 0.0,
      obtained: DateTime.now(),
      favourite: false,
      releaseYear: 2022,
      cost: 0.0,
      hiveCollectionId: 0,
      hiveObjectId: 1,
    );
  }

  @override
  void deleteObject(int hiveObjId) {
    _localPersistenceService.deleteDbObject(hiveObjId);
    reset();
  }

  @override
  void switchFavourite(int hiveObjId) {
    try {
      DbObjectModel getDob =
          _localPersistenceService.getDbObjectModel(hiveObjId) as DbObjectModel;
      _localPersistenceService.updateItemDbObject(
          getDob.id, getDob.copyWith(favourite: !getDob.favourite));
      state = state.copyWith(
        favourite: !state.favourite,
        condition: getDob.condition,
        articleName: getDob.articlename,
        description: getDob.description,
        image: getDob.image,
        pic: true,
        material: getDob.material,
        country: getDob.country,
        weight: getDob.weight,
        obtained: getDob.obtaineddate,
        releaseYear: getDob.releaseyear,
        cost: getDob.cost,
        hiveCollectionId: getDob.collectionid,
        hiveObjectId: getDob.id,
      );
    } catch (_) {}
  }

  @override
  void getHiveObj(int hiveObjId) {
    try {
      DbObjectModel getDob =
          _localPersistenceService.getDbObjectModel(hiveObjId) as DbObjectModel;

      state = state.copyWith(
        favourite: getDob.favourite,
        condition: getDob.condition,
        articleName: getDob.articlename,
        description: getDob.description,
        image: getDob.image,
        pic: true,
        material: getDob.material,
        country: getDob.country,
        weight: getDob.weight,
        obtained: getDob.obtaineddate,
        releaseYear: getDob.releaseyear,
        cost: getDob.cost,
        hiveCollectionId: getDob.collectionid,
        hiveObjectId: getDob.id,
      );
    } catch (_) {}
  }
}
