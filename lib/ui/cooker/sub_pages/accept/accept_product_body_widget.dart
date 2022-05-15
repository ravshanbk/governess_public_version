import 'package:flutter/material.dart';
import 'package:governess/consts/decorations.dart';
import 'package:governess/consts/print_my.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/models/cooker/receive_product_model.dart';
import 'package:governess/models/cooker/to_accept_product_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/providers/cooker/accept_product_provider.dart';
import 'package:governess/services/cooker_service.dart';
import 'package:governess/services/network.dart';
import 'package:governess/ui/widgets/cooker_show_product_expansion_tile_widget.dart';
import 'package:governess/ui/widgets/send_button_widger.dart.dart';
import 'package:provider/provider.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class AcceptProductBodyWidget extends StatefulWidget {
  final List<CookerProduct> data;
  const AcceptProductBodyWidget({required this.data, Key? key})
      : super(key: key);

  @override
  State<AcceptProductBodyWidget> createState() =>
      _AcceptProductBodyWidgetState();
}

class _AcceptProductBodyWidgetState extends State<AcceptProductBodyWidget> {
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
    p("vfasdfasdfasd");
    return Scaffold(
      body: FloatingSearchBar(
        body: FloatingSearchBarScrollNotifier(
          child: _body(
            dataa: filteredSearchResult,
            context: context,
          ),
        ),
        transition: CircularFloatingSearchBarTransition(),
        physics: const BouncingScrollPhysics(),
        title: Text(
          selectedTerm ?? "The Search App",
          style: Theme.of(context).textTheme.headline6,
        ),
        hint: "Search And find Out...",
        actions: [FloatingSearchBarAction.searchToClear()],
        onQueryChanged: (query) {
          p("change");
          setState(
            () {
              filteredSearchHistory = filterSearchTerms(filter: query);
            },
          );
        },
        onSubmitted: (query) {
          p("submit");
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
              color: Colors.white,
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
                        p("152 / filteredSearchHistory.isEmpty:");
                        setState(
                          () {
                            p(controller!.query);
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
                                  p("176 / Columnning ichidagi ListTilening ichidagi IconButton / Clear:");

                                  setState(
                                    () {
                                      deleteSearchTerm(term);
                                    },
                                  );
                                },
                              ),
                              onTap: () {
                                p("176 / Columnning ichidagi ListTile:");
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
      ),
    );
  }

  _body({required BuildContext context, required List<CookerProduct> dataa}) {
    if (dataa.isNotEmpty) {
      return ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding:
            EdgeInsets.only(left: gW(20.0), right: gW(20.0), top: gH(70.0)),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: gW(20.0)),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: mainColor,
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
              onPressed: () async {
                bool isNet = await checkConnectivity();
                if (isNet) {
                  Provider.of<CookerAcceptProductProvider>(context,
                          listen: false)
                      .clear();
                  Provider.of<CookerAcceptProductProvider>(context,
                          listen: false)
                      .initNumberController(data.numberPack!.toString());
                  _shownputDialog(context, data);
                } else {
                  showNoNetToast(false);
                }
              },
              child: const Text("Qabul qilish"),
            ),
          ),
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

  _shownputDialog(BuildContext context, CookerProduct product) {
    return showDialog(
      context: context,
      builder: (context) {
        return _AcceptProductDialogContentWidget(
          data: product,
          toSetState: () {
            p("SetStated:::");
            setState(() {});
          },
        );
      },
    );
  }

  Divider _divider() => Divider(
        color: mainColor,
        indent: gW(15.0),
        endIndent: gW(15.0),
      );
}

class _AcceptProductDialogContentWidget extends StatelessWidget {
  final CookerProduct data;
  final VoidCallback toSetState;
  const _AcceptProductDialogContentWidget(
      {required this.toSetState, required this.data, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: gW(20.0), vertical: gH(15)),
        margin: EdgeInsets.only(
          top: gH(0.0),
          left: gW(10.0),
          right: gW(10.0),
          bottom: gH(340.0),
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(color: greyColor),
          borderRadius: BorderRadius.circular(
            gW(10.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _richTextInRow(["Nomi:  ", data.productName!.toString()]),
            _richTextInRow(["Yaxlitlash miqdaori:  ", data.pack.toString()]),
            _richTextInRow(["Nechta:  ", data.numberPack.toString()]),
            _richTextInRow(["Umumiy:  ", data.weightPack.toString()]),
            const Spacer(),
            _numberInputField(context, data),
            // const Spacer(),
            // _priceInputField(context),
            const Spacer(),
            _commentInputField(context),
            const Spacer(),
            _acceptButtonInShowDialog(context, data),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  RichText _richTextInRow(List<String> text) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text[0],
            style: TextStyle(color: greyColor, fontSize: gW(14.0)),
          ),
          TextSpan(
            text: text[1].length > 17 ? text[1].substring(0, 16) : text[1],
            style: TextStyle(color: Colors.black, fontSize: gW(18.0)),
          ),
        ],
      ),
    );
  }

  SendButtonWidget _acceptButtonInShowDialog(
      BuildContext con, CookerProduct data) {
    return SendButtonWidget(
      width: gW(200.0),
      onPressed: () async {
        bool isNet = await checkConnectivity();
        if (isNet) {
          if (Provider.of<CookerAcceptProductProvider>(con, listen: false)
              .numberController
              .text
              .isNotEmpty) {
            double number = (double.parse(
                    Provider.of<CookerAcceptProductProvider>(con, listen: false)
                        .numberController
                        .text) *
                (data.pack! > 0 ? data.pack! : 1));
            CookerService()
                .acceptProduct(
              id: data.id!,
              data: ReceiveProductModel(
                comment:
                    Provider.of<CookerAcceptProductProvider>(con, listen: false)
                        .commentController
                        .text,
                numberPack: double.parse(
                    Provider.of<CookerAcceptProductProvider>(con, listen: false)
                        .numberController
                        .text),
                weightPack: number,
              ),
            )
                .then((value) {
              if (value.success!) {
                showToast(value.text!.toString(), value.success!, false);
                toSetState();

                Provider.of<CookerAcceptProductProvider>(con, listen: false)
                    .changeCurrent(-1);
                Navigator.pop(con);
              } else {
                toSetState();

                showToast(value.text!.toString(), value.success!, false);
                Navigator.pop(con);
              }
            });
          } else {
            toSetState();

            showToast("Miqdorni kiriting, nol bolmasin", false, false);
          }
        } else {
          showNoNetToast(false);
        }
      },
      titleOfButton: "Qabul Qilish",
    );
  }

  _numberInputField(BuildContext context, CookerProduct data) {
    return TextFormField(
      onChanged: (v) {
        if (double.parse(v) > data.numberPack!) {
          showToast(
              "Kiritilgan miqdor keraklisidan oshmasligi kerak", false, false);
          Provider.of<CookerAcceptProductProvider>(context, listen: false)
              .clearNumberController();
        }
      },
      keyboardType: TextInputType.number,
      controller: context.read<CookerAcceptProductProvider>().numberController,
      decoration: DecorationMy.inputDecoration(
        "Miqdor...",
        null,
      ),
    );
  }

  TextField _commentInputField(BuildContext context) {
    return TextField(
      onChanged: (v) {},
      keyboardType: TextInputType.text,
      controller: context.read<CookerAcceptProductProvider>().commentController,
      decoration: DecorationMy.inputDecoration(
        "Izoh...",
        null,
      ),
    );
  }
}
