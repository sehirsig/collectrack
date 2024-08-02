import 'package:collectrack/common/local_persistence/local_persistence_service.dart';
import 'package:collectrack/pages/collection-edit/collection-edit_model.dart';
import 'package:collectrack/pages/collection-edit/collection-edit_view.dart';
import 'package:collectrack/ui-kit/hive/collection/dbcollection_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CollectionEditControllerImplementation extends CollectionEditController {
  final LocalPersistenceService _localPersistenceService;
  CollectionEditControllerImplementation(
      {required LocalPersistenceService localPersistenceService,
      CollectionEditModel? model})
      : _localPersistenceService = localPersistenceService,
        super(
          model ??
              const CollectionEditModel(
                collectionHiveId: 0,
                articlename: "CollectionName",
                description: "CollectionDescription",
                image: "",
                pic: false,
                condition: false,
                material: false,
                country: false,
                weight: false,
                year: false,
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
    }
  }

  @override
  void reset() {
    state = state.copyWith(
      collectionHiveId: 0,
      articlename: "CollectionName",
      description: "CollectionDescription",
      image: "",
      pic: false,
      condition: false,
      material: false,
      country: false,
      weight: false,
      year: false,
    );
  }

  @override
  void saveCollection(
    context,
    int collectionHiveId,
    String articlename,
    String description,
    String image,
    bool pic,
    bool condition,
    bool material,
    bool country,
    bool weight,
    bool year,
  ) {
    DbCollectionModel newCollectionModel = DbCollectionModel(
        id: collectionHiveId,
        title: articlename,
        description: description,
        image: image,
        condition: condition,
        material: material,
        country: country,
        weight: weight,
        year: year);
    _localPersistenceService.updateItemDbCollection(
        collectionHiveId, newCollectionModel);
    reset();
    navigate(context, 1);
  }

  @override
  void switchCondition() {
    state = state.copyWith(condition: !state.condition);
  }

  @override
  void switchCountry() {
    state = state.copyWith(country: !state.country);
  }

  @override
  void switchMaterial() {
    state = state.copyWith(material: !state.material);
  }

  @override
  void switchWeight() {
    state = state.copyWith(weight: !state.weight);
  }

  @override
  void switchYear() {
    state = state.copyWith(year: !state.year);
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
  void switchDescription(String description) {
    state = state.copyWith(description: description);
  }

  @override
  void switchName(String name) {
    state = state.copyWith(articlename: name);
  }

  @override
  void deleteCollection(int hiveCollectionId) {
    _localPersistenceService.deleteAllObjectsFromCollection(hiveCollectionId);
    _localPersistenceService.deleteCollection(hiveCollectionId);
  }

  @override
  void getHiveInfos(int hiveCollectionId) {
    DbCollectionModel? dbCollection =
        _localPersistenceService.getDbCollectionModel(hiveCollectionId);
    if (dbCollection == null) {
      return;
    }
    state = state.copyWith(
      collectionHiveId: hiveCollectionId,
      articlename: dbCollection.title,
      description: dbCollection.description,
      image: dbCollection.image,
      pic: (dbCollection.image != ""),
      condition: dbCollection.condition,
      material: dbCollection.material,
      country: dbCollection.country,
      weight: dbCollection.weight,
      year: dbCollection.year,
    );
  }

  @override
  void popDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
