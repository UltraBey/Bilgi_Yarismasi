import 'package:bilgiyarismasi/sorularlist.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

void main() => runApp(
      BilgiTesti(),
    );

class BilgiTesti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.indigo[700],
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: SoruSayfasi(),
          ),
        ),
      ),
    );
  }
}

class SoruSayfasi extends StatefulWidget {
  @override
  _SoruSayfasiState createState() => _SoruSayfasiState();
}

class _SoruSayfasiState extends State<SoruSayfasi> {
  List<Widget> secimler = [];
  TestVeri test_1 = TestVeri();
  void ButonFonksiyonu(bool secilenButon) {
    if (test_1.testBittiMi() == true) {
      setState(
        () {
          test_1.getSoruYaniti() == secilenButon
              ? secimler.add(dogruIconu)
              : secimler.add(yanlisIconu);
        },
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Bravo testi bitirdiniz."),
            //content: new Text("Alert Dialog body"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new TextButton(
                child: new Text("Başa Dön"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      setState(
        () {
          test_1.testiSifirla();
          secimler = [];
        },
      );
    } else {
      setState(
        () {
          test_1.getSoruYaniti() == secilenButon
              ? secimler.add(dogruIconu)
              : secimler.add(
                  yanlisIconu,
                );
          test_1.sonrakiSoru();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                test_1.getSoruMetni(),
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 20,
          spacing: 20,
          direction: Axis.horizontal,
          children: secimler,
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.red[400],
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.all(12),
                      ),
                    ),
                    child: Icon(
                      Icons.thumb_down,
                      size: 30.0,
                    ),
                    onPressed: () {
                      ButonFonksiyonu(false);
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.all(12),
                        ),
                      ),
                      child: Icon(
                        Icons.thumb_up,
                        size: 30.0,
                      ),
                      onPressed: () {
                        ButonFonksiyonu(true);
                        setState(
                          () {
                            test_1.getSoruYaniti() == true
                                ? secimler.add(dogruIconu)
                                : secimler.add(
                                    yanlisIconu,
                                  );
                            test_1.sonrakiSoru();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
