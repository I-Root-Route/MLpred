import 'package:flutter/material.dart';
import 'package:machine_learning_pred/sentences/bitcoin_sentences.dart';

class LineContainer extends StatefulWidget {
  @override
  _LineContainerState createState() => _LineContainerState();
}

class _LineContainerState extends State<LineContainer> {
  BitcoinSentences bitcoinSentences = BitcoinSentences();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Text(
        bitcoinSentences.getSentence(),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 25.0,
            locale: Locale("ja", "JP"),
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),
      ),
    );
  }
}