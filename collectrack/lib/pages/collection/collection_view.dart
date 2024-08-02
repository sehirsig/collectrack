import 'package:collectrack/pages/object-create/object-create_view.dart';
import 'package:collectrack/ui-kit/hive/object/dbobject.dart';
import 'package:collectrack/ui-kit/hive/object/dbobject_model.dart';
import 'package:collectrack/ui-kit/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collectrack/common/providers.dart';
import 'package:collectrack/pages/collection/collection_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CollectionView extends ConsumerWidget {
  const CollectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations _stringBib = AppLocalizations.of(context)!;
    final CollectionController controller =
        ref.read(providers.collectionControllerProvider.notifier);
    final CollectionModel model =
        ref.watch(providers.collectionControllerProvider);
    final ObjectCreateController oCController =
        ref.read(providers.objectCreateControllerProvider.notifier);

    List<DbObjectModel> _listDbObjects = controller.getHiveObjects(
        model.hiveCollectionId, ref, model.filterText);

    String _value = _stringBib
        .collection_value(controller.computeValue(model.hiveCollectionId));
    String _count = _stringBib
        .collection_count(controller.computeCount(model.hiveCollectionId));
    int _hiveCollectionId = model.hiveCollectionId;
    String _title = model.title;
    String _description = model.description;
    String _image = model.image;
    bool _condition = model.condition;
    bool _material = model.material;
    bool _country = model.country;
    bool _weight = model.weight;
    bool _year = model.year;
    String _filterText = model.filterText;

    //global variables
    const double _textFontSize = 12;
    const double _titleFontSize = 15;
    const double _buttonFontSize = 15;
    const SizedBox _defaultSideBox = SizedBox(width: 30);
    const SizedBox _seperator = SizedBox(height: 5);
    const SizedBox _inbetween = SizedBox(width: 5);

    Container _thickBorder = Container(
        alignment: Alignment.center,
        height: 2,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: const BorderRadius.horizontal(),
        ),
        child: null);

    SimpleDialog _moreInfoDialog =
        SimpleDialog(title: Text(_stringBib.collection_moreInfoBig), children: [
      Row(children: [
        _defaultSideBox,
        Expanded(
          child: Text(_stringBib.collection_description,
              style: const TextStyle(fontSize: _titleFontSize)),
        ),
        _defaultSideBox
      ]),
      Row(children: [
        _defaultSideBox,
        Expanded(
          child: Text(_description,
              style: const TextStyle(fontSize: _textFontSize)),
        ),
        _defaultSideBox
      ]),
      Row(children: [
        _defaultSideBox,
        Expanded(
          child: Text(_stringBib.collection_condition,
              style: const TextStyle(fontSize: _titleFontSize)),
        ),
        _defaultSideBox
      ]),
      Row(children: [
        _defaultSideBox,
        Expanded(
          child: Text("$_condition",
              style: const TextStyle(fontSize: _textFontSize)),
        ),
        _defaultSideBox
      ]),
      Row(children: [
        _defaultSideBox,
        Expanded(
          child: Text(_stringBib.collection_material,
              style: const TextStyle(fontSize: _titleFontSize)),
        ),
        _defaultSideBox
      ]),
      Row(children: [
        _defaultSideBox,
        Expanded(
          child: Text("$_material",
              style: const TextStyle(fontSize: _textFontSize)),
        ),
        _defaultSideBox
      ]),
      Row(children: [
        _defaultSideBox,
        Expanded(
          child: Text(_stringBib.collection_country,
              style: const TextStyle(fontSize: _titleFontSize)),
        ),
        _defaultSideBox
      ]),
      Row(children: [
        _defaultSideBox,
        Expanded(
          child: Text("$_country",
              style: const TextStyle(fontSize: _textFontSize)),
        ),
        _defaultSideBox
      ]),
      Row(children: [
        _defaultSideBox,
        Expanded(
          child: Text(_stringBib.collection_weight,
              style: const TextStyle(fontSize: _titleFontSize)),
        ),
        _defaultSideBox
      ]),
      Row(children: [
        _defaultSideBox,
        Expanded(
          child:
              Text("$_weight", style: const TextStyle(fontSize: _textFontSize)),
        ),
        _defaultSideBox
      ]),
      Row(children: [
        _defaultSideBox,
        Expanded(
          child: Text(_stringBib.collection_year,
              style: const TextStyle(fontSize: _titleFontSize)),
        ),
        _defaultSideBox
      ]),
      Row(children: [
        _defaultSideBox,
        Expanded(
          child:
              Text("$_year", style: const TextStyle(fontSize: _textFontSize)),
        ),
        _defaultSideBox
      ]),
      Row(children: [
        _defaultSideBox,
        Expanded(
          child: Text(_stringBib.collection_picture,
              style: const TextStyle(fontSize: _titleFontSize)),
        ),
        _defaultSideBox
      ]),
      Row(children: [
        _defaultSideBox,
        Expanded(
          child: Text((_image == "") ? "false" : "true",
              style: const TextStyle(fontSize: _textFontSize)),
        ),
        _defaultSideBox
      ]),
      SimpleDialogOption(
        onPressed: () async {
          controller.popDialog(context);
        },
        child: Text(_stringBib.collection_socialClose,
            style: const TextStyle(fontSize: _titleFontSize),
            textAlign: TextAlign.right),
      ),
    ]);

    SimpleDialog _shareDialog =
        SimpleDialog(title: Text(_stringBib.collection_socialTitle), children: [
      SimpleDialogOption(
        onPressed: () async {
          controller.shareOthers(context);
          controller.popDialog(context);
        },
        child: Row(children: [
          const Icon(Icons.share),
          Text(_stringBib.collection_socialShare,
              style: const TextStyle(fontSize: _titleFontSize),
              textAlign: TextAlign.left),
        ]),
      ),
      SimpleDialogOption(
        onPressed: () async {
          controller.popDialog(context);
        },
        child: Text(_stringBib.collection_socialClose,
            style: const TextStyle(fontSize: _textFontSize),
            textAlign: TextAlign.right),
      ),
    ]);

    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
          centerTitle: true,
        ),
        body: Column(
          children: [
            _seperator,
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
                      child:
                          Text(_title, style: const TextStyle(fontSize: 18))),
                )
              ],
            ),
            _thickBorder,
            _seperator,
            Row(
              children: [
                _defaultSideBox,
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: const BorderRadius.horizontal(),
                  ),
                  child: Column(
                    children: [
                      Text(_value, style: const TextStyle(fontSize: 18)),
                      Text(_count, style: const TextStyle(fontSize: 18))
                    ],
                  ),
                )),
                _inbetween,
                SizedBox(
                  width: 100,
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
                            child: _moreInfoDialog,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 300),
                      );
                    },
                    child: Text(_stringBib.collection_moreInfoSmall,
                        style: const TextStyle(fontSize: _buttonFontSize)),
                  ),
                ),
                _defaultSideBox,
              ],
            ),
            _seperator,
            _thickBorder,
            _seperator,
            Row(
              children: [
                _defaultSideBox,
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.search),
                        labelText: _stringBib.collection_filterSearch,
                      ),
                      initialValue: _filterText,
                      onChanged: (newValue) =>
                          controller.switchFilterText(newValue),
                    ),
                  ),
                ),
                _inbetween,
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.navigate(context, 3);
                    },
                    child: Text(_stringBib.collection_filter,
                        style: const TextStyle(fontSize: _buttonFontSize)),
                  ),
                ),
                _defaultSideBox,
              ],
            ),
            _seperator,
            Container(
                alignment: Alignment.center,
                height: 4,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: const BorderRadius.horizontal(),
                ),
                child: null),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: _listDbObjects.isNotEmpty
                  ? ListView.separated(
                      itemCount: controller
                          .getHiveObjects(_hiveCollectionId, ref, _filterText)
                          .length,
                      itemBuilder: (_, int index) =>
                          DbObject(_listDbObjects[index]),
                      separatorBuilder: (_, int index) => const Divider(
                        indent: 8,
                        endIndent: 8,
                        color: Colors.grey,
                      ),
                    )
                  : Text(_stringBib.collection_empty),
            )),
          ],
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            Align(
              alignment: const Alignment(-0.8, 1.0),
              child: SizedBox(
                width: 75,
                height: 75,
                child: FittedBox(
                  child: FloatingActionButton(
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
                            child: _shareDialog,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 300),
                      );
                    },
                    child:
                        const Icon(Icons.share, size: 40, color: Colors.white),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: 75,
                height: 75,
                child: FittedBox(
                  child: FloatingActionButton(
                    onPressed: () {
                      oCController.switchCollectionId(_hiveCollectionId);
                      controller.navigate(context, 4);
                    },
                    child: const Icon(Icons.add, size: 50, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const CtNavigationBar(1));
  }
}

abstract class CollectionController extends StateNotifier<CollectionModel> {
  CollectionController(CollectionModel state) : super(state);
  void navigate(BuildContext context, int value);
  void reset();
  List<DbObjectModel> getHiveObjects(
      int collectionId, WidgetRef ref, String textFilterString);
  void updateHiveId(int collectionId);
  void deleteAllObjects(int collectionId);
  void deleteCollection(int collectionId);
  String computeValue(int collectionId);
  String computeCount(int collectionId);
  void getCollection(int collectionId, WidgetRef ref);
  void switchFilterText(String filterText);
  void shareOthers(BuildContext context);
  void popDialog(BuildContext context);
}
