import 'dart:convert';
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:collectrack/ui-kit/hive/collection/dbcollection_model.dart';
import 'package:collectrack/ui-kit/hive/object/dbobject_model.dart';
import 'package:collectrack/common/local_persistence/local_persistence_service.dart';

class LocalPersistenceServiceHive implements LocalPersistenceService {
  late final Box<DbCollectionModel> _collections;
  static const String collectionsBoxName = 'collections';

  late final Box<DbObjectModel> _objects;
  static const String objectsBoxName = 'objects';

  LocalPersistenceServiceHive();

  initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(DbCollectionModelAdapter());
    Hive.registerAdapter(DbObjectModelAdapter());
    _collections = await Hive.openBox(collectionsBoxName);
    _objects = await Hive.openBox(objectsBoxName);
  }

  @override
  void storeDbCollection({required DbCollectionModel collection}) {
    _collections.put(collection.id, collection);
  }

  @override
  void clearIdDbCollection(int id) {
    final Map<dynamic, DbCollectionModel> deliveriesMap = _collections.toMap();
    dynamic wantedKey;
    deliveriesMap.forEach((key, value) {
      if (value.id == id) {
        wantedKey = key;
      }
    });
    _collections.delete(wantedKey);
  }

  @override
  void clearAllDbCollection() {
    _collections.clear();
  }

  @override
  int getCountDbCollection() {
    return _collections.length;
  }

  @override
  List<DbCollectionModel> getAllDbCollections() => _collections.values.toList();

  @override
  void clearAllCollectionDbObjects(int collectionId) {
    final Map<dynamic, DbObjectModel> deliveriesMap = _objects.toMap();
    dynamic wantedKey;
    deliveriesMap.forEach((key, value) {
      if (value.collectionid == collectionId) {
        wantedKey = key;
        _objects.delete(wantedKey);
      }
    });
  }

  @override
  void deleteDbObject(int objectId) {
    final Map<dynamic, DbObjectModel> deliveriesMap = _objects.toMap();
    dynamic wantedKey;
    deliveriesMap.forEach((key, value) {
      if (value.id == objectId) {
        wantedKey = key;
      }
    });
    _objects.delete(wantedKey);
  }

  @override
  List<DbObjectModel> getAllDbObjects() {
    return _objects.values.toList();
  }

  @override
  int getCountCollectionIdDbObjects(int collectionId) {
    int counter = 0;
    final Map<dynamic, DbObjectModel> deliveriesMap = _objects.toMap();
    deliveriesMap.forEach((key, value) {
      if (value.collectionid == collectionId) {
        counter++;
      }
    });
    return counter;
  }

  @override
  int getCountDbObjects() {
    return _objects.values.length;
  }

  @override
  void storeDbObject({required DbObjectModel object}) {
    _objects.put(object.id, object);
  }

  @override
  void updateItemDbCollection(int collectionId, newValue) {
    final Map<dynamic, DbCollectionModel> deliveriesMap = _collections.toMap();
    dynamic wantedKey;
    deliveriesMap.forEach((key, value) {
      if (value.id == collectionId) {
        wantedKey = key;
      }
    });
    _collections.put(wantedKey, newValue);
  }

  @override
  void updateItemDbObject(int objectId, newValue) {
    final Map<dynamic, DbObjectModel> deliveriesMap = _objects.toMap();
    dynamic wantedKey;
    deliveriesMap.forEach((key, value) {
      if (value.id == objectId) {
        wantedKey = key;
      }
    });
    _objects.put(wantedKey, newValue);
  }

  @override
  DbCollectionModel? getDbCollectionModel(int collectionId) {
    final Map<dynamic, DbCollectionModel> deliveriesMap = _collections.toMap();
    dynamic wantedKey;
    deliveriesMap.forEach((key, value) {
      if (value.id == collectionId) {
        wantedKey = key;
      }
    });

    DbCollectionModel? dbCol = _collections.get(wantedKey);
    if (dbCol != null) {
      if (!File(dbCol.image).existsSync()) {
        dbCol.image == "";
        _collections.put(wantedKey, dbCol);
      }
    }
    return dbCol;
  }

  @override
  DbObjectModel? getDbObjectModel(int objectId) {
    final Map<dynamic, DbObjectModel> deliveriesMap = _objects.toMap();
    dynamic wantedKey;
    deliveriesMap.forEach((key, value) {
      if (value.id == objectId) {
        wantedKey = key;
      }
    });

    DbObjectModel? dbObj = _objects.get(wantedKey);
    if (dbObj != null) {
      if (!File(dbObj.image).existsSync()) {
        dbObj.image == "";
        _objects.put(wantedKey, dbObj);
      }
    }
    return dbObj;
  }

  @override
  List<DbObjectModel> getAllDbObjectsOfCollection(int collectionId) {
    List<DbObjectModel> list = [];
    final Map<dynamic, DbObjectModel> deliveriesMap = _objects.toMap();
    deliveriesMap.forEach((key, value) {
      if (value.collectionid == collectionId) {
        list.add(value);
      }
    });
    return list;
  }

  @override
  void deleteAllObjectsFromCollection(int collectionId) {
    final Map<dynamic, DbObjectModel> deliveriesMap = _objects.toMap();
    deliveriesMap.forEach((key, value) {
      if (value.collectionid == collectionId) {
        _objects.delete(value.id);
      }
    });
  }

  @override
  void deleteCollection(int collectionId) {
    final Map<dynamic, DbCollectionModel> deliveriesMap = _collections.toMap();
    dynamic wantedKey;
    deliveriesMap.forEach((key, value) {
      if (value.id == collectionId) {
        wantedKey = key;
      }
    });
    _collections.delete(wantedKey);
  }

  @override
  List<DbObjectModel> getAllFavoriteDbObjects() {
    List<DbObjectModel> list = [];
    final Map<dynamic, DbObjectModel> deliveriesMap = _objects.toMap();
    deliveriesMap.forEach((key, value) {
      if (value.favourite) {
        list.add(value);
      }
    });
    return list;
  }

  @override
  void loadDatabase(String pathCol, String pathObj) async {
    File backupFileCol = File(pathCol);
    File backupFileObj = File(pathObj);

    List<dynamic> backupJsonCol =
        jsonDecode(await backupFileCol.readAsString());
    List<dynamic> backupJsonObj =
        jsonDecode(await backupFileObj.readAsString());

    await _collections.clear();
    for (DbCollectionModel cols in getAllDbCollections()) {
      await _collections.delete(cols.id);
    }
    await _objects.clear();
    for (DbObjectModel objs in getAllDbObjects()) {
      await _collections.delete(objs.id);
    }

    for (dynamic collection in backupJsonCol) {
      DbCollectionModel tempCol = DbCollectionModel(
          id: collection['id'] as int,
          title: collection['title'] as String,
          description: collection['description'] as String,
          image: collection['image'] as String,
          condition: collection['condition'] as bool,
          material: collection['material'] as bool,
          country: collection['country'] as bool,
          weight: collection['weight'] as bool,
          year: collection['year'] as bool);

      if (!File(tempCol.image).existsSync()) {
        tempCol = tempCol.copyWith(image: "");
      }
      await _collections.add(tempCol);
    }
    for (dynamic objects in backupJsonObj) {
      DbObjectModel tempObj = DbObjectModel(
          id: objects['id'] as int,
          collectionid: objects['collectionid'] as int,
          articlename: objects['articlename'] as String,
          description: objects['description'] as String,
          image: objects['image'] as String,
          condition: objects['condition'] as int,
          cost: objects['cost'] as double,
          material: objects['material'] as String,
          country: objects['country'] as String,
          weight: objects['weight'] as double,
          obtaineddate: DateTime.parse(objects['obtaineddate']),
          favourite: objects['favourite'] as bool,
          releaseyear: objects['releaseyear'] as int,
          picenabled: objects['picenabled'] as bool);

      if (!File(tempObj.image).existsSync()) {
        tempObj = tempObj.copyWith(image: "", picenabled: false);
      }
      await _objects.add(tempObj);
    }
  }

  @override
  Future<String> saveDatabase(String pathCol, String pathObj) async {
    File backupFileCol = File(pathCol);
    File backupFileObj = File(pathObj);

    String collectionJson = jsonEncode(_collections.values.toList());
    String objectJson = jsonEncode(_objects.values.toList());
    try {
      backupFileCol = await backupFileCol.writeAsString(collectionJson);
      backupFileObj = await backupFileObj.writeAsString(objectJson);
      return "";
    } catch (e) {
      return e.toString();
    }
  }
}
