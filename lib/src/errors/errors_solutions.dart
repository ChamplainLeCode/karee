import 'package:flutter/material.dart'
    show
        Alignment,
        BuildContext,
        Card,
        Colors,
        Column,
        Container,
        CrossAxisAlignment,
        EdgeInsets,
        FontWeight,
        MediaQuery,
        RichText,
        TextAlign,
        TextSpan,
        TextStyle,
        Widget;
import '../routes/Router.dart' show RouteMode;

enum KareeErrorCode {
  NO_INITIAL_SCREEN,
  SCREEN_NOT_FOUND,
  NO_ROUTE_FOUND,
  GENERAL_ERROR,
  NOT_ROUTABLE_WIDGET,
  NOT_KAREE_SCREEN,
  BAD_USE_OF_ROUTABLE_WIDGET
}
var errorSolution = <KareeErrorCode, Widget Function(BuildContext ct, List env)>{
  KareeErrorCode.NO_INITIAL_SCREEN: (BuildContext context, List<dynamic>? environment) => Card(
        elevation: 1,
        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: "Add ",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: "   isInitial: ",
                          style: TextStyle(color: Colors.blue),
                        ),
                        TextSpan(text: "true", style: TextStyle(color: Colors.blue)),
                        TextSpan(
                          text:
                              " to the declaration of one of your screens to define it as the first screen of your application\n",
                          style: TextStyle(color: Colors.white),
                        ),
                      ])),
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w300, fontSize: 12),
                      text: '@Screen',
                      children: [
                    TextSpan(
                      text: "(",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                        text: " \"screen_name\"",
                        style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: ",   isInitial: ",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                      text: "true",
                    ),
                    TextSpan(
                      text: ")",
                      style: TextStyle(color: Colors.white),
                    ),
                  ])),
              RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: "\nThen run ",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: "   `karee source`",
                          style: TextStyle(color: Colors.deepOrange),
                        ),
                        TextSpan(
                          text: " and apply hot restart of application\n",
                          style: TextStyle(color: Colors.white),
                        ),
                      ]))
            ],
          ),
        ),
        color: Colors.white10,
      ),
  KareeErrorCode.BAD_USE_OF_ROUTABLE_WIDGET: (BuildContext context, List<dynamic>? environment) => Card(
        elevation: 1,
        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: "Cannot use ",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                            text: " ${environment!.elementAt(1)} ",
                            style: TextStyle(color: Colors.teal, fontWeight: FontWeight.w500)),
                        TextSpan(
                          text: " with RouterWidget ",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: "  ${environment.first}",
                          style: TextStyle(color: Colors.teal, fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: "\n\nTry to change ",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: " ${environment.elementAt(1)} ",
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: " to ",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: " ${RouteMode.NONE} ",
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                        ),
                      ])),
            ],
          ),
        ),
        color: Colors.white10,
      ),
  KareeErrorCode.NOT_ROUTABLE_WIDGET: (BuildContext context, List<dynamic>? environment) => Card(
        elevation: 1,
        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: "Your widget should extends  ",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: "  RoutableWidget ",
                          style: TextStyle(color: Colors.blue),
                        ),
                        TextSpan(
                          text: " To make this widget injectable in your RouterWidget, change its definition to \n",
                          style: TextStyle(color: Colors.white),
                        ),
                      ])),
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w300, fontSize: 12),
                      text: 'class',
                      children: [
                    TextSpan(
                        text: " ${environment?.last}",
                        style: TextStyle(color: Colors.teal, fontWeight: FontWeight.normal)),
                    TextSpan(
                      text: ",   extends  ",
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w300, fontSize: 12),
                    ),
                    TextSpan(
                        text: "   RoutableWidget  ",
                        style: TextStyle(color: Colors.teal, fontWeight: FontWeight.normal)),
                  ])),
            ],
          ),
        ),
        color: Colors.white10,
      ),
  KareeErrorCode.NOT_KAREE_SCREEN: (BuildContext context, List<dynamic>? environment) => Card(
        elevation: 1,
        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: "Your widget should extends  ",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: "  StatelessScreen ",
                          style: TextStyle(color: Colors.blue),
                        ),
                        TextSpan(
                          text: " or ",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: "  StatefullScreen ",
                          style: TextStyle(color: Colors.blue),
                        ),
                        TextSpan(
                          text: " to make this It injectable in the root navigation, change its definition to \n",
                          style: TextStyle(color: Colors.white),
                        ),
                      ])),
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w300, fontSize: 12),
                      text: 'class',
                      children: [
                    TextSpan(
                        text: " ${environment?.first}",
                        style: TextStyle(color: Colors.teal, fontWeight: FontWeight.normal)),
                    TextSpan(
                      text: ",   extends  ",
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w300, fontSize: 12),
                    ),
                    TextSpan(
                        text: "   StatelessScreen  \n",
                        style: TextStyle(color: Colors.teal, fontWeight: FontWeight.normal)),
                    TextSpan(
                      text: "\n -------- or ---------- \n",
                      style: TextStyle(color: Colors.white),
                    ),
                  ])),
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w300, fontSize: 12),
                      text: 'class',
                      children: [
                    TextSpan(
                        text: " ${environment?.first}",
                        style: TextStyle(color: Colors.teal, fontWeight: FontWeight.normal)),
                    TextSpan(
                      text: "   extends  ",
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w300, fontSize: 12),
                    ),
                    TextSpan(
                        text: "   StatefulScreen  ",
                        style: TextStyle(color: Colors.teal, fontWeight: FontWeight.normal)),
                  ])),
            ],
          ),
        ),
        color: Colors.white10,
      ),
  KareeErrorCode.NO_ROUTE_FOUND: (ctx, List<dynamic>? environment) => Card(),
  KareeErrorCode.GENERAL_ERROR: (ctx, List<dynamic>? environment) => Card(),
  KareeErrorCode.SCREEN_NOT_FOUND: (BuildContext context, List<dynamic>? environment) => Card(
        elevation: 5,
        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 5, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: "Try to verify that the name you enter as screen. It seems not correct\n",
                          style: TextStyle(color: Colors.white),
                        ),
                      ])),
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w300, fontSize: 12),
                      text: '@Screen',
                      children: [
                    TextSpan(
                      text: "(",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                        text: " \"screen_name\"",
                        style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: ")",
                      style: TextStyle(color: Colors.white),
                    ),
                  ]))
            ],
          ),
        ),
        color: Colors.white10,
      ),
};
