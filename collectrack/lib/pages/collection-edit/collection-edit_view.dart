import 'dart:io';
import 'package:collectrack/pages/collection-edit/collection-edit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collectrack/common/providers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../ui-kit/widgets/navigation_bar.dart';

class CollectionEditView extends ConsumerWidget {
  const CollectionEditView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations _stringBib = AppLocalizations.of(context)!;
    final CollectionEditController controller =
        ref.read(providers.collectionEditControllerProvider.notifier);
    final CollectionEditModel model =
        ref.watch(providers.collectionEditControllerProvider);

    int _collectionHiveId = model.collectionHiveId;
    String _articlename = model.articlename;
    String _description = model.description;
    String _image = model.image;
    bool _pic = model.pic;
    bool _condition = model.condition;
    bool _material = model.material;
    bool _country = model.country;
    bool _weight = model.weight;
    bool _year = model.year;

    // constant class variables
    const double _widgetDistance = 30;
    const Widget _seperator = SizedBox(height: _widgetDistance);
    const double _textFontSize = 24;
    Widget _sideClearance = const SizedBox(width: 10);

    // Dialoge

    AlertDialog _deleteDialog = AlertDialog(
      title: Text(_stringBib.collectionEdit_deleteTitle),
      content: Text(_stringBib.collectionEdit_deleteText),
      actions: [
        TextButton(
            onPressed: () {
              controller.deleteCollection(_collectionHiveId);
              // Pop dialog
              controller.popDialog(context);
              // Pop collection site
              Navigator.of(context).pop();
              // Load new collection site
              controller.navigate(context, 1);
            },
            child: Text(_stringBib.collectionEdit_deleteYes)),
        TextButton(
            onPressed: () {
              controller.popDialog(context);
            },
            child: Text(_stringBib.collectionEdit_deleteNo))
      ],
    );

    SimpleDialog _imageDialog = SimpleDialog(
      title: Text(_stringBib.collectionEdit_uploadImage),
      children: [
        SimpleDialogOption(
          onPressed: () {
            controller.uploadPicture(ImageSource.camera);
            controller.popDialog(context);
          },
          child: Text(_stringBib.collectionEdit_imageDialogCamera),
        ),
        SimpleDialogOption(
          onPressed: () {
            controller.uploadPicture(ImageSource.gallery);
            controller.popDialog(context);
          },
          child: Text(_stringBib.collectionEdit_imageDialogGallery),
        ),
        SimpleDialogOption(
          onPressed: () {
            controller.popDialog(context);
          },
          child: Text(_stringBib.collectionEdit_imageDialogCancel,
              style: const TextStyle(fontSize: 12), textAlign: TextAlign.right),
        ),
      ],
      elevation: 10,
    );

