import 'dart:io';

import 'package:collectrack/common/providers.dart';
import 'package:collectrack/pages/collection-edit/collection-edit_view.dart';
import 'package:collectrack/pages/collection/collection_view.dart';
import 'package:collectrack/pages/collection-filter/collection-filter_view.dart';
import 'package:flutter/material.dart';
import 'package:collectrack/ui-kit/hive/collection/dbcollection_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DbCollection extends ConsumerWidget {
  final DbCollectionModel collection;

  const DbCollection(this.collection, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations _stringBib = AppLocalizations.of(context)!;
    final CollectionController collectionController =
        ref.read(providers.collectionControllerProvider.notifier);

    final CollectionEditController collectionEditController =
        ref.read(providers.collectionEditControllerProvider.notifier);

    final CollectionFilterController collectionFilterController =
        ref.read(providers.collectionFilterControllerProvider.notifier);

    // global variables
    const double _textFontSize = 14;
    const double _titleFontSize = 18;
    const double _deleteFontSize = 15;

    AlertDialog _deleteDialog = AlertDialog(
      title: Text(_stringBib.dbCollection_deleteTitle),
      content: Text(_stringBib.dbCollection_deleteText),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text(_stringBib.dbCollection_deleteNo)),
        TextButton(
            onPressed: () {
              collectionController.deleteCollection(collection.id);
              // Pop dialog
              Navigator.of(context, rootNavigator: true).pop();
              // Pop collection site
              Navigator.of(context).pop();
              // Load new collection site
              Navigator.pushNamed(context, '/list-collections');
            },
            child: Text(_stringBib.dbCollection_deleteYes,
                style: const TextStyle(color: Colors.red))),
      ],
    );

    SimpleDialog _editDialog = SimpleDialog(
      title: Text(_stringBib.dbCollection_editTitle),
      children: [
        SimpleDialogOption(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            collectionEditController.reset();
            collectionEditController.getHiveInfos(collection.id);
            Navigator.pushNamed(context, '/collection-edit');
          },
          child: Text(_stringBib.dbCollection_editText,
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
              child: Text(_stringBib.dbCollection_editDelete,
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
          collectionController.reset();
          collectionFilterController.reset();
          collectionController.getCollection(collection.id, ref);
          Navigator.pushNamed(context, '/collection');
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
                  Text(_stringBib.dbCollection_name,
                      style: const TextStyle(fontSize: _textFontSize)),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: Text(
                    collection.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: _titleFontSize),
                  )),
                  const SizedBox(
                    width: 14,
                  ),
                  InkWell(
                      child: const Icon(Icons.list_rounded),
                      onTap: () {
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
                      })
                ],
              ),
              (collection.image == "")
                  ? Image.asset('assets/images/small_logo.png',
                      width: 128, height: 128)
                  : Image.file(File(collection.image), width: 128, height: 128)
            ]))));
  }
}
