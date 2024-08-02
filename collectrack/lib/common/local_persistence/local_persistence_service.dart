import 'package:collectrack/ui-kit/hive/collection/dbcollection_model.dart';
import 'package:collectrack/ui-kit/hive/object/dbobject_model.dart';

abstract class LocalPersistenceService {
  //BackUps
  Future<String> saveDatabase(String pathCol, String pathObj);
  void loadDatabase(String pathCol, String pathObj);

  //DBCollection
  void storeDbCollection({required DbCollectionModel collection});
  List<DbCollectionModel> getAllDbCollections();
  int getCountDbCollection();
  void clearIdDbCollection(int id);
  void clearAllDbCollection();
  void updateItemDbCollection(int collectionId, newValue);
  DbCollectionModel? getDbCollectionModel(int collectionId);
  void deleteCollection(int collectionId);
  void clearAllCollectionDbObjects(int collectionId);
  int getCountCollectionIdDbObjects(int collectionId);

  //DBObject
  void storeDbObject({required DbObjectModel object});
  List<DbObjectModel> getAllDbObjects();
  List<DbObjectModel> getAllDbObjectsOfCollection(int collectionId);
  int getCountDbObjects();
  DbObjectModel? getDbObjectModel(int objectId);
  void deleteDbObject(int objectId);
  void deleteAllObjectsFromCollection(int collectionId);
  void updateItemDbObject(int objectId, newValue);
  List<DbObjectModel> getAllFavoriteDbObjects();
}
