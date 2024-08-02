import 'dart:io';
import 'package:collectrack/pages/object-edit/object-edit_view.dart';
import 'package:collectrack/pages/object/object_model.dart';
import 'package:collectrack/pages/collection/collection_model.dart';
import 'package:collectrack/ui-kit/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collectrack/common/providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ObjectView extends ConsumerWidget {
  const ObjectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations _stringBib = AppLocalizations.of(context)!;
    final ObjectController controller =
        ref.read(providers.objectControllerProvider.notifier);
    final ObjectModel model = ref.watch(providers.objectControllerProvider);

    final CollectionModel collectionModel =
        ref.watch(providers.collectionControllerProvider);

    // Controller bei Collection einbauen und eine Funktion aufrufen die mit der gegebenen HiveID alles bezieht
    final ObjectEditController objectEditController =
        ref.read(providers.objectEditControllerProvider.notifier);

    // Model variables
    String _articlename = model.articleName;
    String _description = model.description;
    String _image = model.image;
    int _condition = model.condition;
    String _material = model.material;
    String _country = model.country;
    double _weight = model.weight;
    DateTime _obtained = model.obtained;
    int _releaseyear = model.releaseYear;
    double _cost = model.cost;

    int _hiveObjectId = model.hiveObjectId; //getHiveObj von Collection aufrufen

    // constant class variables
    const Widget _sideDistance = SizedBox(width: 35);

    const double _fontSize = 18;

    return Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Expanded(
                child: Container(
                    width: double.infinity,
                    alignment: Alignment.centerRight,
                    child: Text(
                      _articlename,
                    ))),
            Expanded(
                child: Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        size: 40,
                      ),
                      onPressed: () {
                        objectEditController.reset();
                        objectEditController.getHiveInfos(_hiveObjectId);
                        controller.navigate(context, 3);
                      },
                    ))),
          ]),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Objekt Name
            Row(
              children: [
                Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      constraints: const BoxConstraints(minHeight: 30),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: const BorderRadius.horizontal(),
                      ),
                      child: Text(_articlename,
                          style: const TextStyle(fontSize: _fontSize))),
                )
              ],
            ),
            Expanded(
                child: ListView(
              children: [
                //Image
                Card(
                  child: (_image != "")
                      ? Image.file(File(_image), width: 256, height: 256)
                      : Image.asset('assets/images/small_logo.png',
                          width: 256, height: 256),
                ),
                //Row Wert, Im Besitz seit
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: const BorderRadius.horizontal(),
                      ),
                      child: Column(
                        children: [
                          Text(_stringBib.object_value,
                              style: const TextStyle(fontSize: _fontSize)),
                          Text(_stringBib.object_euro(_cost.toString()),
                              style: const TextStyle(fontSize: _fontSize))
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: const BorderRadius.horizontal(),
                      ),
                      child: Column(
                        children: [
                          Text(_stringBib.object_obtained,
                              style: const TextStyle(fontSize: _fontSize)),
                          Text(
                              '${_obtained.day}/${_obtained.month}/${_obtained.year}',
                              style: const TextStyle(fontSize: _fontSize))
                        ],
                      ),
                    )),
                  ],
                ),
                Container(
                    alignment: Alignment.center,
                    height: 2,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: const BorderRadius.horizontal(),
                    ),
                    child: null),
                //Text Beschreibung
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: const BorderRadius.horizontal(),
                          ),
                          child: Text(_stringBib.object_description,
                              style: const TextStyle(fontSize: _fontSize))),
                    )
                  ],
                ),
                //Beschreibung
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        constraints: const BoxConstraints(minHeight: 30),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: const BorderRadius.horizontal(),
                        ),
                        child: Row(children: [
                          _sideDistance,
                          Expanded(
                            child: Text(_description,
                                style:
                                    const TextStyle(fontSize: _fontSize - 5)),
                          ),
                          _sideDistance,
                        ]),
                      ),
                    )
                  ],
                ),
                Container(
                    alignment: Alignment.center,
                    height: 2,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: const BorderRadius.horizontal(),
                    ),
                    child: null),
                //Zustand
                Visibility(
                  visible: collectionModel.condition,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: const BorderRadius.horizontal(),
                    ),
                    child: Row(
                      children: [
                        Container(
                            alignment: Alignment.centerRight,
                            width: 120,
                            child: Text(_stringBib.object_condition,
                                style:
                                    const TextStyle(fontSize: _fontSize - 5))),
                        Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              width: 200,
                              child: Text(_condition.toString() + "/10",
                                  style: const TextStyle(
                                      fontSize: _fontSize - 5))),
                        ),
                      ],
                    ),
                  ),
                ),
                //Material
                Visibility(
                  visible: collectionModel.material,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: const BorderRadius.horizontal(),
                    ),
                    child: Row(
                      children: [
                        Container(
                            alignment: Alignment.centerRight,
                            width: 120,
                            child: Text(_stringBib.object_material,
                                style:
                                    const TextStyle(fontSize: _fontSize - 5))),
                        Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              width: 200,
                              child: Text(_material.toString(),
                                  style: const TextStyle(
                                      fontSize: _fontSize - 5))),
                        ),
                      ],
                    ),
                  ),
                ),
                //Country
                Visibility(
                  visible: collectionModel.country,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: const BorderRadius.horizontal(),
                    ),
                    child: Row(
                      children: [
                        Container(
                            alignment: Alignment.centerRight,
                            width: 120,
                            child: Text(_stringBib.object_country,
                                style:
                                    const TextStyle(fontSize: _fontSize - 5))),
                        Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              width: 200,
                              child: Text(_country.toString(),
                                  style: const TextStyle(
                                      fontSize: _fontSize - 5))),
                        ),
                      ],
                    ),
                  ),
                ),
                //Weight
                Visibility(
                  visible: collectionModel.weight,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: const BorderRadius.horizontal(),
                    ),
                    child: Row(
                      children: [
                        Container(
                            alignment: Alignment.centerRight,
                            width: 120,
                            child: Text(_stringBib.object_weight,
                                style:
                                    const TextStyle(fontSize: _fontSize - 5))),
                        Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              width: 200,
                              child: Text(_weight.toString(),
                                  style: const TextStyle(
                                      fontSize: _fontSize - 5))),
                        ),
                      ],
                    ),
                  ),
                ),
                //Year
                Visibility(
                  visible: collectionModel.year,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: const BorderRadius.horizontal(),
                    ),
                    child: Row(
                      children: [
                        Container(
                            alignment: Alignment.centerRight,
                            width: 120,
                            child: Text(_stringBib.object_year,
                                style:
                                    const TextStyle(fontSize: _fontSize - 5))),
                        Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              width: 200,
                              child: Text(_releaseyear.toString(),
                                  style: const TextStyle(
                                      fontSize: _fontSize - 5))),
                        ),
                      ],
                    ),
                  ),
                ),
                //Bearbeiten-Taste
              ],
            )),
          ],
        )),
        bottomNavigationBar: const CtNavigationBar(1));
  }
}

abstract class ObjectController extends StateNotifier<ObjectModel> {
  ObjectController(ObjectModel state) : super(state);
  void navigate(BuildContext context, int value);
  void reset();
  void switchFavourite(int hiveObjId);
  void getHiveObj(int hiveObjId);
  void deleteObject(int hiveObjId);
}
