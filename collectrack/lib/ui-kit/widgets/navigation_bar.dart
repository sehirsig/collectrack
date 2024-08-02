import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CtNavigationBar extends StatelessWidget {
  final int selected;

  const CtNavigationBar(this.selected, {Key? key}) : super(key: key);

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
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 14,
      unselectedFontSize: 14,
      iconSize: 40,
      currentIndex: selected,
      onTap: (value) {
        navigate(context, value);
      },
      items: [
        BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.navigation_home,
          icon: const Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.navigation_collections,
          icon: const Icon(Icons.collections_bookmark),
        ),
        BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.navigation_settings,
          icon: const Icon(Icons.settings),
        ),
      ],
    );
  }
}
