import 'package:collectrack/common/shared_preferences/shared_preferences_provider.dart';
import 'package:collectrack/common/theme/themes_provider.dart';
import 'package:collectrack/pages/list-collections/list-collections_controller.dart';
import 'package:collectrack/pages/list-collections/list-collections_model.dart';
import 'package:collectrack/pages/list-collections/list-collections_view.dart';
import 'package:collectrack/pages/object/object_model.dart';
import 'package:collectrack/pages/object/object_view.dart';
import 'package:collectrack/pages/object/object_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collectrack/pages/home/home_controller.dart';
import 'package:collectrack/pages/home/home_model.dart';
import 'package:collectrack/pages/home/home_view.dart';
import 'package:collectrack/pages/settings/settings_controller.dart';
import 'package:collectrack/pages/settings/settings_model.dart';
import 'package:collectrack/pages/settings/settings_view.dart';
import 'package:collectrack/pages/collection-create/collection-create_controller.dart';
import 'package:collectrack/pages/collection-create/collection-create_model.dart';
import 'package:collectrack/pages/collection-create/collection-create_view.dart';
import 'package:collectrack/pages/collection-edit/collection-edit_controller.dart';
import 'package:collectrack/pages/collection-edit/collection-edit_model.dart';
import 'package:collectrack/pages/collection-edit/collection-edit_view.dart';
import 'package:collectrack/pages/object-create/object-create_controller.dart';
import 'package:collectrack/pages/object-create/object-create_model.dart';
import 'package:collectrack/pages/object-create/object-create_view.dart';
import 'package:collectrack/pages/collection/collection_controller.dart';
import 'package:collectrack/pages/collection/collection_model.dart';
import 'package:collectrack/pages/collection/collection_view.dart';
import 'package:collectrack/pages/object-edit/object-edit_controller.dart';
import 'package:collectrack/pages/object-edit/object-edit_model.dart';
import 'package:collectrack/pages/object-edit/object-edit_view.dart';
import 'package:collectrack/common/local_persistence/local_persistence_service.dart';
import 'package:collectrack/pages/collection-filter/collection-filter_controller.dart';
import 'package:collectrack/pages/collection-filter/collection-filter_model.dart';
import 'package:collectrack/pages/collection-filter/collection-filter_view.dart';
import 'package:collectrack/common/locale/locale_provider';

final Providers providers = Providers();

class Providers {
  final Provider<LocalPersistenceService> localPersistenceProvider =
      Provider<LocalPersistenceService>(
          (ProviderRef _) => throw UnimplementedError());

  final ChangeNotifierProvider<LocaleProvider> localeProvider =
      ChangeNotifierProvider<LocaleProvider>(
          (ChangeNotifierProviderRef ref) => LocaleProvider());

  final ChangeNotifierProvider<ThemeProvider> themeProvider =
      ChangeNotifierProvider<ThemeProvider>(
          (ChangeNotifierProviderRef ref) => ThemeProvider());

  final ChangeNotifierProvider<SharedPrefProvider> sharePrefProvider =
      ChangeNotifierProvider<SharedPrefProvider>(
          (ChangeNotifierProviderRef ref) => SharedPrefProvider());

  final StateNotifierProvider<HomeController, HomeModel>
      homeControllerProvider = StateNotifierProvider<HomeController, HomeModel>(
          (StateNotifierProviderRef ref) => HomeControllerImplementation(
                localPersistenceService:
                    ref.read(providers.localPersistenceProvider),
              ));

  final StateNotifierProvider<SettingsController, SettingsModel>
      settingsControllerProvider =
      StateNotifierProvider<SettingsController, SettingsModel>(
          (StateNotifierProviderRef ref) => SettingsControllerImplementation(
              sharedPref: ref.read(providers.sharePrefProvider)));

  final StateNotifierProvider<ListCollectionsController, ListCollectionsModel>
      listCollectionsControllerProvider =
      StateNotifierProvider<ListCollectionsController, ListCollectionsModel>(
          (StateNotifierProviderRef ref) =>
              ListCollectionsControllerImplementation(
                localPersistenceService:
                    ref.read(providers.localPersistenceProvider),
              ));

  final StateNotifierProvider<CollectionCreateController, CollectionCreateModel>
      collectionCreateControllerProvider =
      StateNotifierProvider<CollectionCreateController, CollectionCreateModel>(
          (StateNotifierProviderRef ref) =>
              CollectionCreateControllerImplementation(
                localPersistenceService:
                    ref.read(providers.localPersistenceProvider),
              ));

  final StateNotifierProvider<CollectionEditController, CollectionEditModel>
      collectionEditControllerProvider =
      StateNotifierProvider<CollectionEditController, CollectionEditModel>(
          (StateNotifierProviderRef ref) =>
              CollectionEditControllerImplementation(
                localPersistenceService:
                    ref.read(providers.localPersistenceProvider),
              ));

  final StateNotifierProvider<CollectionFilterController, CollectionFilterModel>
      collectionFilterControllerProvider =
      StateNotifierProvider<CollectionFilterController, CollectionFilterModel>(
          (StateNotifierProviderRef ref) =>
              CollectionFilterControllerImplementation(
                localPersistenceService:
                    ref.read(providers.localPersistenceProvider),
              ));

  final StateNotifierProvider<ObjectCreateController, ObjectCreateModel>
      objectCreateControllerProvider =
      StateNotifierProvider<ObjectCreateController, ObjectCreateModel>(
          (StateNotifierProviderRef ref) =>
              ObjectCreateControllerImplementation(
                localPersistenceService:
                    ref.read(providers.localPersistenceProvider),
              ));

  final StateNotifierProvider<CollectionController, CollectionModel>
      collectionControllerProvider =
      StateNotifierProvider<CollectionController, CollectionModel>(
          (StateNotifierProviderRef ref) => CollectionControllerImplementation(
                localPersistenceService:
                    ref.read(providers.localPersistenceProvider),
              ));

  final StateNotifierProvider<ObjectController, ObjectModel>
      objectControllerProvider =
      StateNotifierProvider<ObjectController, ObjectModel>(
          (StateNotifierProviderRef ref) => ObjectControllerImplementation(
                localPersistenceService:
                    ref.read(providers.localPersistenceProvider),
              ));

  final StateNotifierProvider<ObjectEditController, ObjectEditModel>
      objectEditControllerProvider =
      StateNotifierProvider<ObjectEditController, ObjectEditModel>(
          (StateNotifierProviderRef ref) => ObjectEditControllerImplementation(
                localPersistenceService:
                    ref.read(providers.localPersistenceProvider),
              ));
}
