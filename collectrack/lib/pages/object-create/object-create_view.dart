import 'dart:io';
import 'package:collectrack/pages/object-create/object-create_model.dart';
import 'package:collectrack/pages/collection/collection_model.dart';
import 'package:collectrack/ui-kit/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collectrack/common/providers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ObjectCreateView extends ConsumerWidget {
  const ObjectCreateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations _stringBib = AppLocalizations.of(context)!;
    final ObjectCreateController controller =
        ref.read(providers.objectCreateControllerProvider.notifier);
    final ObjectCreateModel model =
        ref.watch(providers.objectCreateControllerProvider);
    final CollectionModel collectionModel =
        ref.watch(providers.collectionControllerProvider);

    // Model variables
    int _collectionId =
        model.collectionId; //Needs to be set by collecion_view.dart
    String _articlename = model.articlename;
    String _description = model.description;
    String _image = model.image;
    bool _pic = model.pic;
    int _condition = model.condition;
    String _material = model.material;
    String _country = model.country;
    double _weight = model.weight;
    DateTime _obtained = model.obtained;
    bool _favourite = model.favourite;
    int _releaseyear = model.releaseyear;
    double _cost = model.cost;

    // constant class variables
    const double _widgetDistance = 30;
    const Widget _seperator = SizedBox(height: _widgetDistance);
    const double _textFontSize = 18;
    Widget _sideClearance = const SizedBox(width: 10);

    SimpleDialog _imageDialog = SimpleDialog(
      title: Text(_stringBib.objectCreate_imageDialogTitle),
      children: [
        SimpleDialogOption(
          onPressed: () {
            controller.uploadPicture(ImageSource.camera);
            controller.popDialog(context);
          },
          child: Text(_stringBib.objectCreate_imageDialogCamera),
        ),
        SimpleDialogOption(
          onPressed: () {
            controller.uploadPicture(ImageSource.gallery);
            controller.popDialog(context);
          },
          child: Text(_stringBib.objectCreate_imageDialogGallery),
        ),
        SimpleDialogOption(
          onPressed: () {
            controller.popDialog(context);
          },
          child: Text(_stringBib.objectCreate_imageDialogCancel,
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
                      _stringBib.objectCreate_appBarTitle,
                    ))),
            Expanded(
                child: Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.red,
                        size: 40,
                      ),
                      onPressed: () {
                        controller.reset();
                        Navigator.pop(context);
                      },
                    ))),
          ]),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: ListView(padding: const EdgeInsets.all(8), children: <
                      Widget>[
                _seperator,
                //Sammlungs Name
                TextFormField(
                  decoration: InputDecoration(
                    labelText: _stringBib.objectCreate_objectName,
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (newValue) =>
                      controller.switchArticleName(newValue),
                ),
                _seperator,
                //Beschreibung
                TextFormField(
                  decoration: InputDecoration(
                    labelText: _stringBib.objectCreate_description,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    border: const OutlineInputBorder(),
                  ),
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.text,
                  maxLines: 5,
                  maxLength: 300,
                  onChanged: (newValue) =>
                      controller.switchDescription(newValue),
                ),
                _seperator,
                //Wert
                Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            width: 160,
                            child: Text(_stringBib.objectCreate_value,
                                style:
                                    const TextStyle(fontSize: _textFontSize))),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 10.0),
                                border: OutlineInputBorder(),
                              ),
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.number,
                              initialValue: _cost.toString(),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9.]')),
                              ],
                              onChanged: (newValue) {
                                try {
                                  controller.switchCost(double.parse(newValue));
                                } catch (_) {}
                              },
                            ),
                          ),
                        ),
                      ],
                    )),
                _seperator,
                //Im Besitz seit
                Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            width: 120,
                            child: Text(_stringBib.objectCreate_obtained,
                                style:
                                    const TextStyle(fontSize: _textFontSize))),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: _obtained,
                                    firstDate: DateTime(0),
                                    lastDate: DateTime(2100));
                                if (newDate != null) {
                                  controller.switchObtained(newDate);
                                }
                              },
                              icon: const Icon(Icons.date_range, size: 30),
                              label: Text(_stringBib.objectCreate_chooseDate,
                                  style: const TextStyle(
                                      fontSize: _textFontSize - 8)),
                            ),
                          ),
                        ),
                        Container(
                            alignment: Alignment.centerRight,
                            width: 120,
                            child: Text(
                                '${_obtained.day}/${_obtained.month}/${_obtained.year}',
                                style:
                                    const TextStyle(fontSize: _textFontSize))),
                      ],
                    )),
                _seperator,
                //Favourite
                Row(
                  children: [
                    Text(_stringBib.objectCreate_favourite,
                        style: const TextStyle(fontSize: _textFontSize)),
                    const Spacer(),
                    Switch(
                      value: _favourite,
                      onChanged: (bool value) {
                        controller.switchFavourite();
                      },
                    ),
                  ],
                ),
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
                //Zustand
                Visibility(
                  visible: collectionModel.condition,
                  child: Container(
                      alignment: Alignment.centerLeft,
                      height: 40,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              width: 160,
                              child: Text(_stringBib.objectCreate_condition,
                                  style: const TextStyle(
                                      fontSize: _textFontSize))),
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10.0),
                                  border: OutlineInputBorder(),
                                ),
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.number,
                                initialValue: _condition.toString(),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                onChanged: (newValue) {
                                  try {
                                    int newDoubleValue = int.parse(newValue);
                                    if (newDoubleValue < 0 ||
                                        newDoubleValue > 10) {
                                      _condition = 10;
                                    } else {
                                      controller
                                          .switchCondition(int.parse(newValue));
                                    }
                                  } catch (_) {}
                                },
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                Visibility(
                  visible: collectionModel.condition,
                  child: _seperator,
                ),
                //Material
                Visibility(
                  visible: collectionModel.material,
                  child: Container(
                      alignment: Alignment.centerLeft,
                      height: 40,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              width: 160,
                              child: Text(_stringBib.objectCreate_material,
                                  style: const TextStyle(
                                      fontSize: _textFontSize))),
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10.0),
                                    border: OutlineInputBorder(),
                                  ),
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.text,
                                  initialValue: _material,
                                  onChanged: (newValue) =>
                                      controller.switchMaterial(newValue)),
                            ),
                          ),
                        ],
                      )),
                ),
                Visibility(
                  visible: collectionModel.material,
                  child: _seperator,
                ),
                //Land
                Visibility(
                  visible: collectionModel.country,
                  child: Container(
                      alignment: Alignment.centerLeft,
                      height: 40,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              width: 160,
                              child: Text(_stringBib.objectCreate_country,
                                  style: const TextStyle(
                                      fontSize: _textFontSize))),
                          Expanded(
                              child: SizedBox(
                            width: double.infinity,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 10.0),
                                border: OutlineInputBorder(),
                              ),
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              initialValue: _country,
                              onChanged: (newValue) =>
                                  controller.switchCountry(newValue),
                            ),
                          )),
                        ],
                      )),
                ),
                Visibility(
                  visible: collectionModel.country,
                  child: _seperator,
                ),
                //Gewicht
                Visibility(
                  visible: collectionModel.weight,
                  child: Container(
                      alignment: Alignment.centerLeft,
                      height: 40,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              width: 160,
                              child: Text(_stringBib.objectCreate_weight,
                                  style: const TextStyle(
                                      fontSize: _textFontSize))),
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10.0),
                                  border: OutlineInputBorder(),
                                ),
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9.]')),
                                ],
                                initialValue: _weight.toString(),
                                onChanged: (newValue) {
                                  try {
                                    controller
                                        .switchWeight(double.parse(newValue));
                                  } catch (_) {}
                                },
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                Visibility(
                  visible: collectionModel.weight,
                  child: _seperator,
                ),
                //Release Year
                Visibility(
                  visible: collectionModel.year,
                  child: Container(
                      alignment: Alignment.centerLeft,
                      height: 40,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              width: 160,
                              child: Text(_stringBib.objectCreate_year,
                                  style: const TextStyle(
                                      fontSize: _textFontSize))),
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10.0),
                                  border: OutlineInputBorder(),
                                ),
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.number,
                                initialValue: _releaseyear.toString(),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                onChanged: (newValue) {
                                  try {
                                    controller
                                        .switchReleaseYear(int.parse(newValue));
                                  } catch (_) {}
                                },
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                Visibility(
                  visible: collectionModel.year,
                  child: _seperator,
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
                              var curve =
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
                        label: Text(_stringBib.objectCreate_uploadImage,
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
                            controller.saveObject(
                              context,
                              _collectionId,
                              _articlename,
                              _description,
                              _image,
                              _condition,
                              _cost,
                              _material,
                              _country,
                              _weight,
                              _obtained,
                              _favourite,
                              _releaseyear,
                              _pic,
                            );
                            Navigator.of(context)
                              ..pop()
                              ..pop();
                            controller.navigate(context, 1);
                            controller.navigate(context, 4);
                          },
                          child: Text(_stringBib.objectCreate_saveObject,
                              style: const TextStyle(fontSize: 24))),
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

abstract class ObjectCreateController extends StateNotifier<ObjectCreateModel> {
  ObjectCreateController(ObjectCreateModel state) : super(state);
  void navigate(BuildContext context, int value);
  void uploadPicture(ImageSource imageSource);
  void reset();
  void switchFavourite();
  void switchArticleName(String articleName);
  void switchDescription(String description);
  void switchImage(String image);
  void switchPicOn();
  void switchCondition(int condition);
  void switchMaterial(String material);
  void switchCountry(String country);
  void switchWeight(double weight);
  void switchObtained(DateTime dateTime);
  void switchReleaseYear(int releaseYear);
  void switchCost(double cost);
  void switchCollectionId(int collectionId);
  void popDialog(BuildContext context);
  void saveObject(
    context,
    int collectionId,
    String articlename,
    String description,
    String image,
    int condition,
    double cost,
    String material,
    String country,
    double weight,
    DateTime obtaineddate,
    bool favourite,
    int releaseyear,
    bool picenabled,
  );
}
