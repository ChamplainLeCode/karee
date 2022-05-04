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
        Padding,
        RichText,
        Text,
        TextAlign,
        TextSpan,
        TextStyle,
        Widget;
import '../constances/enumeration.dart';
import '../constances/constances.dart';
import '../routes/router.dart' show RouteMode;

var errorSolution =
    <KareeErrorCode, Widget Function(BuildContext ct, List env)>{
  KareeErrorCode.noInitialScreen:
      (BuildContext context, List<dynamic>? environment) => Card(
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
                            fontSize: 13,
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
                            TextSpan(
                                text: "true",
                                style: TextStyle(color: Colors.blue)),
                            TextSpan(
                              text:
                                  " to the declaration of one of your screens to define it as the first screen of your application\n",
                              style: TextStyle(color: Colors.white),
                            ),
                          ])),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w300,
                              fontSize: 13),
                          text: '@Screen',
                          children: [
                        TextSpan(
                          text: "(",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                            text: " \"screen_name\"",
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold)),
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
                            fontSize: 13,
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
  KareeErrorCode.badUseOfRoutableWidget:
      (BuildContext context, List<dynamic>? environment) => Card(
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
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                          children: [
                            TextSpan(
                              text: "Cannot use ",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                                text: " ${environment!.elementAt(1)} ",
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.w500)),
                            TextSpan(
                              text: " with RouterWidget ",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                              text:
                                  "  ${environment.firstWhere((element) => true, orElse: () => '')}",
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                              text: "\n\nTry to change ",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                              text: " ${environment.elementAt(1)} ",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                              text: " to ",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                              text: " ${RouteMode.INTERNAL} ",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500),
                            ),
                          ])),
                ],
              ),
            ),
            color: Colors.white10,
          ),
  KareeErrorCode.notRoutableWidget:
      (BuildContext context, List<dynamic>? environment) => Card(
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
                            fontSize: 13,
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
                              text:
                                  " To make this widget injectable in your RouterWidget, change its definition to \n",
                              style: TextStyle(color: Colors.white),
                            ),
                          ])),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w300,
                              fontSize: 13),
                          text: 'class',
                          children: [
                        TextSpan(
                            text: " ${environment?.last}",
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.normal)),
                        TextSpan(
                          text: ",   extends  ",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w300,
                              fontSize: 13),
                        ),
                        TextSpan(
                            text: "   RoutableWidget  ",
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.normal)),
                      ])),
                ],
              ),
            ),
            color: Colors.white10,
          ),
  KareeErrorCode.notKareeScreen:
      (BuildContext context, List<dynamic>? environment) => Card(
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
                            fontSize: 13,
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
                              text:
                                  " to make this It injectable in the root navigation, change its definition to \n",
                              style: TextStyle(color: Colors.white),
                            ),
                          ])),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w300,
                              fontSize: 13),
                          text: 'class',
                          children: [
                        TextSpan(
                            text:
                                " ${environment?.firstWhere((element) => true, orElse: () => '')}",
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.normal)),
                        TextSpan(
                          text: "   extends  ",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w300,
                              fontSize: 13),
                        ),
                        TextSpan(
                            text: "   StatelessScreen  \n",
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.normal)),
                        TextSpan(
                          text: "\n -------- or ---------- \n",
                          style: TextStyle(color: Colors.white),
                        ),
                      ])),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w300,
                              fontSize: 13),
                          text: 'class',
                          children: [
                        TextSpan(
                            text:
                                " ${environment?.firstWhere((element) => true, orElse: () => '')}",
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.normal)),
                        TextSpan(
                          text: "   extends  ",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w300,
                              fontSize: 13),
                        ),
                        TextSpan(
                            text: "   StatefulScreen  ",
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.normal)),
                      ])),
                ],
              ),
            ),
            color: Colors.white10,
          ),
  KareeErrorCode.noTranslationFile:
      (BuildContext context, List<dynamic>? environment) => Card(
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
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                          children: [
                            TextSpan(
                              text: "Try to add ",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                              text:
                                  "${environment?.firstWhere((element) => true, orElse: () => '')} ",
                              style: TextStyle(color: Colors.deepOrange),
                            ),
                            TextSpan(
                              text: "into translation directory ",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                              text: KareeConstants
                                  .kApplicationLocalizationRessourcDir,
                              style: TextStyle(color: Colors.deepOrange),
                            ),
                          ])),
                ],
              ),
            ),
            color: Colors.white10,
          ),
  KareeErrorCode.noRouteFound: (ctx, List<dynamic>? environment) => Card(
        elevation: 5,
        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(ctx).size.width,
          margin: EdgeInsets.only(top: 5, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text:
                              "Try to verify that the name you entered as route. It seems not correct\n",
                          style: TextStyle(color: Colors.white),
                        ),
                      ])),
              RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                      text: 'Route',
                      children: [
                    TextSpan(
                      text: ".",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                        text: "on",
                        style: TextStyle(
                            color: Colors.teal, fontWeight: FontWeight.w400)),
                    TextSpan(text: "(", style: TextStyle(color: Colors.white)),
                    TextSpan(
                        text:
                            ' "${environment?.firstWhere((element) => true, orElse: () => '')}" ',
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.w400)),
                    TextSpan(
                      text: ", ",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                        text: ' "....." ',
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.w400)),
                    TextSpan(
                      text: ")",
                      style: TextStyle(color: Colors.white),
                    )
                  ])),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    '_________________ Or _________________\n',
                    style: TextStyle(color: Colors.white),
                  )),
              RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                      text: 'KareeRouter',
                      children: [
                    TextSpan(
                      text: ".",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                        text: "goto",
                        style: TextStyle(
                            color: Colors.teal, fontWeight: FontWeight.w400)),
                    TextSpan(text: "(", style: TextStyle(color: Colors.white)),
                    TextSpan(
                        text:
                            ' "${environment?.firstWhere((element) => true, orElse: () => '')}" ',
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.w400)),
                    TextSpan(
                      text: ")",
                      style: TextStyle(color: Colors.white),
                    )
                  ]))
            ],
          ),
        ),
        color: Colors.white10,
      ),
  KareeErrorCode.generalError: (ctx, List<dynamic>? environment) => Card(
      elevation: 5,
      color: Colors.white10,
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(ctx).size.width,
          margin: EdgeInsets.only(top: 5, bottom: 5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                    children: [
                      TextSpan(
                        text:
                            "General Error: Take a look at the Stacktrace in All Frame tab\n",
                        style: TextStyle(color: Colors.white),
                      ),
                    ]))
          ]))),
  KareeErrorCode.screenNotFound:
      (BuildContext context, List<dynamic>? environment) => Card(
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
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  "Try to verify that the name you enter as screen. It seems not correct\n",
                              style: TextStyle(color: Colors.white),
                            ),
                          ])),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w300,
                              fontSize: 13),
                          text: '@Screen',
                          children: [
                        TextSpan(
                          text: "(",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                            text: " \"screen_name\"",
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold)),
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
