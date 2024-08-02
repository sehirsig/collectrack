import 'package:collectrack/pages/collection/collection_model.dart';
import 'package:collectrack/ui-kit/hive/collection/dbcollection_model.dart';
import 'package:collectrack/ui-kit/hive/object/dbobject_model.dart';
import 'package:collectrack/ui-kit/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collectrack/common/providers.dart';
import 'package:collectrack/pages/collection-filter/collection-filter_model.dart';
import 'package:collectrack/ui-kit/widgets/collection-filter/value_slider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CollectionFilterView extends ConsumerWidget {
  const CollectionFilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations _stringBib = AppLocalizations.of(context)!;
    final CollectionFilterController controller =
        ref.read(providers.collectionFilterControllerProvider.notifier);
    final CollectionFilterModel model =
        ref.watch(providers.collectionFilterControllerProvider);

    final CollectionModel collectionModel =
        ref.watch(providers.collectionControllerProvider);

    int _sorting = model.sorting;
    double _value = model.value;
    String _material = model.material;
    String _country = model.country;
    double _weightMin = model.weightMin;
    double _weightMax = model.weightMax;
    int _year = model.year;
    bool _onlyFavorites = model.onlyFavorites;
    DateTime _beforeDate = model.beforeDate;

    bool _materialApplied = model.materialApplied;
    bool _countryApplied = model.countryApplied;
    bool _weightApplied = model.weightApplied;
    bool _yearApplied = model.yearApplied;
    bool _valueApplied = model.valueApplied;
    bool _dateApplied = model.dateApplied;
    DbCollectionModel _collectionData;
    List<DbObjectModel> _filteredObjects;
    String _newCollectionTitle = "";

    ValueSliderWidget _valueSlider = ValueSliderWidget(_value);

    final List<String> _yearList =
        List.generate(300, (index) => (1800 + index).toString());

    //global variables
    const double _titleFontSize = 15;
    const double _defaultSideSize = 30;
    const SizedBox _seperator = SizedBox(height: 5);
    const SizedBox _inbetween = SizedBox(width: 5);
    Widget _sideClearance = const SizedBox(width: 10);

    AlertDialog _createSubcollectionDialog = AlertDialog(
      title: Text(_stringBib.collectionFilter_SubcollectionName),
      content: TextField(
        onChanged: ((value) => _newCollectionTitle = value),
        decoration: InputDecoration(
            hintText: _stringBib.collectionFilter_SubcollectionName),
      ),
      actions: [
        TextButton(
            onPressed: () {
              controller.popDialog(context);
            },
            child: Text(_stringBib.collectionFilter_Cancel)),
        TextButton(
            onPressed: () {
              controller.switchValue(_valueSlider.value);
              controller.switchApplied(true);

              _collectionData = controller.getCollectionData(
                  context, collectionModel, _newCollectionTitle);
              int newId = controller.createCollection(context, _collectionData);
              _filteredObjects = controller
                  .getFilteredObjects(collectionModel.hiveCollectionId);
              controller.insertObjects(_filteredObjects, newId);
              controller.reset();
              // Pop dialog
              controller.popDialog(context);
              // Pop collection-filter site
              Navigator.of(context).pop();
              // Pop collection site
              Navigator.of(context).pop();
              // Load new collection site
              Navigator.pushNamed(context, '/list-collections');
            },
            child: Text(_stringBib.collectionFilter_createCollection)),
      ],
    );

    return Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Expanded(
                child: Container(
                    width: double.infinity,
                    alignment: Alignment.centerRight,
                    child: Text(
                      _stringBib.collectionFilter_appBarTitle,
                    ))),
            Expanded(
                child: Container(
                    width: 20,
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.restore,
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: ListView(
                    padding: const EdgeInsets.all(_defaultSideSize),
                    children: <Widget>[
                  Text(
                    _stringBib.collectionFilter_editFilter,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  _seperator,
                  Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.black,
                            width: 2,
                          )),
                          child: DropdownButton<String>(
                            value:
                                controller.getDropDownString(_sorting, context),
                            onChanged: (String? newValue) {
                              if (newValue ==
                                  _stringBib.collectionFilter_newFirst) {
                                controller.switchSorting(0);
                              } else if (newValue ==
                                  _stringBib.collectionFilter_oldFirst) {
                                controller.switchSorting(1);
                              } else if (newValue ==
                                  _stringBib.collectionFilter_expensiveFirst) {
                                controller.switchSorting(2);
                              } else if (newValue ==
                                  _stringBib.collectionFilter_cheapestFirst) {
                                controller.switchSorting(3);
                              } else {
                                controller.switchSorting(0);
                              }
                            },
                            items: <String>[
                              _stringBib.collectionFilter_newFirst,
                              _stringBib.collectionFilter_oldFirst,
                              _stringBib.collectionFilter_expensiveFirst,
                              _stringBib.collectionFilter_cheapestFirst,
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )),
                    ],
                  ),
                  Row(children: [
                    Expanded(
                      child: Text(_stringBib.collectionFilter_onlyFavourites),
                    ),
                    Checkbox(
                        value: _onlyFavorites,
                        onChanged: (newValue) {
                          controller.switchFavourite();
                        }),
                  ]),
                  Row(children: [
                    Expanded(
                      child: Column(children: [
                        Text(_stringBib.collectionFilter_minValue),
                        _valueSlider
                      ]),
                    ),
                    Checkbox(
                        value: _valueApplied,
                        onChanged: (newValue) {
                          controller.switchValue(_valueSlider.value);
                          controller.switchValueApplied();
                        }),
                  ]),
                  Row(
                    children: [
                      Text(_stringBib.collectionFilter_beforeDate),
                      const Spacer(),
                      Text(
                          '${_beforeDate.day}/${_beforeDate.month}/${_beforeDate.year}'),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              DateTime? newDate = await showDatePicker(
                                  context: context,
                                  initialDate: _beforeDate,
                                  firstDate: DateTime(0),
                                  lastDate: DateTime(2100));
                              if (newDate != null) {
                                controller.switchDate(newDate);
                              }
                            },
                            icon: const Icon(Icons.date_range, size: 30),
                            label: Text(_stringBib.collectionFilter_selectDate,
                                style:
                                    const TextStyle(fontSize: _titleFontSize)),
                          ),
                        ),
                      ),
                      Checkbox(
                          value: _dateApplied,
                          onChanged: (newValue) {
                            controller.switchDateApplied();
                          }),
                    ],
                  ),
                  _seperator,
                  Text(_stringBib.collectionFilter_material),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: '',
                            border: OutlineInputBorder(),
                          ),
                          initialValue: _material,
                          onChanged: (newValue) =>
                              controller.switchMaterial(newValue),
                        ),
                      ),
                      Checkbox(
                          value: _materialApplied,
                          onChanged: (newValue) {
                            controller.switchMaterialApplied();
                          }),
                    ],
                  ),
                  _seperator,
                  Text(_stringBib.collectionFilter_country),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: '',
                            border: OutlineInputBorder(),
                          ),
                          initialValue: _country,
                          onChanged: (newValue) =>
                              controller.switchCountry(newValue),
                        ),
                      ),
                      Checkbox(
                          value: _countryApplied,
                          onChanged: (newValue) {
                            controller.switchCountryApplied();
                          }),
                    ],
                  ),
                  _seperator,
                  Text(_stringBib.collectionFilter_weight),
                  _seperator,
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9.]')),
                            ],
                            decoration: const InputDecoration(
                              labelText: '',
                              border: OutlineInputBorder(),
                            ),
                            initialValue: _weightMin.toString(),
                            onChanged: (newValue) {
                              try {
                                controller.switchWeight(
                                    double.parse(newValue), _weightMax);
                              } catch (_) {}
                            }),
                      ),
                      _inbetween,
                      Text(_stringBib.collectionFilter_kgUntil),
                      Expanded(
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9.]')),
                            ],
                            decoration: const InputDecoration(
                              labelText: '',
                              border: OutlineInputBorder(),
                            ),
                            initialValue: _weightMax.toString(),
                            onChanged: (newValue) {
                              try {
                                controller.switchWeight(
                                    _weightMin, double.parse(newValue));
                              } catch (_) {}
                            }),
                      ),
                      _inbetween,
                      Text(_stringBib.collectionFilter_kg),
                      Checkbox(
                          value: _weightApplied,
                          onChanged: (newValue) {
                            controller.switchWeightApplied();
                          }),
                    ],
                  ),
                  _seperator,
                  Text(_stringBib.collectionFilter_year),
                  Row(
                    children: [
                      DropdownButton<String>(
                        value: _year.toString(),
                        onChanged: (String? newValue) {
                          controller.switchYear(int.parse(newValue!));
                        },
                        items: _yearList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const Spacer(),
                      Checkbox(
                        value: _yearApplied,
                        onChanged: (newValue) {
                          controller.switchYearApplied();
                        },
                      ),
                    ],
                  ),
                ])),
            Row(
              children: [
                _sideClearance,
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
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
                              child: _createSubcollectionDialog,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 300),
                        );
                      },
                      child: Text(_stringBib.collectionFilter_createCollection,
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
                        controller.switchValue(_valueSlider.value);
                        controller.switchApplied(true);
                        Navigator.of(context)
                          ..pop()
                          ..pop();
                        Navigator.pushNamed(context, '/collection');
                      },
                      child: Text(_stringBib.collectionFilter_useFilter,
                          style: const TextStyle(fontSize: 24)),
                    ),
                  ),
                ),
                _sideClearance
              ],
            ),
          ],
        ),
        bottomNavigationBar: const CtNavigationBar(1));
  }
}

abstract class CollectionFilterController
    extends StateNotifier<CollectionFilterModel> {
  CollectionFilterController(CollectionFilterModel state) : super(state);
  void navigate(BuildContext context, int value);
  DbCollectionModel getCollectionData(BuildContext context,
      CollectionModel collectionModel, String newCollectionTitle);
  int createCollection(context, DbCollectionModel collectionModel);
  List<DbObjectModel> getFilteredObjects(int collectionId);
  void insertObjects(List<DbObjectModel> filteredObjects, int newId);
  void switchMaterial(String material);
  void switchCountry(String country);
  void switchSorting(int sort);
  void switchValue(double value);
  void switchWeight(double min, double max);
  void switchCondition(int min, int max);
  void switchYear(int year);
  void switchDate(DateTime dateTime);
  void switchFavourite();
  void switchApplied(bool applied);
  void switchValueApplied();
  void switchMaterialApplied();
  void switchCountryApplied();
  void switchWeightApplied();
  void switchYearApplied();
  void switchDateApplied();
  String getDropDownString(int value, BuildContext context);
  void reset();
  void popDialog(BuildContext context);
}
