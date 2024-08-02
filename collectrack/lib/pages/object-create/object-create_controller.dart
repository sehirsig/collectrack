import 'package:collectrack/common/local_persistence/local_persistence_service.dart';
import 'package:collectrack/pages/object-create/object-create_model.dart';
import 'package:collectrack/pages/object-create/object-create_view.dart';
import 'package:collectrack/ui-kit/hive/object/dbobject_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ObjectCreateControllerImplementation extends ObjectCreateController {
  final LocalPersistenceService _localPersistenceService;
  ObjectCreateControllerImplementation(
      {required LocalPersistenceService localPersistenceService,
      ObjectCreateModel? model})
      : _localPersistenceService = localPersistenceService,
        super(
          model ??
              ObjectCreateModel(
                collectionId: 0,
                articlename: "Beispielsname",
                description: "Beispielsbeschreibung",
                image: "",
                pic: false,
                condition: 5,
                material: "",
                country: "",
                weight: 0.0,
                obtained: DateTime.now(),
                favourite: false,
                releaseyear: 2022,
                cost: 0.0,
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
        Navigator.pop(context);
        Navigator.pushNamed(context, '/collection');
        break;
      case 4:
        Navigator.pushNamed(context, '/collection');
        break;
    }
  }

  @override
  void reset() {
    state = state.copyWith(
      articlename: "Beispielsname",
      description: "Beispielsbeschreibung",
      image: "",
      pic: false,
      condition: 5,
      material: "",
      country: "",
      weight: 0.0,
      obtained: DateTime.now(),
      favourite: false,
      releaseyear: 2022,
      cost: 0.0,
    );
  }

  @override
  void switchFavourite() {
    state = state.copyWith(favourite: !state.favourite);
  }

  @override
  Future<void> uploadPicture(ImageSource imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      state = state.copyWith(pic: true, image: pickedFile.path);
      return;
    }
  }

  @override
  void switchObtained(DateTime dateTime) {
    state = state.copyWith(obtained: dateTime);
  }

  @override
  void switchArticleName(String articleName) {
    state = state.copyWith(articlename: articleName);
  }

  @override
  void switchCondition(int condition) {
    state = state.copyWith(condition: condition);
  }

  @override
  void switchCost(double cost) {
    state = state.copyWith(cost: cost);
  }

  @override
  void switchCountry(String country) {
    state = state.copyWith(country: country);
  }

  @override
  void switchDescription(String description) {
    state = state.copyWith(description: description);
  }

  @override
  void switchImage(String image) {
    state = state.copyWith(image: image);
  }

  @override
  void switchMaterial(String material) {
    state = state.copyWith(material: material);
  }

  @override
  void switchPicOn() {
    state = state.copyWith(pic: true);
  }

  @override
  void switchReleaseYear(int releaseYear) {
    state = state.copyWith(releaseyear: releaseYear);
  }

  @override
  void switchWeight(double weight) {
    state = state.copyWith(weight: weight);
  }

  @override
  void saveObject(
      context,
      int collectionId,
      String articlename,
      String description,
      String image,
      int condition,
      double cost,
      String material,
      String country,
      double weight,
      DateTime obtaineddate,
      bool favourite,
      int releaseyear,
      bool picenabled) {
    int newId = 1;
    while (_localPersistenceService.getDbObjectModel(newId) != null) {
      newId++;
    }

    DbObjectModel newObjectModel = DbObjectModel(
      id: newId,
      collectionid: collectionId,
      articlename: articlename,
      description: description,
      image: image,
      condition: condition,
      cost: cost,
      material: material,
      country: country,
      weight: weight,
      obtaineddate: obtaineddate,
      favourite: favourite,
      releaseyear: releaseyear,
      picenabled: picenabled,
    );
    _localPersistenceService.storeDbObject(object: newObjectModel);
    reset();
  }

  @override
  void switchCollectionId(int collectionId) {
    state = state.copyWith(collectionId: collectionId);
  }

  @override
  void popDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
