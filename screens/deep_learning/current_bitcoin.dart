import 'package:flutter/material.dart';
import 'package:machine_learning_pred/components/bottom_menu.dart';
import 'package:machine_learning_pred/components/value_card.dart';
import 'package:machine_learning_pred/sentences/bitcoin_sentences.dart';
import 'package:machine_learning_pred/components/bottom_buttons.dart';
import 'package:machine_learning_pred/screens/deep_learning/predict_result.dart';
import 'package:intl/intl.dart';
import 'package:machine_learning_pred/backend/deep_learning/api.dart';

class BitcoinData extends StatefulWidget {
  static const String id = 'bitcoinScreen';

  @override
  _BitcoinDataState createState() => _BitcoinDataState();
}

class _BitcoinDataState extends State<BitcoinData> {
  List<dynamic> bitcoinValues =  [];
  bool isWaiting = false;
  BitcoinSentences bitcoinSentences = BitcoinSentences();
  int currentListIndex = BitcoinSentences().setCurrent(5);
  List<double> actual = [];
  final String fiveDaysAgo = DateFormat('M月d日').format(DateTime.now().add(Duration(days: 5) * -1));
  final String oneDayAgo = DateFormat('M月d日').format(DateTime.now().add(Duration(days: 1) * -1));
  final String twoDaysAgo = DateFormat('M月d日').format(DateTime.now().add(Duration(days: 2) * -1));
  final String threeDaysAgo = DateFormat('M月d日').format(DateTime.now().add(Duration(days: 3) * -1));
  final String fourDaysAgo = DateFormat('M月d日').format(DateTime.now().add(Duration(days: 4) * -1));

  void getData() async{
    isWaiting = true;
    try{
        List<double> actuals = await ActualData().getActualData();
        isWaiting = false;
        setState(() {
          actual = actuals;
        });
    }catch (e){
      print(e);
    }
  }
  
  @override
  void initState(){
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bitcoinの価格予測'),
        backgroundColor: Colors.black
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ValueCard(
            date: "$oneDayAgo",
            value: isWaiting ? "Not Found" : "${actual[0]}",
            color: Colors.black38,
          ),
          ValueCard(
            date: "$twoDaysAgo",
            value: isWaiting ? "Not Found" : "${actual[1]}",
            color: Colors.black38,
          ),
          ValueCard(
            date: "$threeDaysAgo",
            value: isWaiting ? "Not Found" : "${actual[2]}",
            color: Colors.black38,
          ),
          ValueCard(
            date: "$fourDaysAgo",
            value: isWaiting ? "Not Found" : "${actual[3]}",
            color: Colors.black38,
          ),
          ValueCard(
            date: "$fiveDaysAgo",
            value: isWaiting ? "Not Found" : "${actual[4]}",
            color: Colors.black38,
          ),
          SizedBox(
            height: (MediaQuery.of(context).size.height)/100,
          ),
          Container(
            padding: EdgeInsets.all(30),
            height: (MediaQuery.of(context).size.height)/5,
            child: Text(
              isWaiting ? '集計中...' : bitcoinSentences.getExactSentence(currentListIndex),
              textAlign: TextAlign.center,
              style: TextStyle(
              fontSize: (MediaQuery.of(context).size.height)/40,
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
              if(currentListIndex==5){
                Navigator.pop(context);
              }
              else{
                setState(() {
                  currentListIndex--;
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
              if (currentListIndex == 5){
                setState(() {
                  currentListIndex++;
                });
              }
              else if (currentListIndex >= 6){
                Navigator.pushNamed(context, BitcoinPredicted.id);
                setState(() {
                  currentListIndex = 6;
                });
              }
            },
            icon: Icons.navigate_next,
            label: currentListIndex==5 ? '次へ' : '予測結果を見る',
            backgroundColor: currentListIndex==5 ? Colors.blueAccent.shade100 : Colors.blue,
          ),
        ],
      ),

      bottomNavigationBar: BottomMenu(),
    );
  }
}
