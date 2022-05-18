import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/cooker/product_cooker_product.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/providers/cooker/show_in_out_list_product_provider.dart';
import 'package:governess/ui/widgets/show_in_out_list_product_widget.dart';
import 'package:governess/ui/widgets/text_in_row_widget.dart';
import 'package:provider/provider.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class CookerInStorageSearchPage extends StatefulWidget {
  final List<CookerInOutListProduct> data;
  const CookerInStorageSearchPage({required this.data, Key? key})
      : super(key: key);

  @override
  State<CookerInStorageSearchPage> createState() =>
      _CookerInStorageSearchPageState();
}

class _CookerInStorageSearchPageState extends State<CookerInStorageSearchPage> {
  static const historyLength = 5;
  List<String> _searchHistory = [];
  List<CookerInOutListProduct> filteredSearchResult = [];

  List<String>? filteredSearchHistory;

  String? selectedTerm;

  List<String>? filterSearchTerms({String? filter}) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);

      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }

    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  List<String> names(List<CookerInOutListProduct> data) {
    List<String> a = data.map((e) => e.productName!).toList();
    a.removeRange(0, a.length - historyLength);
    return a;
  }

  void extractResult(String filter) {
    List<CookerInOutListProduct> a = [];
    if (filter.isNotEmpty) {
      for (int i = 0; i < widget.data.length; i++) {
        if (widget.data[i].productName!.startsWith(filter)) {
          a.add(widget.data[i]);
        }
      }
    }

    filteredSearchResult = a;
    setState(() {});
  }

  FloatingSearchBarController? controller1 = FloatingSearchBarController();
  @override
  void initState() {
    super.initState();

    filteredSearchResult = widget.data;
    _searchHistory = names(widget.data);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  @override
  void dispose() {
    controller1!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FloatingSearchBar(
        controller: controller1,
        body: FloatingSearchBarScrollNotifier(
          child:Container(color: Colors.red,child: const Text("Column"),),
          //  _body(
          //   context: context,
          //   data: filteredSearchResult,
          // ),
        ),
        transition: CircularFloatingSearchBarTransition(),
        physics: const BouncingScrollPhysics(),
        title: Text(
          selectedTerm ?? "Qidirish..",
          style: Theme.of(context).textTheme.headline6,
        ),
        hint: "Qidiruv...",
        actions: [FloatingSearchBarAction.searchToClear()],
        onQueryChanged: (query) {
          setState(
            () {
              filteredSearchHistory = filterSearchTerms(filter: query);
            },
          );
        },
        onSubmitted: (query) {
          setState(
            () {
              addSearchTerm(query);
              selectedTerm = query;
            },
          );
          controller1!.close();
        },
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(
              gW(8.0),
            ),
            child: Material(
              color: whiteColor,
              elevation: 4,
              child: Builder(
                builder: (context) {
                  if (filteredSearchHistory!.isEmpty &&
                      controller1!.query.isEmpty) {
                    return Container(
                      height: gH(52.0),
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        "Qidiruvni boshlash...",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    );
                  } else if (filteredSearchHistory!.isEmpty) {
                    return ListTile(
                      title: Text(controller1!.query),
                      leading: const Icon(Icons.search),
                      onTap: () {
                        setState(
                          () {
                            addSearchTerm(controller1!.query);
                            selectedTerm = controller1!.query;
                          },
                        );

                        controller1!.close();
                        controller1!.hide();
                      },
                    );
                  } else {
                    return Column(
                      children: filteredSearchHistory!
                          .map(
                            (term) => ListTile(
                              title: Text(
                                term,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading: const Icon(Icons.history),
                              trailing: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(
                                    () {
                                      deleteSearchTerm(term);
                                    },
                                  );
                                },
                              ),
                              onTap: () {
                                setState(
                                  () {
                                    Provider.of<ShowInOutListProductProvider>(
                                            context,
                                            listen: false)
                                        .changeCurrent(-1);
                                    extractResult(term);
                                    putSearchTermFirst(term);
                                    selectedTerm = term;
                                  },
                                );
                                controller1!.close();
                              },
                            ),
                          )
                          .toList(),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  ListView _body(
      {required BuildContext context,
      required List<CookerInOutListProduct> data}) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: gH(70.0), left: gW(20.0), right: gW(20.0)),
      itemBuilder: (_, __) {
        return ShowInOutListProductWidget(
          onChanged: (bool v) {
            if (v) {
              Provider.of<ShowInOutListProductProvider>(context, listen: false)
                  .changeCurrent(__);
            } else {
              Provider.of<ShowInOutListProductProvider>(context, listen: false)
                  .changeCurrent(-1);
            }
          },
          data: data[__],
          isExpanded:
              context.watch<ShowInOutListProductProvider>().current == __,
          children: List.generate(
            data[__].inOutList!.length,
            (index) => Card(
              child: ExpansionTile(
                key: Key("key $index"),
                collapsedIconColor: Colors.transparent,
                iconColor: Colors.transparent,
                textColor: Colors.black,
                collapsedBackgroundColor: mainColor_02,
                title: Text(
                  DTFM.maker(data[__].inOutList![index].enterDate),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: gW(20.0), fontStyle: FontStyle.italic),
                ),
                children: [
                  _divider(),
                  TextInRowWidget(
                      "O'lchov birligi", data[__].inOutList!.length.toString()),
                  _divider(),
                  TextInRowWidget("EnterDate",
                      DTFM.maker(data[__].inOutList![index].enterDate!)),
                  _divider(),
                  TextInRowWidget(
                      "Mahsulot Id", data[__].inOutList![index].id.toString()),
                  _divider(),
                  TextInRowWidget("Nechta",
                      data[__].inOutList![index].numberPack.toString()),
                  _divider(),
                  TextInRowWidget("Yaxlitlash miqdori",
                      data[__].inOutList![index].pack.toString()),
                  _divider(),
                  TextInRowWidget(
                      "Narxi", data[__].inOutList![index].price.toString()),
                  _divider(),
                  TextInRowWidget("Umumiy miqdor",
                      data[__].inOutList![index].weightPack.toString()),
                  _divider(),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: gH(20.0));
      },
      itemCount: data.length,
    );
  }

  Divider _divider() => Divider(
        color: mainColor,
        indent: gW(15.0),
        endIndent: gW(15.0),
      );
}
