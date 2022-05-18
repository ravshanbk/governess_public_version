import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/cooker/to_accept_product_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/providers/cooker/accept_product_provider.dart';
import 'package:governess/ui/widgets/cooker_show_product_expansion_tile_widget.dart';
import 'package:provider/provider.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class AcceptProductArxivBodyWidget extends StatefulWidget {
  final List<CookerProduct> data;
  const AcceptProductArxivBodyWidget({required this.data, Key? key})
      : super(key: key);

  @override
  State<AcceptProductArxivBodyWidget> createState() =>
      _AcceptProductArxivBodyWidgetState();
}

class _AcceptProductArxivBodyWidgetState extends State<AcceptProductArxivBodyWidget> {
  static const historyLength = 5;
  List<String> _searchHistory = [];
  List<CookerProduct> filteredSearchResult = [];

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

  List<String> names(List<CookerProduct> data) {
    List<String> a = data.map((e) => e.productName!).toList();
    a.removeRange(0, a.length - historyLength);
    return a;
  }

  void extractResult(String filter) {
    List<CookerProduct> a = [];
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

  FloatingSearchBarController? controller;
  @override
  void initState() {
    super.initState();

    controller = FloatingSearchBarController();
    filteredSearchResult = widget.data;
    _searchHistory = names(widget.data);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
    
      controller: controller,
      body: FloatingSearchBarScrollNotifier(
        child: _body(
          dataa: filteredSearchResult,
          context: context,
        ),
      ),
      transition: CircularFloatingSearchBarTransition(),
      physics: const NeverScrollableScrollPhysics(),
      isScrollControlled: false,
      title: Text(
        selectedTerm ?? "The Search App",
        style: Theme.of(context).textTheme.headline6,
      ),
      hint: "Search And find Out...",
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
        controller!.close();
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
                    controller!.query.isEmpty) {
                  return Container(
                    height: gH(52.0),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      "Start Searching",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  );
                } else if (filteredSearchHistory!.isEmpty) {
                  return ListTile(
                    title: Text(controller!.query),
                    leading: const Icon(Icons.search),
                    onTap: () {
                      setState(
                        () {
                          addSearchTerm(controller!.query);
                          selectedTerm = controller!.query;
                        },
                      );

                      controller!.close();
                      controller!.hide();
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
                                  extractResult(term);
                                  putSearchTermFirst(term);
                                  selectedTerm = term;
                                },
                              );
                              controller!.close();
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
    );
  }

  _body({required BuildContext context, required List<CookerProduct> dataa}) {
    if (dataa.isNotEmpty) {
      return ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: gH(70.0)),
        itemBuilder: (_, __) {
          return CookerShowProductExpansionTileWidget(
            key: Key("$__ CookerAcceptProductPage"),
            isExpanded:
                context.watch<CookerAcceptProductProvider>().current == __,
            children: _children(dataa[__], context),
            onChanged: (bool v) {
              if (v) {
                Provider.of<CookerAcceptProductProvider>(context, listen: false)
                    .changeCurrent(__);
              } else {
                Provider.of<CookerAcceptProductProvider>(context, listen: false)
                    .changeCurrent(-1);
              }
            },
            data: dataa[__],
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: gH(20.0),
          );
        },
        itemCount: dataa.length,
      );
    }
    return Center(
      child: Column(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                filteredSearchResult = widget.data;
              });
            },
            icon: const Icon(Icons.refresh),
          ),
          const Text("Topilmadi")
        ],
      ),
    );
  }

  List<Widget> _children(CookerProduct data, BuildContext context) {
    return <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         
          SizedBox(height: gH(10.0)),
          _textInRow("Korxona nomi", data.senderName.toString()),
          _divider(),
          _textInRow("Yuborilgan Sana",
              data.enterDate == null ? "null" : DTFM.maker(data.enterDate!)),
          _divider(),
          _textInRow("O'lchov birligi", data.measurementType.toString()),
          _divider(),
          _textInRow("Yaxlitlash miqdori", data.pack.toString()),
          _divider(),
          _textInRow("Qadoqlar soni", data.numberPack.toString()),
          _divider(),
          _textInRow("Qadoqlangandan so'ng (miq)", data.weightPack.toString()),
          _divider(),
          SizedBox(
            height: gH(10.0),
          ),
        ],
      )
    ];
  }

  _textInRow(String title, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: gW(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title:",
            style: TextStyle(
              color: greyColor,
              fontSize: gW(14.0),
            ),
          ),
          Text(
            text.length > 18 ? text.substring(0, 17) : text,
            style: TextStyle(
              color: Colors.black,
              fontSize: gW(18.0),
            ),
          ),
        ],
      ),
    );
  }

 

  Divider _divider() => Divider(
        color: mainColor,
        indent: gW(15.0),
        endIndent: gW(15.0),
      );
}

