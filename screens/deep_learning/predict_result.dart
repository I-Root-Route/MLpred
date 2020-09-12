import 'package:flutter/material.dart';
import 'package:machine_learning_pred/backend/deep_learning/get_bitcoin_prices.dart';
import 'package:intl/intl.dart';
import 'package:machine_learning_pred/components/value_card.dart';
import 'package:machine_learning_pred/sentences/bitcoin_sentences.dart';
import 'package:machine_learning_pred/components/bottom_buttons.dart';
import 'package:machine_learning_pred/components/bottom_menu.dart';
import 'package:machine_learning_pred/screens/deep_learning/compare.dart';

class BitcoinPredicted extends StatefulWidget {
  static const String id = 'bitcoinPredicted';

  @override
  _BitcoinPredictedState createState() => _BitcoinPredictedState();
}

class _BitcoinPredictedState extends State<BitcoinPredicted> {
  bool isWaiting = false;
  bool isWaitingTwo = false;
  Map<dynamic, dynamic> bitcoinValues = {};
  BitcoinSentences bitcoinSentences = BitcoinSentences();
  int currentListIndex = 7;
  List<double> predicted = [];
  List<double> actual = [];
  final String fiveDaysAgo = DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 5) * -1));
  final String oneDayAgo = DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 1) * -1));
  final String twoDaysAgo = DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 2) * -1));
  final String threeDaysAgo = DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 3) * -1));
  final String fourDaysAgo = DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 4) * -1));
  final String fiveDaysAgoScreen = DateFormat('M月d日').format(DateTime.now().add(Duration(days: 5) * -1));
  final String oneDayAgoScreen = DateFormat('M月d日').format(DateTime.now().add(Duration(days: 1) * -1));
  final String twoDaysAgoScreen = DateFormat('M月d日').format(DateTime.now().add(Duration(days: 2) * -1));
  final String threeDaysAgoScreen = DateFormat('M月d日').format(DateTime.now().add(Duration(days: 3) * -1));
  final String fourDaysAgoScreen = DateFormat('M月d日').format(DateTime.now().add(Duration(days: 4) * -1));

  void getPredictedData() async{
    isWaiting = true;
    try{
      var data = await BitcoinFuturePrice().getPredictedJsonData();
      isWaiting = false;
      setState(() {
        bitcoinValues = data;
      });
      predicted.add(bitcoinValues[fiveDaysAgo]);
      predicted.add(bitcoinValues[oneDayAgo]);
      predicted.add(bitcoinValues[twoDaysAgo]);
      predicted.add(bitcoinValues[threeDaysAgo]);
      predicted.add(bitcoinValues[fourDaysAgo]);
    }catch(e){
      print(e);
    }
  }

  String mseLoss(List<double> predicted, List<double> actual){
    double mseLossSum = 0;
    int n = predicted.length;
    for (int i = 0; i<n; i++){
        mseLossSum += (predicted[i] - actual[i])*(predicted[i] - actual[i]);
    }
    return (mseLossSum/n).toStringAsFixed(1);
  }

  @override
  void initState() {
    super.initState();
    getPredictedData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('予測結果'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ValueCard(
            date: oneDayAgoScreen,
            value: isWaiting ? 'Not Found' : bitcoinValues[oneDayAgo]==null ? 'null' : bitcoinValues[oneDayAgo].toStringAsFixed(1),
            color: Colors.deepOrangeAccent.shade100,
          ),
          ValueCard(
            date: twoDaysAgoScreen,
              value: isWaiting ? 'Not Found' : bitcoinValues[twoDaysAgo] == null ? 'null' : bitcoinValues[twoDaysAgo].toStringAsFixed(1),
            color: Colors.deepOrangeAccent.shade100,
          ),
          ValueCard(
            date: threeDaysAgoScreen,
              value: isWaiting ? 'Not Found' : bitcoinValues[threeDaysAgo]==null ? 'null' : bitcoinValues[threeDaysAgo].toStringAsFixed(1),
            color: Colors.deepOrangeAccent.shade100,
          ),
          ValueCard(
            date: fourDaysAgoScreen,
              value: isWaiting ? 'Not Found' : bitcoinValues[fourDaysAgo]==null ? 'null' : bitcoinValues[fourDaysAgo].toStringAsFixed(1),
            color: Colors.deepOrangeAccent.shade100,
          ),
          ValueCard(
            date: fiveDaysAgoScreen,
            value: isWaiting ? 'Not Found' : bitcoinValues[fiveDaysAgo]==null ? 'null' : bitcoinValues[fiveDaysAgo].toStringAsFixed(1),
            color: Colors.deepOrangeAccent.shade100,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(30),
            child: Text(
              "以上が予測結果となります。とは言っても、数字だけだと分かりにくいでグラフで確認してみましょう",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: (MediaQuery.of(context).size.height)/40,
                  locale: Locale("ja", "JP"),
                  fontWeight: FontWeight.bold,
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
              if (currentListIndex == 7){
                Navigator.pop(context);
              }
              else{
                currentListIndex--;
              }
            },
            icon: Icons.navigate_before,
            label: '前へ',
            backgroundColor: Colors.redAccent.shade100,
          ),
          BottomButton(
            hero: 'next',
            onPressed: (){
                Navigator.pushNamed(context, CompareScreen.id);
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
