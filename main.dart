import 'package:flutter/material.dart';
import 'package:machine_learning_pred/screens/home.dart';
import 'package:machine_learning_pred/screens/dl_screen.dart';
import 'package:machine_learning_pred/screens/deep_learning/rnn.dart';
import 'package:machine_learning_pred/screens/deep_learning/current_bitcoin.dart';
import 'package:machine_learning_pred/screens/deep_learning/predict_result.dart';
import 'package:machine_learning_pred/screens/deep_learning/compare.dart';
import 'package:machine_learning_pred/screens/comming_soon.dart';
import 'package:machine_learning_pred/screens/deep_learning/rnn_explanation/rnn_exp.dart';

void main() {
  runApp(MLPred());
}

class MLPred extends StatelessWidget { //chane "AppName"
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ML図鑑',
      initialRoute: Home.id,
      routes: {
        Home.id: (context) => Home(),
        DLScreen.id: (context) => DLScreen(),
        Rnn.id: (context) => Rnn(),
        BitcoinData.id: (context) => BitcoinData(),
        BitcoinPredicted.id :(context) => BitcoinPredicted(),
        CompareScreen.id : (context) => CompareScreen(),
        CommingSoonScreen.id: (context) => CommingSoonScreen(),
        RnnExp.id: (context) => RnnExp(),
      },
    );
  }
}
