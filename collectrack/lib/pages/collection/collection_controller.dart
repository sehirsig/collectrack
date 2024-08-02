import 'package:collectrack/common/local_persistence/local_persistence_service.dart';
import 'package:collectrack/common/providers.dart';
import 'package:collectrack/pages/collection-filter/collection-filter_model.dart';
import 'package:collectrack/pages/collection/collection_model.dart';
import 'package:collectrack/pages/collection/collection_view.dart';
import 'package:collectrack/ui-kit/hive/collection/dbcollection_model.dart';
import 'package:collectrack/ui-kit/hive/object/dbobject_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CollectionControllerImplementation extends CollectionController {
  final LocalPersistenceService _localPersistenceService;

  CollectionControllerImplementation(
      {required LocalPersistenceService localPersistenceService,
      CollectionModel? model})
      : _localPersistenceService = localPersistenceService,
        super(
          model ??
              const CollectionModel(
                hiveCollectionId: 0,
                title: "Beispielsammlung",
                description: "Beispielbeschreibung",
                image: "",
                condition: false,
                material: false,
                country: false,
                weight: false,
                year: false,
                listDbObjects: [],
                filterText: "",
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
        Navigator.pushNamed(context, '/collection-filter');
        break;
      case 4:
        Navigator.pushNamed(context, '/object-create');
        break;
    }
  }

  @override
  List<DbObjectModel> getHiveObjects(
      int collectionId, WidgetRef ref, String textFilterString) {
    List<DbObjectModel> tempList =
        _localPersistenceService.getAllDbObjectsOfCollection(collectionId);

    final CollectionFilterModel filterModel =
        ref.watch(providers.collectionFilterControllerProvider);
    if (!filterModel.applied) {
      if (textFilterString != "") {
        List<DbObjectModel> filteredList = [];
        for (DbObjectModel object in tempList) {
          if (object.articlename
              .toLowerCase()
              .contains(textFilterString.toLowerCase())) {
            filteredList.add(object);
          }
        }
        switch (filterModel.sorting) {
          case 0:
            filteredList.sort((objectA, objectB) =>
                objectB.obtaineddate.compareTo(objectA.obtaineddate));
            break;
          case 1:
            filteredList.sort((objectA, objectB) =>
                objectA.obtaineddate.compareTo(objectB.obtaineddate));
            break;
          case 2:
            filteredList.sort(
                (objectA, objectB) => objectB.cost.compareTo(objectA.cost));
            break;
          case 3:
            filteredList.sort(
                (objectA, objectB) => objectA.cost.compareTo(objectB.cost));
            break;
        }
        return filteredList;
      }
      switch (filterModel.sorting) {
        case 0:
          tempList.sort((objectA, objectB) =>
              objectB.obtaineddate.compareTo(objectA.obtaineddate));
          break;
        case 1:
          tempList.sort((objectA, objectB) =>
              objectA.obtaineddate.compareTo(objectB.obtaineddate));
          break;
        case 2:
          tempList
              .sort((objectA, objectB) => objectB.cost.compareTo(objectA.cost));
          break;
        case 3:
          tempList
              .sort((objectA, objectB) => objectA.cost.compareTo(objectB.cost));
          break;
      }
      return tempList;
    } else {
      List<DbObjectModel> filteredList = [];
      for (DbObjectModel object in tempList) {
        if (textFilterString != "") {
          if (!object.articlename
              .toLowerCase()
              .contains(textFilterString.toLowerCase())) {
            continue;
          }
        }
        if (filterModel.onlyFavorites) {
          if (object.favourite) {
            filteredList.add(object);
            continue;
          }
        }
        if (filterModel.countryApplied) {
          if (object.country == filterModel.country) {
            filteredList.add(object);
            continue;
          }
        }
        if (filterModel.dateApplied) {
          if (object.obtaineddate.isBefore(filterModel.beforeDate)) {
            filteredList.add(object);
            continue;
          }
        }
        if (filterModel.materialApplied) {
          if (object.material == filterModel.material) {
            filteredList.add(object);
            continue;
          }
        }
        if (filterModel.valueApplied) {
          if (object.cost >= filterModel.value) {
            filteredList.add(object);
            continue;
          }
        }
        if (filterModel.weightApplied) {
          if (object.weight >= filterModel.weightMin &&
              object.weight <= filterModel.weightMax) {
            filteredList.add(object);
            continue;
          }
        }
        if (filterModel.yearApplied) {
          if (object.releaseyear == filterModel.year) {
            filteredList.add(object);
            continue;
          }
        }
        if (!filterModel.onlyFavorites &&
            !filterModel.countryApplied &&
            !filterModel.dateApplied &&
            !filterModel.materialApplied &&
            !filterModel.valueApplied &&
            !filterModel.weightApplied &&
            !filterModel.yearApplied) {
          filteredList.add(object);
        }
      }
      switch (filterModel.sorting) {
        case 0:
          filteredList.sort((objectA, objectB) =>
              objectB.obtaineddate.compareTo(objectA.obtaineddate));
          break;
        case 1:
          filteredList.sort((objectA, objectB) =>
              objectA.obtaineddate.compareTo(objectB.obtaineddate));
          break;
        case 2:
          filteredList
              .sort((objectA, objectB) => objectB.cost.compareTo(objectA.cost));
          break;
        case 3:
          filteredList
              .sort((objectA, objectB) => objectA.cost.compareTo(objectB.cost));
          break;
      }
      return filteredList;
    }
  }

  @override
  void reset() {
    state = state.copyWith(
      hiveCollectionId: 0,
      title: "Beispielobjekt",
      description: "Beispielbeschreibung",
      image: "",
      condition: false,
      material: false,
      country: false,
      weight: false,
      year: false,
      listDbObjects: [],
      filterText: "",
    );
  }

  @override
  void deleteAllObjects(int collectionId) {
    _localPersistenceService.deleteAllObjectsFromCollection(collectionId);
  }

  @override
  String computeCount(int collectionId) {
    return _localPersistenceService
        .getCountCollectionIdDbObjects(collectionId)
        .toString();
  }

  @override
  String computeValue(int collectionId) {
    double value = 0;
    for (DbObjectModel object
        in _localPersistenceService.getAllDbObjectsOfCollection(collectionId)) {
      value += object.cost;
    }
    return value.toString();
  }

  @override
  void updateHiveId(int collectionId) {
    state = state.copyWith(hiveCollectionId: collectionId);
  }

  @override
  void deleteCollection(int collectionId) {
    _localPersistenceService.deleteAllObjectsFromCollection(collectionId);
    _localPersistenceService.deleteCollection(collectionId);
  }

  @override
  void getCollection(int collectionId, WidgetRef ref) {
    DbCollectionModel? getCol =
        _localPersistenceService.getDbCollectionModel(collectionId);
    if (getCol != null) {
      state = state.copyWith(
          title: getCol.title,
          condition: getCol.condition,
          description: getCol.description,
          image: getCol.image,
          material: getCol.material,
          country: getCol.country,
          weight: getCol.weight,
          year: getCol.year,
          hiveCollectionId: getCol.id,
          listDbObjects: getHiveObjects(collectionId, ref, state.filterText));
    }
  }

  @override
  void switchFilterText(String filterText) {
    state = state.copyWith(filterText: filterText);
  }

  @override
  void shareOthers(BuildContext context) async {
    AppLocalizations _stringBib = AppLocalizations.of(context)!;
    String msg = _stringBib.collection_socialMSG(
        state.title, state.description, computeValue(state.hiveCollectionId));
    String image = state.image;
    if (image != "") {
      List<String> imagePaths = [];
      imagePaths.add(image);
      await Share.shareFiles(imagePaths, text: msg);
    } else {
      await Share.share(msg);
    }
  }

  @override
  void popDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
