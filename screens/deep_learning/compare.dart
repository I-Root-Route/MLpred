import 'package:flutter/material.dart';
import 'package:machine_learning_pred/backend/deep_learning/api.dart';
import 'package:intl/intl.dart';
import 'package:machine_learning_pred/sentences/bitcoin_sentences.dart';
import 'package:machine_learning_pred/components/bottom_buttons.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:machine_learning_pred/backend/deep_learning/get_bitcoin_prices.dart';
import 'dart:math';
import 'package:machine_learning_pred/components/bottom_menu.dart';
import 'package:machine_learning_pred/screens/deep_learning/rnn_explanation/rnn_exp.dart';

class CompareScreen extends StatefulWidget {
  static const String id = 'compare';

  @override
  _CompareScreenState createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  int currentIndex = 0;
  Map<dynamic,dynamic> bitcoinValues =  {};
  List predictedValues = [];
  bool isWaiting = false;
  int bottomBorder = 1000000;
  BitcoinSentences bitcoinSentences = BitcoinSentences();
  int currentListIndex = BitcoinSentences().setCurrent(5);
  List<double> actual = [];
  final String fiveDaysAgo = DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 5) * -1));
  final String oneDayAgo = DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 1) * -1));
  final String twoDaysAgo = DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 2) * -1));
  final String threeDaysAgo = DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 3) * -1));
  final String fourDaysAgo = DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 4) * -1));

  void getData() async{
    isWaiting = true;
    try{
      var data = await BitcoinFuturePrice().getPredictedJsonData();
      List<double> actuals = await ActualData().getActualData();
      isWaiting = false;
      setState(() {
        actual = actuals;
        bitcoinValues = data;
      });
      double actualMin = actual.reduce(min);
      List<double> predictList = [];
      predictList.add(bitcoinValues[fiveDaysAgo]==null ? double.infinity : bitcoinValues[fiveDaysAgo]);
      predictList.add(bitcoinValues[fourDaysAgo]==null ? double.infinity : bitcoinValues[fourDaysAgo]);
      predictList.add(bitcoinValues[threeDaysAgo]==null ? double.infinity : bitcoinValues[threeDaysAgo]);
      predictList.add(bitcoinValues[twoDaysAgo]==null ? double.infinity : bitcoinValues[twoDaysAgo]);
      predictList.add(bitcoinValues[oneDayAgo]==null ? double.infinity : bitcoinValues[oneDayAgo]);
      double predictMin = predictList.reduce(min);
      if(actualMin > predictMin ){
        bottomBorder = (predictMin - predictMin/10).round();
      }
      else{
        bottomBorder =  (actualMin - actualMin/10).round();
      }
    }catch (e){
      print(e);
    }
  }

  List<LineChartBarData> linesBarData(){
    final LineChartBarData lineChartBarDataActual = LineChartBarData(
      spots: [
        FlSpot(1,isWaiting ? null : bitcoinValues[fiveDaysAgo]==null ? null : bitcoinValues[fiveDaysAgo]),
        FlSpot(3,isWaiting ? null : bitcoinValues[fourDaysAgo]==null ? null : bitcoinValues[fourDaysAgo]),
        FlSpot(5, isWaiting ? null : bitcoinValues[threeDaysAgo]==null ? null : bitcoinValues[threeDaysAgo]),
        FlSpot(7, isWaiting ? null : bitcoinValues[twoDaysAgo]==null ? null : bitcoinValues[twoDaysAgo]),
        FlSpot(9, isWaiting ? null : bitcoinValues[oneDayAgo]==null ? null : bitcoinValues[oneDayAgo]),
      ],
      colors: [
        const Color(0xff4af699),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final LineChartBarData lineChartBarDataPredicted = LineChartBarData(
      spots: [
        FlSpot(1, isWaiting ? null : actual[4]),
        FlSpot(3, isWaiting ? null : actual[3]),
        FlSpot(5, isWaiting ? null : actual[2]),
        FlSpot(7, isWaiting ? null : actual[1]),
        FlSpot(9, isWaiting ? null : actual[0]),
      ],
      colors: [
        const Color(0xffaa4cfc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
    );
    return [
      lineChartBarDataActual,
      lineChartBarDataPredicted,
    ];
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
        title: Text('結果比較'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              height: (MediaQuery.of(context).size.height)/2.8,
              width: (MediaQuery.of(context).size.width)/1.05,
              decoration: BoxDecoration(
                  color: Color(0xff2c274c),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0,3),
                    )
                  ]
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(
                        height: 37,
                      ),
                      const Text(
                        'Result',
                        style: TextStyle(
                          color: Color(0xff827daa),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Text(
                        'BTC/JPY',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 37,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16, left: 6),
                          child: LineChart(
                            LineChartData(
                              lineTouchData: LineTouchData(
                                touchTooltipData: LineTouchTooltipData(
                                  tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                                ),
                                touchCallback: (LineTouchResponse touchResponse) {},
                                handleBuiltInTouches: true,
                              ),
                              gridData: FlGridData(
                                show: false,
                              ),
                              titlesData: FlTitlesData(
                                bottomTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 22,
                                  textStyle: const TextStyle(
                                    color: Color(0xff72719b),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  margin: 15,
                                  getTitles: (values){
                                    switch (values.toInt()){
                                      case 1:
                                        return '5日前';
                                      case 5:
                                        return '3日前';
                                      case 9:
                                        return '昨日';
                                    }
                                    return '';
                                  },
                                ),
                                leftTitles: SideTitles(
                                  showTitles: true,
                                  getTitles: (value){
                                    return '';
                                  }
                                ),
                              ),
                              borderData: FlBorderData(
                                show: true,
                                border: const Border(
                                  bottom: BorderSide(
                                    color: Color(0xff4e4965),
                                    width: 6,
                                  ),
                                  left: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  right: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  top: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                              minY: bottomBorder.toDouble(),
                              maxX: 10,
                              lineBarsData: linesBarData(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(30),
            child: Text(
              currentIndex==0 ?
              isWaiting ? '集計中...' :
                          '結果が表示されました。緑が予測した値、紫が実際の値です(直近の予測日は2020年9月8日です。時間が経つにつれ、精度が落ちます)。'
              : '今回は過去のデータを参考にしましたが、応用すれば今日以降の価格予測も簡単に行うことができます。',
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
              if(currentIndex==0){
                Navigator.pop(context);
              }
              else{
                setState(() {
                  currentIndex--;
                });
              }
            },
            icon: Icons.navigate_before,
            label: '前へ',
            backgroundColor: Colors.redAccent.shade100,
          ),
          BottomButton(
            hero: 'next',
            onPressed: (){
              if(currentIndex==0){
                setState(() {
                  currentIndex++;
                });
              }
              else{
                Navigator.pushNamed(context, RnnExp.id);
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
