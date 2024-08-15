import 'package:basic_calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: HomePage()),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';
  bool openParanthesis = true;

  final List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "()",
    "0",
    ",",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffEEF7FF),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ), // This is empty box for alignment -push it down the next container
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestion,
                      style: const TextStyle(
                        fontSize: 45.0,
                        color: Color(0xff3b6979),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: const TextStyle(
                        fontSize: 30.0,
                        color: Color(0xff8a8a8a),
                      ),
                    ),
                  ),
                ],
              )),
            ),
            const Divider(),
            Expanded(
              flex: 2,
              child: Container(
                child: Center(
                    child: GridView.builder(
                        itemCount: buttons.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                        itemBuilder: (BuildContext context, int index) {
                          // Clear Button
                          if (index == 0) {
                            return MyButton(
                                buttonTapped: () {
                                  setState(() {
                                    userQuestion = '';
                                    userAnswer = '';
                                  });
                                },
                                buttonText: buttons[index],
                                color: Color(0xffCDE8E5),
                                textColor: Colors.red);
                          } // Delete Button
                          else if (index == 1) {
                            return MyButton(
                                buttonTapped: () {
                                  setState(() {
                                    userQuestion = userQuestion.substring(
                                        0, userQuestion.length - 1);
                                  });
                                  equalPressed(userQuestion);
                                },
                                buttonText: buttons[index],
                                color: Color(0xffCDE8E5),
                                textColor: Color(0xff4D869C));
                          } // Paranthesis
                          else if (index == 16) {
                            return MyButton(
                                buttonTapped: () {
                                  setState(() {
                                    userQuestion += openParanthesis ? '(' : ')';
                                    openParanthesis = !openParanthesis;
                                  });
                                },
                                buttonText: buttons[index],
                                color: Color(0xffCDE8E5),
                                textColor: Color(0xff4D869C));
                          } //Equal Button
                          else if (index == 19) {
                            return MyButton(
                                buttonTapped: () {
                                  setState(() {
                                    //do nothing
                                    equalPressed(userQuestion);
                                  });
                                },
                                buttonText: buttons[index],
                                color: const Color(0xff008DDA),
                                textColor: Colors.white);
                          } // Rest of the buttons
                          else {
                            return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  userQuestion += buttons[index];
                                });
                              },
                              buttonText: buttons[index],
                              color: const Color(0xffCDE8E5),
                              textColor: const Color(0xff4D869C),
                            );
                          }
                        })
                    // There will have a bunch of buttons
                    ),
              ),
            )
          ],
        ));
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed(String userQuestion) {
    userQuestion = userQuestion.replaceAll("x", "*");
    userQuestion = userQuestion.replaceAll(",", ".");
    Parser p = Parser();
    Expression exp = p.parse(userQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}
