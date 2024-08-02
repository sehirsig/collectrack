import 'package:collectrack/common/local_persistence/hive/local_persistence_service_hive_implementation.dart';
import 'package:collectrack/common/shared_preferences/shared_preferences_provider.dart';
import 'package:collectrack/common/theme/themes.dart';
import 'package:collectrack/common/theme/themes_provider.dart';
import 'package:collectrack/l10n/l10n.dart';
import 'package:collectrack/pages/help-center/help-center_view.dart';
import 'package:collectrack/pages/list-collections/list-collections_view.dart';
import 'package:collectrack/pages/collection-create/collection-create_view.dart';
import 'package:collectrack/pages/collection-edit/collection-edit_view.dart';
import 'package:collectrack/pages/collection/collection_view.dart';
import 'package:collectrack/pages/object-create/object-create_view.dart';
import 'package:collectrack/pages/object-edit/object-edit_view.dart';
import 'package:collectrack/pages/object/object_view.dart';
import 'package:collectrack/pages/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collectrack/pages/home/home_view.dart';
import 'package:collectrack/common/providers.dart';
import 'package:collectrack/pages/collection-filter/collection-filter_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:collectrack/common/locale/locale_provider';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(await buildApp());
}

Future<Widget> buildApp() async {
  final localPersistenceService = LocalPersistenceServiceHive();
  await localPersistenceService.initHive();

  final prefs = SharedPrefProvider();
  final prefProv = await SharedPreferences.getInstance();
  prefs.setSharedPref(prefProv);

  final locale = LocaleProvider();
  locale.setLocale(L10n.getLocaleFromInt(prefs.getInt('language')));

  final theme = ThemeProvider();
  theme.setTheme(Themes.getThemeFromInt(prefs.getInt('theme')));

  return ProviderScope(
    overrides: [
      providers.localPersistenceProvider
          .overrideWithValue(localPersistenceService),
      providers.themeProvider.overrideWith((ref) => theme),
      providers.sharePrefProvider.overrideWith((ref) => prefs),
      providers.localeProvider.overrideWith((ref) => locale),
    ],
    child: const MyApp(),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LocaleProvider localeProvider = ref.watch(providers.localeProvider);

    final ThemeProvider themeProvider = ref.watch(providers.themeProvider);

    return MaterialApp(
      theme: themeProvider.theme,
      locale: localeProvider.locale,
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: Navigator(
        initialRoute: '/home',
        onGenerateRoute: (RouteSettings routeParams) {
          if (routeParams.name == '/home') {
            return MaterialPageRouteNoAnimation(
                builder: (context) => const HomeView());
          }
          if (routeParams.name == '/list-collections') {
            return MaterialPageRouteNoAnimation(
                builder: (context) => const ListCollectionsView());
          }
          if (routeParams.name == '/settings') {
            return MaterialPageRouteNoAnimation(
                builder: (context) => const SettingsView());
          }
          if (routeParams.name == '/help-center') {
            return MaterialPageRouteNoAnimation(
                builder: (context) => const HelpCenterView());
          }
          if (routeParams.name == '/collection') {
            return MaterialPageRouteNoAnimation(
                builder: (context) => const CollectionView());
          }
          if (routeParams.name == '/collection-filter') {
            return MaterialPageRouteNoAnimation(
                builder: (context) => const CollectionFilterView());
          }
          if (routeParams.name == '/collection-create') {
            return MaterialPageRouteNoAnimation(
                builder: (context) => const CollectionCreateView());
          }
          if (routeParams.name == '/collection-edit') {
            return MaterialPageRouteNoAnimation(
                builder: (context) => const CollectionEditView());
          }
          if (routeParams.name == '/object-create') {
            return MaterialPageRouteNoAnimation(
                builder: (context) => const ObjectCreateView());
          }
          if (routeParams.name == '/object-edit') {
            return MaterialPageRouteNoAnimation(
                builder: (context) => const ObjectEditView());
          }
          if (routeParams.name == '/object') {
            return MaterialPageRouteNoAnimation(
                builder: (context) => const ObjectView());
          }
          return MaterialPageRouteNoAnimation(
              builder: (context) =>
                  const Center(child: Text('Unknown Screen')));
        },
        onPopPage: (route, result) {
          return route.didPop(result);
        },
      ),
    );
  }
}

class MaterialPageRouteNoAnimation extends MaterialPageRoute {
  MaterialPageRouteNoAnimation({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}
