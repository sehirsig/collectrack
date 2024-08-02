import 'package:collectrack/common/local_persistence/local_persistence_service.dart';
import 'package:collectrack/pages/collection-create/collection-create_model.dart';
import 'package:collectrack/pages/collection-create/collection-create_view.dart';
import 'package:collectrack/ui-kit/hive/collection/dbcollection_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CollectionCreateControllerImplementation
    extends CollectionCreateController {
  final LocalPersistenceService _localPersistenceService;

  CollectionCreateControllerImplementation(
      {required LocalPersistenceService localPersistenceService,
      CollectionCreateModel? model})
      : _localPersistenceService = localPersistenceService,
        super(
          model ??
              const CollectionCreateModel(
                collections: [],
                articlename: "CollectionName",
                description: "CollectionDescription",
                image: "",
                pic: false,
                condition: true,
                material: true,
                country: true,
                weight: true,
                year: true,
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
      articlename: "CollectionName",
      description: "CollectionDescription",
      image: "",
      pic: false,
      condition: true,
      material: true,
      country: true,
      weight: true,
      year: true,
    );
  }

  @override
  void saveCollection(
    context,
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
    int newId = 1;
    while (_localPersistenceService.getDbCollectionModel(newId) != null) {
      newId++;
    }
    DbCollectionModel newCollectionModel = DbCollectionModel(
        id: newId,
        title: articlename,
        description: description,
        image: image,
        condition: condition,
        material: material,
        country: country,
        weight: weight,
        year: year);
    _localPersistenceService.storeDbCollection(collection: newCollectionModel);
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
  void popDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
