import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_learning_pred/screens/dl_screen.dart';
import 'package:machine_learning_pred/sentences/bitcoin_sentences.dart';
import 'package:machine_learning_pred/components/bottom_buttons.dart';
import 'package:machine_learning_pred/components/bottom_menu.dart';
import 'package:machine_learning_pred/screens/deep_learning/current_bitcoin.dart';

class Rnn extends StatefulWidget {
  static const String id = 'Rnn';

  @override
  _RnnState createState() => _RnnState();
}

class _RnnState extends State<Rnn> {

  BitcoinSentences bitcoinSentences = BitcoinSentences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bitcoinの価格予測(RNN)'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Image.asset('images/dl_graph.jpg'),
            margin: EdgeInsets.all(15),
            height: (MediaQuery.of(context).size.height)/3.5,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0,3),
                  )
                ]
            ),
          ),
          SizedBox(
            height: (MediaQuery.of(context).size.height)/200,
          ),
          Container(
            height: (MediaQuery.of(context).size.height)/3.5,
          padding: EdgeInsets.all(30),
          child: Text(
          bitcoinSentences.getSentence(),
          textAlign: TextAlign.center,
          style: TextStyle(
          fontSize: 20.0,
          locale: Locale("ja", "JP"),
          fontWeight: FontWeight.bold,
          color: Colors.black
          ),
          ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          BottomButton(
            hero: 'previous',
            onPressed: (){
              if (bitcoinSentences.getCurrent() == 0){
                Navigator.pushNamed(context, DLScreen.id);
              }
              else{
                setState(() {
                  bitcoinSentences.decrement();
                });
              }
            },
            icon: Icons.navigate_before,
            label: '前へ',
            backgroundColor: Colors.redAccent.shade100,
          ),
          BottomButton(
            hero: 'next',
            onPressed: () async{
              if (bitcoinSentences.getCurrent() < 4){
                setState(() {
                  bitcoinSentences.increment();
                });
              }
              else if (bitcoinSentences.getCurrent() == 4){
                Navigator.pushNamed(context, BitcoinData.id);
              }
            },
            icon: Icons.navigate_next,
            label: '次へ',
            backgroundColor: Colors.blueAccent.shade100,
          ),
        ],
      ),
      bottomNavigationBar: BottomMenu(),
    );
  }
}
