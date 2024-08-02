import 'package:collectrack/ui-kit/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HelpCenterView extends StatelessWidget {
  const HelpCenterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations _stringBib = AppLocalizations.of(context)!;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            _stringBib.helpCenter_appBarTitle,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  ExpansionTile(
                    title: Text(_stringBib.helpCenter_howNewCollectionTitle,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        )),
                    children: <Widget>[
                      Text(_stringBib.helpCenter_howNewCollectionText)
                    ],
                  ),
                  ExpansionTile(
                    title: Text(_stringBib.helpCenter_howNewObjectTitle,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        )),
                    children: <Widget>[
                      Text(_stringBib.helpCenter_howNewObjectText)
                    ],
                  ),
                  ExpansionTile(
                    title: Text(_stringBib.helpCenter_howEditTitle,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        )),
                    children: <Widget>[
                      Text(_stringBib.helpCenter_howEditText)
                    ],
                  ),
                  ExpansionTile(
                    title:
                        Text(_stringBib.helpCenter_howBackupSaveCollectionTitle,
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                            )),
                    children: <Widget>[
                      Text(_stringBib.helpCenter_howBackupSaveCollectionText)
                    ],
                  ),
                  ExpansionTile(
                    title:
                        Text(_stringBib.helpCenter_howBackupLoadCollectionTitle,
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                            )),
                    children: <Widget>[
                      Text(_stringBib.helpCenter_howBackupLoadCollectionText)
                    ],
                  ),
                ],
              )),
            ],
          ),
        ),
        bottomNavigationBar: const CtNavigationBar(2));
  }
}
