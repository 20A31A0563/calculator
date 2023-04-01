import 'package:flutter/material.dart';
import 'package:calculator/buttons.dart';
import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  final List<String> button = [
    "C",
    "DEL",
    "%",
    "/",
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];
  var question = "";
  var answer = "0";

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    question,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    answer,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                  itemCount: button.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Mybutton(
                        buttontapped: () {
                          setState(() {
                            question = "";
                            answer = "0";
                          });
                        },
                        color: Colors.orange,
                        textcolor: Colors.white,
                        textcon: button[index],
                      );
                    } else if (index == 1) {
                      return Mybutton(
                        buttontapped: () {
                          setState(() {
                            question =
                                question.substring(0, question.length - 1);
                          });
                        },
                        color: Colors.green,
                        textcolor: Colors.white,
                        textcon: button[index],
                      );
                    } else if (button[index] == '=') {
                      return Mybutton(
                        buttontapped: () {
                          setState(() {
                            if (question == "") {
                              question = "0";
                            }
                            equalpressed();
                            question = "";
                          });
                        },
                        color: Colors.deepPurple,
                        textcolor: Colors.white,
                        textcon: button[index],
                      );
                    } else {
                      if (isoperator(button[index])) {
                        return Mybutton(
                          buttontapped: () {
                            setState(() {
                              if (question == "") {
                                question = answer;
                              }
                              question += button[index];
                            });
                          },
                          color: Colors.deepPurple,
                          textcolor: Colors.white,
                          textcon: button[index],
                        );
                      } else {
                        return Mybutton(
                          buttontapped: () {
                            setState(() {
                              question += button[index];
                            });
                          },
                          color: Colors.white,
                          textcolor: Colors.deepPurple,
                          textcon: button[index],
                        );
                      }
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isoperator(String ch) {
    if (ch == '%' ||
        ch == 'x' ||
        ch == '-' ||
        ch == '+' ||
        ch == '=' ||
        ch == '/') return true;
    return false;
  }

  void equalpressed() {
    String finquestion = question;
    finquestion = finquestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finquestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    answer = eval.toString();
  }
}
