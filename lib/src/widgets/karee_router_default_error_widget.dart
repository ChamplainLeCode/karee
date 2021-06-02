import 'package:flutter/material.dart';

import './karee_material_app.dart';

class KareeRouterDefaultProdErrorWidget extends StatefulWidget {
  @override
  _KareeRouterDefaultProdErrorWidgetState createState() => _KareeRouterDefaultProdErrorWidgetState();
}

class _KareeRouterDefaultProdErrorWidgetState extends State<KareeRouterDefaultProdErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black87),
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 100,
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'OOPS!',
                    style: TextStyle(fontSize: 100, fontWeight: FontWeight.w200),
                  ),
                ),
                Column(children: [
                  Expanded(child: Container()),
                  Container(
                      alignment: Alignment.center,
                      child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                          color: Colors.white,
                          child: Text(
                            'Something went wrong',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                          )))
                ])
              ],
            ),
          ),
          Container(
            child: Text(
              '${KareeMaterialApp.globalErrorContactAddress?.appName ?? 'Karee App'}',
              style: TextStyle(fontSize: 15, color: Colors.primaries.first, fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.only(top: 20),
          ),
          Container(
            child: Text(
              '[ ${KareeMaterialApp.globalErrorContactAddress?.appVersion ?? 'v2.0.0'} ]',
              style: TextStyle(color: Colors.primaries.first, fontSize: 12, fontWeight: FontWeight.w300),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              '${KareeMaterialApp.globalErrorContactAddress?.appSupportEmail ?? ''}',
              style: TextStyle(color: Colors.primaries.first, fontSize: 12, fontWeight: FontWeight.w300),
            ),
          )
        ],
      )),
    );
  }
}
