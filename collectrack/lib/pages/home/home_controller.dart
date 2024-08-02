import 'dart:math';

import 'package:collectrack/common/local_persistence/local_persistence_service.dart';
import 'package:collectrack/pages/home/home_model.dart';
import 'package:collectrack/pages/home/home_view.dart';
import 'package:collectrack/ui-kit/hive/object/dbobject_model.dart';
import 'package:flutter/material.dart';

class HomeControllerImplementation extends HomeController {
  final LocalPersistenceService _localPersistenceService;
  HomeControllerImplementation(
      {required LocalPersistenceService localPersistenceService,
      HomeModel? model})
      : _localPersistenceService = localPersistenceService,
        super(
          model ??
              const HomeModel(
                  switchShowcase: false, objectName: "", objectImage: ""),
        );

  @override
  void switchShowcase() {
    if (state.switchShowcase) {
      getFavoriteObject();
      state = state.copyWith(switchShowcase: !state.switchShowcase);
    } else {
      getDailyObject();
      state = state.copyWith(switchShowcase: !state.switchShowcase);
    }
  }

  @override
  void navigate(BuildContext context, int value) {
    switch (value) {
      case 0:
        //Navigator.pushNamed(context, '/home');
        //Not needed, is already on this page.
        break;
      case 1:
        Navigator.pushNamed(context, '/list-collections');
        break;
      case 2:
        Navigator.pushNamed(context, '/settings');
        break;
    }
  }

  @override
  void getDailyObject() {
    List<DbObjectModel> allObjects = _localPersistenceService.getAllDbObjects();
    if (allObjects.isEmpty) {
      state = state.copyWith(
          objectName: "Sie haben noch kein Objekt.", objectImage: "");
      return;
    }
    Random rng = Random();
    int chosenObjectId = rng.nextInt(allObjects.length);
    DbObjectModel chosenObject = allObjects[chosenObjectId];
    state = state.copyWith(
        objectName: chosenObject.articlename, objectImage: chosenObject.image);
  }

  @override
  void getFavoriteObject() {
    List<DbObjectModel> allObjects =
        _localPersistenceService.getAllFavoriteDbObjects();
    if (allObjects.isEmpty) {
      state = state.copyWith(
          objectName: "Sie haben noch kein Favoriten Objekt.", objectImage: "");
      return;
    }
    Random rng = Random();
    int chosenObjectId = rng.nextInt(allObjects.length);
    DbObjectModel chosenObject = allObjects[chosenObjectId];
    state = state.copyWith(
        objectName: chosenObject.articlename, objectImage: chosenObject.image);
  }
}
