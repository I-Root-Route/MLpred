import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:machine_learning_pred/components/bottom_menu.dart';
import 'package:machine_learning_pred/components/squarebutton.dart';
import 'package:machine_learning_pred/screens/deep_learning/rnn.dart';

class DLScreen extends StatefulWidget {
  static const String id = 'dlscreen';

  @override
  _DLScreenState createState() => _DLScreenState();
}

class _DLScreenState extends State<DLScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Deep Learning'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SquareButton(
                onTap: (){
                  Navigator.pushNamed(context, Rnn.id);
                },
                icon: FontAwesomeIcons.bitcoin,
                label: 'Bitcoinの価格予測',
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomMenu(),
    );
  }
}
