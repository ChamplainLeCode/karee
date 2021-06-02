import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../constances/library.dart' show KareeConstants, KareeInstanceProfile;
import '../errors/errors_solutions.dart';
import '../routes/router.dart';
import '../screens/screens.dart';
import '../widgets/karee_material_app.dart';
import '../widgets/karee_router_default_error_widget.dart';
import './library.dart' show StatefulScreen, ScreenState;

class KareeRouterErrorWidget extends StatefulScreen {
  final String? _title;
  final StackTrace? _stack;
  final List<String>? env;
  final KareeErrorCode? errorCode;

  KareeRouterErrorWidget([this._title, this._stack, this.errorCode, this.env]);
  @override
  _KareeRouterErrorWidgetState createState() =>
      _KareeRouterErrorWidgetState(this._title, this._stack, this.env, this.errorCode);
}

class _KareeRouterErrorWidgetState extends ScreenState<KareeRouterErrorWidget> with SingleTickerProviderStateMixin {
  TabController? tabController;

  String? _title;
  StackTrace? _stack;
  List<String>? env;
  KareeErrorCode? errorCode;

  _KareeRouterErrorWidgetState([this._title, this._stack, this.env, this.errorCode]);

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Future<List<StackErrorEntry>> get loadStackTrace async {
    int i = 0;
    List<String> trace = _stack?.toString().split('\n') ?? [];
    if (trace.length > 0)
      return trace.map((e) {
        if (e.length > 0) {
          e = kIsWeb ? e.trim() : e.substring(e.indexOf(' ')).trim();
        }
        return new StackErrorEntry(e, i++);
      }).toList();
    return [StackErrorEntry("Error (path/package) ", ++i)];
  }

  @override
  Widget builder(BuildContext context) {
    if (KareeMaterialApp.globalProfile == KareeInstanceProfile.development) return devErrorScreen();
    return prodErrorScreen();
  }

  Widget prodErrorScreen() {
    var prodErrorWidgetBuilder = screens.lastWhere((entry) => entry[#name] == KareeConstants.kareeErrorScreenName,
        orElse: () => {#screen: null})[#screen];
    if (prodErrorWidgetBuilder == null || prodErrorWidgetBuilder!().runtimeType == widget.runtimeType)
      return KareeRouterDefaultProdErrorWidget();

    return prodErrorWidgetBuilder();
  }

  Widget devErrorScreen() {
    var params = Map<Symbol, dynamic>.from((ModalRoute.of(context)?.settings.arguments ?? {}) as Map);
    _title = _title ?? params[#title];
    _stack = _stack ?? params[#stack];
    env = env ?? (params[#env] as List).map((e) => e.toString()).toList();
    errorCode = errorCode ?? params[#errorCode];
    print(_title);
    return Scaffold(
        appBar: PreferredSize(
            child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF2A2A2A),
                ),
                padding: EdgeInsets.only(top: 30, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                              child: Icon(
                                Icons.west_rounded,
                                size: 15,
                                color: Colors.white,
                              ),
                              onPressed: () => KareeRouter.goBack()),
                          Container(
                            child: Text(
                              "Exception",
                              style: TextStyle(color: Color(0xFFD04C46), fontWeight: FontWeight.w400),
                            ),
                            padding: EdgeInsets.only(top: 15),
                          )
                        ]),
                    SizedBox(height: 10),
                    Text(
                      _title ?? '',
                      style: TextStyle(color: Color(0xFFA2AFA3), fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 10),
                  ],
                )),
            preferredSize: Size.fromHeight(100)),
        body: Column(children: [
          Container(
            height: 40,
            color: Colors.black87, //(0xFFEEEEEE),
            child: TabBar(
              unselectedLabelStyle: TextStyle(color: Colors.white30),
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              tabs: [Tab(text: 'Solution'), Tab(text: 'All Frame')],
              controller: tabController,
            ),
          ),
          Expanded(
              child: TabBarView(
            controller: tabController,
            children: [
              Container(
                  color: Colors.black87,
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, left: 20),
                        child: Text("Environment",
                            style: TextStyle(color: Colors.white38, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                      Card(
                        elevation: 5,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: env
                                    ?.map((e) => RichText(
                                            text: TextSpan(
                                                style: TextStyle(color: Colors.white38),
                                                text: '${(env ?? []).indexOf(e) + 1}. ',
                                                children: [
                                              TextSpan(
                                                text: "\" $e \"",
                                                style: TextStyle(color: Colors.white),
                                              )
                                            ])))
                                    .toList() ??
                                [],
                          ),
                        ),
                        color: Colors.white10,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, left: 20),
                        child: Text("Proposal",
                            style: TextStyle(color: Colors.white38, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                      errorSolution[errorCode]?.call(context, env as List) ?? Container()
                    ],
                  ))),
              SizedBox(
                  height: 100,
                  child: FutureBuilder<List<StackErrorEntry>>(
                    future: loadStackTrace,
                    builder: (context, snapshot) {
                      if (snapshot.hasError)
                        return Center(
                          child: TextButton(
                            child: Text('Error occurs ${snapshot.error}'),
                            onPressed: null,
                          ),
                        );
                      if (!snapshot.hasData)
                        return Center(
                          child: CircularProgressIndicator(),
                        );

                      return ListView.builder(
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (ctx, index) {
                            StackErrorEntry? item = snapshot.data?.elementAt(index);
                            return Container(
                                height: 60,
                                color: (item?.index ?? 0) % 2 == 0 ? Colors.transparent : Colors.black12,
                                child: ListTile(
                                  title: Row(children: [
                                    Container(
                                        padding: EdgeInsets.all(3),
                                        margin: EdgeInsets.only(right: 5),
                                        decoration: BoxDecoration(
                                            color: Color(0xFF2A2A2A), borderRadius: BorderRadius.circular(5)),
                                        child: Text('${item?.index}',
                                            style: TextStyle(color: Colors.white, fontSize: 10))),
                                    Expanded(
                                        child: Container(
                                            child: Text(item?.title ?? '',
                                                style: TextStyle(color: Colors.black87, fontSize: 12))))
                                  ]),
                                  subtitle: Text(item?.path ?? '', style: TextStyle(fontSize: 10)),
                                )
                                // child: Text('kdkd $index'),
                                );
                          });
                    },
                  ))
            ],
          ))
        ]));
  }
}

class StackErrorEntry {
  String? title, path;
  int? index;

  StackErrorEntry(String e, this.index) {
    if (e.length > 0) {
      int indexEndTitle = e.indexOf('(');
      int indexBeginTile = e.lastIndexOf(')');
      int? lastIndex;
      this.title = kIsWeb
          ? e.substring((lastIndex = e.lastIndexOf(' ')))
          : e.substring(0, indexEndTitle > 0 ? indexEndTitle : e.length);
      this.path = kIsWeb
          ? e.substring(0, lastIndex).trim()
          : e.substring(indexEndTitle + 1, indexBeginTile > 0 ? indexBeginTile : e.length);
    }
  }

  String toString() => {#title: title, #path: path, #index: index}.toString();
}
