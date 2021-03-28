

import 'package:flutter/material.dart' show Alignment, BuildContext, Card, Colors, Column, Container, CrossAxisAlignment, EdgeInsets, FontWeight, MediaQuery, RichText, TextAlign, TextSpan, TextStyle, WidgetBuilder;

enum KareeErrorCode{
  NO_INITIAL_SCREEN, SCREEN_NOT_FOUND, NO_ROUTE_FOUND, GENERAL_ERROR
}
var errorSolution = <KareeErrorCode, WidgetBuilder>{

  KareeErrorCode.NO_INITIAL_SCREEN: (BuildContext context) => Card(
                            elevation: 1,
                            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(
                                left: 10,
                                top: 5,
                                bottom: 5,
                                right: 10
                              ),
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
                                          TextSpan(
                                            text: "true",
                                            style: TextStyle(color: Colors.blue)
                                          ),
                                          TextSpan(
                                            text: " to the declaration of one of your screens to define it as the first screen of your application\n",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ]
                                      )
                                    ),
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
                                              style: TextStyle(
                                                  color: Colors.deepOrange, fontWeight: FontWeight.bold)),
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
                                        ]
                                      )
                                    ),
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
                                        ]
                                      )
                                    )
                                ],
                              ),
                            ),
                            color: Colors.white10,
                          ),
  KareeErrorCode.NO_ROUTE_FOUND: (ctx) => Card(),

  KareeErrorCode.GENERAL_ERROR: (ctx) => Card(),
  
  KareeErrorCode.SCREEN_NOT_FOUND: (BuildContext context) => Card(
                            elevation: 5,
                            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(
                                left: 20,
                                top: 5,
                                bottom: 5
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    // RichText(
                                    //   textAlign: TextAlign.justify,
                                    //   text: TextSpan(
                                    //     style: TextStyle(
                                    //       fontSize: 12,
                                    //       fontWeight: FontWeight.w300,
                                    //     ),
                                    //     children: [
                                    //       TextSpan(
                                    //         text: "Add ",
                                    //         style: TextStyle(color: Colors.white),
                                    //       ),
                                    //       TextSpan(
                                    //         text: "   isInitial: ",
                                    //         style: TextStyle(color: Colors.blue),
                                    //       ),
                                    //       TextSpan(
                                    //         text: "true",
                                    //         style: TextStyle(color: Colors.blue)
                                    //       ),
                                    //       TextSpan(
                                    //         text: " to the declaration of one of your screens to define it as the first screen of your application\n",
                                    //         style: TextStyle(color: Colors.white),
                                    //       ),
                                    //     ]
                                    //   )
                                    // ),
                                    // RichText(
                                    //   text: TextSpan(
                                    //     style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w300, fontSize: 12),
                                    //     text: '@Screen',
                                    //     children: [
                                    //       TextSpan(
                                    //         text: "(",
                                    //         style: TextStyle(color: Colors.white),
                                    //       ),
                                    //       TextSpan(
                                    //           text: " \"screen_name\"",
                                    //           style: TextStyle(
                                    //               color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                                    //       TextSpan(
                                    //         text: ",   isInitial: ",
                                    //         style: TextStyle(color: Colors.white),
                                    //       ),
                                    //       TextSpan(
                                    //         text: "true",
                                    //       ),
                                    //       TextSpan(
                                    //         text: ")",
                                    //         style: TextStyle(color: Colors.white),
                                    //       ),
                                    //     ]
                                    //   )
                                    // )
                                ],
                              ),
                            ),
                            color: Colors.white10,
                          ),
};