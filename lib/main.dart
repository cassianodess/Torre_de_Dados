import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Torre de Dados',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Torre de Dados'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  int _dice = 1;
  int _initiative = 0;
  String dropDownValue = 'D4';
  int data = new DateTime.now().year;

  void _rollDice() {
    setState(() {
      _dice = Random().nextInt(getDimension(this.dropDownValue) + 1);
      while (_dice == 0) {
        _dice = Random().nextInt(getDimension(this.dropDownValue) + 1);
      }
    });
  }

  void _rollInitiative() {
    setState(() {
      if (this.myController.text == '') {
        this._initiative =
            Random().nextInt(getDimension(this.dropDownValue) + 1);
      } else {
        int input = int.parse(this.myController.text);
        this._initiative =
            Random().nextInt(getDimension(this.dropDownValue) + 1 + input);
      }
    });
  }

  int getDimension(String dimension) {
    switch (dimension) {
      case 'D4':
        return 4;
      case 'D6':
        return 6;
      case 'D8':
        return 8;
      case 'D10':
        return 10;
      case 'D12':
        return 12;
      case 'D20':
        return 20;
      default:
        return 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: DropdownButton<String>(
                focusNode: FocusNode(
                  descendantsAreFocusable: false,
                ),
                value: this.dropDownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Roboto',
                ),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                  alignment: Alignment.center,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    this.dropDownValue = newValue!;
                  });
                },
                items: <String>['D4', 'D6', 'D8', 'D10', 'D12', 'D20', 'D100']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Container(
              width: 150,
              alignment: Alignment.center,
              child: TextField(
                autofocus: false,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
                keyboardType: TextInputType.number,
                controller: this.myController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Modificador',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Iniciativa',
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Text(
                          '$_initiative',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            // backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Dado',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Text(
                          '$_dice',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                            fontFamily: 'Roboto',

                            // backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: MaterialButton(
                    height: 50,
                    color: Colors.red[600],
                    child: Text(
                      'Rolar Iniciativa',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Roboto',
                      ),
                      softWrap: false,
                    ),
                    onPressed: () => {_rollInitiative()},
                    // color: Colors.blue,
                  ),
                ),
                Container(
                  child: MaterialButton(
                    height: 50,
                    color: Colors.blue,
                    child: Text(
                      'Rolar Dado',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Roboto',
                      ),
                      softWrap: false,
                    ),
                    onPressed: () => {_rollDice()},
                  ),
                ),
              ],
            ),
            Container(
              child: Text(
                'Desenvolvido por Cassianodess © - $data',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
