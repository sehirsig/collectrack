import 'package:collectrack/pages/collection-filter/collection-filter_model.dart';
import 'package:collectrack/pages/collection-filter/collection-filter_view.dart';
import 'package:collectrack/ui-kit/hive/collection/dbcollection_model.dart';
import 'package:collectrack/pages/collection/collection_model.dart';
import 'package:collectrack/ui-kit/hive/object/dbobject_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:collectrack/common/local_persistence/local_persistence_service.dart';

class CollectionFilterControllerImplementation
    extends CollectionFilterController {
  final LocalPersistenceService _localPersistenceService;

  CollectionFilterControllerImplementation(
      {required LocalPersistenceService localPersistenceService,
      CollectionFilterModel? model})
      : _localPersistenceService = localPersistenceService,
        super(model ??
            CollectionFilterModel(
              sorting: 1,
              value: 0,
              conditionMin: 2,
              conditionMax: 5,
              material: "",
              country: "",
              weightMin: 0.00,
              weightMax: 100.00,
              year: 2022,
              onlyFavorites: false,
              applied: false,
              materialApplied: false,
              countryApplied: false,
              weightApplied: false,
              yearApplied: false,
              valueApplied: false,
              dateApplied: false,
              beforeDate: DateTime.now(),
            ));

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
    }
  }

  @override
  DbCollectionModel getCollectionData(BuildContext context,
      CollectionModel collectionModel, String newCollectionTitle) {
    AppLocalizations _stringBib = AppLocalizations.of(context)!;
    int id = 1;
    while (_localPersistenceService.getDbCollectionModel(id) != null) {
      id++;
    }
    String title;
    if (newCollectionTitle != "") {
      title = newCollectionTitle;
    } else {
      title = collectionModel.title + _stringBib.collectionFilter_TitleFiller;
    }
    String description = "Diese Sammlung wurde mit einem Filter, aus " +
        collectionModel.title +
        " erstellt.";
    String image = collectionModel.image;
    bool condition = collectionModel.condition;
    bool material = collectionModel.material;
    bool country = collectionModel.country;
    bool weight = collectionModel.weight;
    bool year = collectionModel.year;

    return DbCollectionModel(
        id: id,
        title: title,
        description: description,
        image: image,
        condition: condition,
        material: material,
        country: country,
        weight: weight,
        year: year);
  }

  @override
  int createCollection(context, DbCollectionModel collectionModel) {
    _localPersistenceService.storeDbCollection(collection: collectionModel);
    return collectionModel.id;
  }

  @override
  List<DbObjectModel> getFilteredObjects(collectionId) {
    List<DbObjectModel> filteredList = [];
    List<DbObjectModel> tempList =
        _localPersistenceService.getAllDbObjectsOfCollection(collectionId);

    for (DbObjectModel object in tempList) {
      if (state.onlyFavorites) {
        if (object.favourite) {
          filteredList.add(object);
          continue;
        }
      }
      if (state.countryApplied) {
        if (object.country == state.country) {
          filteredList.add(object);
          continue;
        }
      }
      if (state.dateApplied) {
        if (object.obtaineddate.isBefore(state.beforeDate)) {
          filteredList.add(object);
          continue;
        }
      }
      if (state.materialApplied) {
        if (object.material == state.material) {
          filteredList.add(object);
          continue;
        }
      }
      if (state.valueApplied) {
        if (object.cost >= state.value) {
          filteredList.add(object);
          continue;
        }
      }
      if (state.weightApplied) {
        if (object.weight >= state.weightMin &&
            object.weight <= state.weightMax) {
          filteredList.add(object);
          continue;
        }
      }
      if (state.yearApplied) {
        if (object.releaseyear == state.year) {
          filteredList.add(object);
          continue;
        }
      }
      if (!state.onlyFavorites &&
          !state.countryApplied &&
          !state.dateApplied &&
          !state.materialApplied &&
          !state.valueApplied &&
          !state.weightApplied &&
          !state.yearApplied) {
        filteredList.add(object);
      }
    }

    return filteredList;
  }

  @override
  void insertObjects(List<DbObjectModel> filteredObjects, int newId) {
    for (DbObjectModel object in filteredObjects) {
      int newId = 1;
      while (_localPersistenceService.getDbObjectModel(newId) != null) {
        newId++;
      }
      DbObjectModel newObjectModel = DbObjectModel(
          id: newId,
          collectionid: newId,
          articlename: object.articlename,
          description: object.description,
          image: object.image,
          condition: object.condition,
          cost: object.cost,
          material: object.material,
          country: object.country,
          weight: object.weight,
          obtaineddate: object.obtaineddate,
          favourite: object.favourite,
          releaseyear: object.releaseyear,
          picenabled: object.picenabled);

      _localPersistenceService.storeDbObject(object: newObjectModel);
    }
    return;
  }

  @override
  void switchCountry(String country) {
    state = state.copyWith(country: country);
  }

  @override
  void switchMaterial(String material) {
    state = state.copyWith(material: material);
  }

  @override
  void switchSorting(int sort) {
    state = state.copyWith(sorting: sort);
  }

  @override
  void switchValue(double value) {
    state = state.copyWith(value: value);
  }

  @override
  void switchWeight(double min, double max) {
    state = state.copyWith(weightMin: min, weightMax: max);
  }

  @override
  void switchYear(int year) {
    state = state.copyWith(year: year);
  }

  @override
  void reset() {
    state = state.copyWith(
      sorting: 1,
      value: 0.00,
      conditionMin: 2,
      conditionMax: 5,
      material: "",
      country: "",
      weightMin: 0.00,
      weightMax: 100.00,
      year: 2022,
      onlyFavorites: false,
      applied: false,
      materialApplied: false,
      countryApplied: false,
      weightApplied: false,
      yearApplied: false,
      valueApplied: false,
      dateApplied: false,
      beforeDate: DateTime.now(),
    );
  }

  @override
  void switchApplied(bool applied) {
    state = state.copyWith(applied: applied);
  }

  @override
  void switchFavourite() {
    state = state.copyWith(onlyFavorites: !state.onlyFavorites);
  }

  @override
  void switchCondition(int min, int max) {
    state = state.copyWith(conditionMin: min, conditionMax: max);
  }

  @override
  void switchCountryApplied() {
    state = state.copyWith(countryApplied: !state.countryApplied);
  }

  @override
  void switchDateApplied() {
    state = state.copyWith(dateApplied: !state.dateApplied);
  }

  @override
  void switchMaterialApplied() {
    state = state.copyWith(materialApplied: !state.materialApplied);
  }

  @override
  void switchValueApplied() {
    state = state.copyWith(valueApplied: !state.valueApplied);
  }

  @override
  void switchWeightApplied() {
    state = state.copyWith(weightApplied: !state.weightApplied);
  }

  @override
  void switchYearApplied() {
    state = state.copyWith(yearApplied: !state.yearApplied);
  }

  @override
  void switchDate(DateTime dateTime) {
    state = state.copyWith(beforeDate: dateTime);
  }

  @override
  String getDropDownString(int value, BuildContext context) {
    AppLocalizations _stringBib = AppLocalizations.of(context)!;
    switch (value) {
      case 0:
        return _stringBib.collectionFilter_newFirst;
      case 1:
        return _stringBib.collectionFilter_oldFirst;
      case 2:
        return _stringBib.collectionFilter_expensiveFirst;
      case 3:
        return _stringBib.collectionFilter_cheapestFirst;
      default:
        return _stringBib.collectionFilter_newFirst;
    }
  }

  @override
  void popDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
