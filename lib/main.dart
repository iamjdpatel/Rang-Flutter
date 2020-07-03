import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MaterialApp(
      home: HomeView(),
      darkTheme: ThemeData.dark(),
    ));

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double rTarget = Random().nextDouble();
  double gTarget = Random().nextDouble();
  double bTarget = Random().nextDouble();

  double rGuess = 0.4;
  void setrvalue(double rvalue) => setState(() => rGuess = rvalue);

  double gGuess = 0.4;
  void setgvalue(double gvalue) => setState(() => gGuess = gvalue);

  double bGuess = 0.4;
  void setbvalue(double bvalue) => setState(() => bGuess = bvalue);

  int score = 0;

  void updateNewRang() {
    rTarget = Random().nextDouble();
    gTarget = Random().nextDouble();
    bTarget = Random().nextDouble();

    rGuess = 0.4;
    gGuess = 0.4;
    bGuess = 0.4;
  }

  void calculateRang() {
    print(rTarget);
    print(gTarget);
    print(bTarget);

    print(rGuess);
    print(gGuess);
    print(bGuess);

    var rDiff = rGuess - rTarget;
    var gDiff = gGuess - gTarget;
    var bDiff = bGuess - bTarget;
    var diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff);
    score = ((1.0 - diff) * 100.0 + 0.5).toInt();

    print(score);

    handleClickMe();
  }

  Future<void> handleClickMe() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Rang'),
          content: Text('\nYour Score is $score'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  updateNewRang();
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rang'),
      ),
      body: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                updateNewRang();
              });
            },
            child: Container(
              margin: EdgeInsets.all(16),
              height: 150.0,
              decoration: BoxDecoration(
                  color: Color.fromRGBO((rTarget * 255).toInt(),
                      (gTarget * 255).toInt(), (bTarget * 255).toInt(), 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5.0)]),
            ),
          ),
          Text('Match this Rang'),
          Divider(
            height: 30.0,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
            height: 150.0,
            decoration: BoxDecoration(
                color: Color.fromRGBO((rGuess * 255).toInt(),
                    (gGuess * 255).toInt(), (bGuess * 255).toInt(), 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5.0)]),
          ),
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Column(
              children: <Widget>[
                Slider(
                  value: rGuess,
                  onChanged: setrvalue,
                  activeColor: Colors.red,
                  inactiveColor: Colors.grey,
                ),
                Slider(
                    value: gGuess,
                    onChanged: setgvalue,
                    activeColor: Colors.green,
                    inactiveColor: Colors.grey),
                Slider(
                    value: bGuess,
                    onChanged: setbvalue,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 50.0,
            width: MediaQuery.of(context).size.width - 32,
            child: RaisedButton(
              onPressed: () {
                calculateRang();
              },
              color: CupertinoColors.systemGreen,
              textColor: Colors.white,
              child: Text(
                'Calculate Rang',
                style: TextStyle(fontSize: 20.0),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
            ),
          )
        ],
      ),
    );
  }
}
