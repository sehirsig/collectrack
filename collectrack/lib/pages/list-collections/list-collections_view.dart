import 'package:collectrack/ui-kit/hive/collection/dbcollection.dart';
import 'package:collectrack/ui-kit/hive/collection/dbcollection_model.dart';
import 'package:collectrack/ui-kit/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collectrack/common/providers.dart';
import 'package:collectrack/pages/list-collections/list-collections_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListCollectionsView extends ConsumerWidget {
  const ListCollectionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations _stringBib = AppLocalizations.of(context)!;
    final ListCollectionsController controller =
        ref.read(providers.listCollectionsControllerProvider.notifier);
    final ListCollectionsModel model =
        ref.watch(providers.listCollectionsControllerProvider);

    List<DbCollectionModel> _listDbCollection = controller.getCollections();
    String _filterText = model.filterText;

    //global variables
    const double _textFontSize = 12;
    const double _titleFontSize = 15;
    const SizedBox _defaultSideBox = SizedBox(width: 30);
    const SizedBox _seperator = SizedBox(height: 5);

    Container _dialogBorder = Container(
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

    SimpleDialog _saveDialog = SimpleDialog(
        title: Text(_stringBib.collectionsList_appBarTitle),
        children: [
          _dialogBorder,
          SimpleDialogOption(
            onPressed: () async {
              String result = await controller.saveDatabase(context);
              if (result != "") {
                showGeneralDialog(
                  context: context,
                  pageBuilder: (ctx, anim1, anim2) {
                    return Container();
                  },
                  transitionBuilder: (ctx, anim1, anim2, child) {
                    double curve = Curves.easeInOut.transform(anim1.value);
                    return Transform.scale(
                      scale: curve,
                      child: AlertDialog(
                        title:
                            Text(_stringBib.collectionsList_backUpErrorTitle),
                        content: Text(result),
                        actions: [
                          TextButton(
                            child:
                                Text(_stringBib.collectionsList_backUpErrorOk),
                            onPressed: () {
                              controller.popDialog(context);
                            },
                          )
                        ],
                      ),
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                );
              } else {
                controller.popDialog(context);
              }
            },
            child: Row(children: [
              const Icon(Icons.file_copy),
              Text(_stringBib.collectionsList_saveLocal,
                  style: const TextStyle(fontSize: _titleFontSize),
                  textAlign: TextAlign.left),
            ]),
          ),
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
          SimpleDialogOption(
            onPressed: () async {
              try {
                String result = await controller.loadDatabase(context);
                controller.popDialog(context);
                if (result != "") {
                  showGeneralDialog(
                    context: context,
                    pageBuilder: (ctx, anim1, anim2) {
                      return Container();
                    },
                    transitionBuilder: (ctx, anim1, anim2, child) {
                      double curve = Curves.easeInOut.transform(anim1.value);
                      return Transform.scale(
                        scale: curve,
                        child: AlertDialog(
                          title:
                              Text(_stringBib.collectionsList_backUpErrorTitle),
                          content: Text(result),
                          actions: [
                            TextButton(
                              child: Text(
                                  _stringBib.collectionsList_backUpErrorOk),
                              onPressed: () {
                                controller.popDialog(context);
                              },
                            )
                          ],
                        ),
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 300),
                  );
                }
                await Future.delayed(const Duration(
                    milliseconds: 50)); // Wait for new data to load
                controller.navigate(context, 1);
              } catch (_) {}
            },
            child: Row(children: [
              const Icon(Icons.file_copy),
              Text(_stringBib.collectionsList_getLocal,
                  style: const TextStyle(fontSize: _titleFontSize),
                  textAlign: TextAlign.left),
            ]),
          ),
          _dialogBorder,
          SimpleDialogOption(
            onPressed: () async {
              controller.popDialog(context);
            },
            child: Text(_stringBib.collectionsList_saveClose,
                style: const TextStyle(fontSize: _textFontSize),
                textAlign: TextAlign.right),
          ),
        ]);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            _stringBib.collectionsList_appBarTitle,
          ),
          leading: Image.asset(
            'assets/images/small_logo.png',
            width: 256,
            height: 256,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                            labelText: _stringBib.collectionsList_filter,
                          ),
                          initialValue: _filterText,
                          onChanged: (newValue) =>
                              controller.switchFilterText(newValue),
                        )),
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
                  child: ListView.separated(
                    itemCount: _listDbCollection.length,
                    itemBuilder: (_, int index) =>
                        DbCollection(_listDbCollection[index]),
                    separatorBuilder: (_, int index) => const Divider(
                      indent: 8,
                      endIndent: 8,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
                      try {
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
                              child: _saveDialog,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 300),
                        );
                      } catch (_) {}
                    },
                    child:
                        const Icon(Icons.save, size: 40, color: Colors.white),
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

abstract class ListCollectionsController
    extends StateNotifier<ListCollectionsModel> {
  ListCollectionsController(ListCollectionsModel state) : super(state);
  void navigate(BuildContext context, int value);
  List<DbCollectionModel> getCollections();
  void deleteCollectionId(int id);
  void deleteAllCollections();
  void switchFilterText(String filterText);
  Future<String> saveDatabase(BuildContext context);
  Future<String> loadDatabase(BuildContext context);
  void popDialog(BuildContext context);
}