    return Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Expanded(
                child: Container(
                    width: double.infinity,
                    alignment: Alignment.centerRight,
                    child: Text(
                      _stringBib.collectionEdit_appBarTitle,
                    ))),
            Expanded(
                child: Container(
                    width: 20,
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 40,
                      ),
                      onPressed: () async {
                        showGeneralDialog(
                          context: context,
                          pageBuilder: (ctx, anim1, anim2) {
                            return Container();
                          },
                          transitionBuilder: (ctx, anim1, anim2, child) {
                            double curve =
                                Curves.easeInOut.transform(anim1.value);
                            return Transform.scale(
                              scale: curve,
                              child: _deleteDialog,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 300),
                        );
                      },
                    ))),
          ]),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: ListView(
                      padding: const EdgeInsets.all(8),
                      children: <Widget>[
                    _seperator,
                    //SammlungsName
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: _stringBib.collectionEdit_collectionName,
                        border: const OutlineInputBorder(),
                      ),
                      initialValue: _articlename,
                      onChanged: (newValue) => controller.switchName(newValue),
                    ),
                    _seperator,
                    //Beschreibung
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: _stringBib.collectionEdit_description,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          border: const OutlineInputBorder(),
                        ),
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        maxLength: 300,
                        initialValue: _description,
                        onChanged: (newValue) =>
                            controller.switchDescription(newValue)),
                    _seperator,
                    //Bild
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                        ),
                      ),
                      child: _pic
                          ? Image.file(File(_image), width: 256, height: 256)
                          : Image.asset('assets/images/small_logo.png',
                              width: 256, height: 256),
                    ),
                    _seperator,
                    //
                    Text(
                      _stringBib.collectionEdit_configure,
                      textAlign: TextAlign.center,
                    ),
                    SwitchListTile(
                      title: Text(_stringBib.collectionEdit_condition,
                          style: const TextStyle(fontSize: _textFontSize)),
                      value: _condition,
                      onChanged: (bool value) {
                        controller.switchCondition();
                      },
                    ),
                    SwitchListTile(
                      title: Text(_stringBib.collectionEdit_material,
                          style: const TextStyle(fontSize: _textFontSize)),
                      value: _material,
                      onChanged: (bool value) {
                        controller.switchMaterial();
                      },
                    ),
                    SwitchListTile(
                      title: Text(_stringBib.collectionEdit_country,
                          style: const TextStyle(fontSize: _textFontSize)),
                      value: _country,
                      onChanged: (bool value) {
                        controller.switchCountry();
                      },
                    ),
                    SwitchListTile(
                      title: Text(_stringBib.collectionEdit_weight,
                          style: const TextStyle(fontSize: _textFontSize)),
                      value: _weight,
                      onChanged: (bool value) {
                        controller.switchWeight();
                      },
                    ),
                    SwitchListTile(
                      title: Text(_stringBib.collectionEdit_year,
                          style: const TextStyle(fontSize: _textFontSize)),
                      value: _year,
                      onChanged: (bool value) {
                        controller.switchYear();
                      },
                    ),
                  ])),
              Row(
                children: [
                  _sideClearance,
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          showGeneralDialog(
                            context: context,
                            pageBuilder: (ctx, anim1, anim2) {
                              return Container();
                            },
                            transitionBuilder: (ctx, anim1, anim2, child) {
                              double curve =
                                  Curves.easeInOut.transform(anim1.value);
                              return Transform.scale(
                                scale: curve,
                                child: _imageDialog,
                              );
                            },
                            transitionDuration:
                                const Duration(milliseconds: 300),
                          );
                        },
                        icon: const Icon(Icons.upload, size: 30),
                        label: Text(_stringBib.collectionEdit_uploadImage,
                            style: const TextStyle(fontSize: 24)),
                      ),
                    ),
                  ),
                  _sideClearance
                ],
              ),
              Row(
                children: [
                  _sideClearance,
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.saveCollection(
                            context,
                            _collectionHiveId,
                            _articlename,
                            _description,
                            _image,
                            _pic,
                            _condition,
                            _material,
                            _country,
                            _weight,
                            _year,
                          );
                        },
                        child: Text(_stringBib.collectionEdit_save,
                            style: const TextStyle(fontSize: 24)),
                      ),
                    ),
                  ),
                  _sideClearance
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CtNavigationBar(1));
  }
}

abstract class CollectionEditController
    extends StateNotifier<CollectionEditModel> {
  CollectionEditController(CollectionEditModel state) : super(state);
  void navigate(BuildContext context, int value);
  void uploadPicture(ImageSource imageSource);
  void reset();
  void switchCondition();
  void switchMaterial();
  void switchCountry();
  void switchWeight();
  void switchYear();
  void switchName(String name);
  void switchDescription(String description);
  void getHiveInfos(int hiveCollectionId);
  void deleteCollection(int hiveCollectionId);
  void popDialog(BuildContext context);
  void saveCollection(
    context,
    int collectionHiveId,
    String articlename,
    String description,
    String image,
    bool pic,
    bool condition,
    bool material,
    bool country,
    bool weight,
    bool year,
  );
}
