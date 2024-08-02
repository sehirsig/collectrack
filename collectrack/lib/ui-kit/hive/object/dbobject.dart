import 'dart:io';

import 'package:collectrack/common/providers.dart';
import 'package:collectrack/pages/object-edit/object-edit_view.dart';
import 'package:collectrack/pages/object/object_view.dart';
import 'package:flutter/material.dart';
import 'package:collectrack/ui-kit/hive/object/dbobject_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DbObject extends ConsumerWidget {
  final DbObjectModel object;

  const DbObject(this.object, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations _stringBib = AppLocalizations.of(context)!;
    final ObjectController objectController =
        ref.read(providers.objectControllerProvider.notifier);

    final ObjectEditController objectEditController =
        ref.read(providers.objectEditControllerProvider.notifier);

    // global variables
    const double _textFontSize = 14;
    const double _titleFontSize = 18;
    const double _deleteFontSize = 15;

    AlertDialog _deleteDialog = AlertDialog(
      title: Text(_stringBib.dbObject_deleteTitle),
      content: Text(_stringBib.dbObject_deleteText),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text(_stringBib.dbObject_deleteNo)),
        TextButton(
            onPressed: () {
              objectController.deleteObject(object.id);
              // Pop dialog
              Navigator.of(context, rootNavigator: true).pop();
              // Pop collection site
              Navigator.of(context).pop();
              // Load new collection site
              Navigator.pushNamed(context, '/collection');
            },
            child: Text(_stringBib.dbObject_deleteYes,
                style: const TextStyle(color: Colors.red))),
      ],
    );

    SimpleDialog _editDialog = SimpleDialog(
      title: Text(_stringBib.dbObject_editTitle),
      children: [
        SimpleDialogOption(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            objectEditController.reset();
            objectEditController.getHiveInfos(object.id);
            Navigator.pushNamed(context, '/object-edit');
          },
          child: Text(_stringBib.dbObject_editText,
              style: const TextStyle(fontSize: _titleFontSize)),
        ),
        Row(
          children: [
            SimpleDialogOption(
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Text(_stringBib.dbObject_cancel,
                  style: const TextStyle(fontSize: _deleteFontSize),
                  textAlign: TextAlign.right),
            ),
            const Spacer(),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                showGeneralDialog(
                  context: context,
                  pageBuilder: (ctx, anim1, anim2) {
                    return Container();
                  },
                  transitionBuilder: (ctx, anim1, anim2, child) {
                    double curve = Curves.easeInOut.transform(anim1.value);
                    return Transform.scale(
                      scale: curve,
                      child: _deleteDialog,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                );
              },
              child: Text(_stringBib.dbObject_editDelete,
                  style: const TextStyle(
                      color: Colors.red, fontSize: _deleteFontSize),
                  textAlign: TextAlign.right),
            ),
          ],
        ),
      ],
      elevation: 10,
    );

    return InkWell(
        onTap: () {
          objectController.reset();
          objectController.getHiveObj(object.id);
          Navigator.pushNamed(context, '/object');
        },
        onLongPress: () async {
          showGeneralDialog(
            context: context,
            pageBuilder: (ctx, anim1, anim2) {
              return Container();
            },
            transitionBuilder: (ctx, anim1, anim2, child) {
              double curve = Curves.easeInOut.transform(anim1.value);
              return Transform.scale(
                scale: curve,
                child: _editDialog,
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
          );
        },
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      _stringBib.dbObject_name,
                      style: const TextStyle(fontSize: _textFontSize),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: Text(
                      object.articlename,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: _titleFontSize),
                    )),
                    const SizedBox(
                      width: 14,
                    ),
                    Row(
                      children: [
                        Text(_stringBib.dbObject_favourite),
                        object.favourite
                            ? const Icon(Icons.star)
                            : const Icon(Icons.star_border),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(_stringBib.dbObject_value(object.cost.toString()),
                        style: const TextStyle(fontSize: _textFontSize)),
                  ],
                ),
                (object.image == "")
                    ? Image.asset('assets/images/small_logo.png',
                        width: 64, height: 64)
                    : Image.file(File(object.image), width: 64, height: 64)
              ]),
            )));
  }
}
