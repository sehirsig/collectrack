import 'package:collectrack/common/local_persistence/local_persistence_service.dart';
import 'package:collectrack/pages/list-collections/list-collections_model.dart';
import 'package:collectrack/pages/list-collections/list-collections_view.dart';
import 'package:collectrack/ui-kit/hive/collection/dbcollection_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';

class ListCollectionsControllerImplementation
    extends ListCollectionsController {
  final LocalPersistenceService _localPersistenceService;

  ListCollectionsControllerImplementation(
      {required LocalPersistenceService localPersistenceService,
      ListCollectionsModel? model})
      : _localPersistenceService = localPersistenceService,
        super(
          model ??
              const ListCollectionsModel(
                collections: [],
                filterText: "",
              ),
        );

  List<DbCollectionModel> _copyAllDbCollections() {
    List<DbCollectionModel> collectionList =
        _localPersistenceService.getAllDbCollections();
    List<DbCollectionModel> filteredList = [];
    if (state.filterText != "") {
      for (DbCollectionModel collection in collectionList) {
        if (collection.title
            .toLowerCase()
            .contains(state.filterText.toLowerCase())) {
          filteredList.add(collection);
        }
      }
      return filteredList;
    } else {
      return collectionList;
    }
  }

  @override
  List<DbCollectionModel> getCollections() {
    return _copyAllDbCollections();
  }

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
        Navigator.pushNamed(context, '/list-collections-filter');
        break;
      case 4:
        Navigator.pushNamed(context, '/collection-create');
        break;
      case 5:
        Navigator.pushNamed(context, '/collection-edit');
        break;
      case 6:
        Navigator.pushNamed(context, '/collection');
        break;
    }
  }

  @override
  void deleteAllCollections() {
    _localPersistenceService.clearAllDbCollection();
    _copyAllDbCollections();
  }

  @override
  void deleteCollectionId(int id) {
    _localPersistenceService.clearIdDbCollection(id);
    _copyAllDbCollections();
  }

  @override
  void switchFilterText(String filterText) {
    state = state.copyWith(filterText: filterText);
  }

  @override
  Future<String> loadDatabase(BuildContext context) async {
    AppLocalizations _stringBib = AppLocalizations.of(context)!;
    FilePicker.platform.clearTemporaryFiles();
    FilePickerResult? result1 =
        await FilePicker.platform.pickFiles(type: FileType.any);
    if (result1 != null) {
      String? path1 = result1.files.single.path!;
      if (path1.contains("ct1.ct") || path1.contains("ct2.ct")) {
        FilePickerResult? result2 = await FilePicker.platform.pickFiles();
        if (result2 != null) {
          String? path2 = result2.files.single.path!;
          if (path2.contains("ct1.ct") || path2.contains("ct2.ct")) {
            String pathCol = (path1.contains("1")) ? path1 : path2;
            String pathObj = (path2.contains("2")) ? path2 : path1;
            if (pathCol == pathObj) {
              return _stringBib.collectionsList_backUpErrorSame;
            }
            _localPersistenceService.loadDatabase(pathCol, pathObj);
          } else {
            return _stringBib.collectionsList_backUpErrorWrong;
          }
        }
      } else {
        return _stringBib.collectionsList_backUpErrorWrong;
      }
    }
    return "";
  }

  @override
  Future<String> saveDatabase(BuildContext context) async {
    AppLocalizations _stringBib = AppLocalizations.of(context)!;

    if (!(await Permission.storage.request().isGranted)) {
      return _stringBib.collectionsList_backUpSaveNoPermission;
    }

    FilePicker.platform.clearTemporaryFiles();
    String? path = await FilePicker.platform.getDirectoryPath();
    if (path != null) {
      String pathCol = path + "/ct1.ct"; //ctCol = 1
      String pathObj = path + "/ct2.ct"; //ctObj = 2
      return await _localPersistenceService.saveDatabase(pathCol, pathObj);
    } else {
      return _stringBib.collectionsList_backUpSaveNoPath;
    }
  }

  @override
  void popDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
