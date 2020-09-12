import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:machine_learning_pred/components/bottom_menu.dart';
import 'package:machine_learning_pred/sentences/rnn_sentences.dart';
import 'package:machine_learning_pred/components/bottom_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class RnnExp extends StatefulWidget {
  static const String id = 'rnnexp';
  @override
  _RnnExpState createState() => _RnnExpState();
}

class _RnnExpState extends State<RnnExp> {

  int currentIndex = 0;

  _launchURL() async{
    const url = 'https://github.com/I-Root-Route/predict_bitvalues';
    if (await canLaunch(url)){
      await launch(url);
    }
    else{
      throw '$urlを開ませんでした。';
    }
  }


  List<LineChartBarData> rnnBarData() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 0.8),
        FlSpot(7, 2.1),
        FlSpot(10, 2.9),
        FlSpot(12, 2.2),
        FlSpot(13, 3.6),
      ],
      isCurved: true,
      colors: [
        const Color(0xff4af699),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 2.8),
        FlSpot(7, 1.2),
        FlSpot(10, 2.8),
        FlSpot(12, 2.6),
        FlSpot(13, 3.9),
      ],
      isCurved: true,
      colors: [
        const Color(0xffaa4cfc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );
    final LineChartBarData lineChartBarData3 = LineChartBarData(
      spots: [
        FlSpot(1, 2.8),
        FlSpot(3, 1.9),
        FlSpot(6, 3),
        FlSpot(10, 1.3),
        FlSpot(13, 2.6),
      ],
      isCurved: true,
      colors: const [
        Color(0xff27b6fc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [
      lineChartBarData1,
      lineChartBarData2,
      lineChartBarData3,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RNNとは'),
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
                borderRadius: const BorderRadius.all(Radius.circular(18)),
                gradient: LinearGradient(
                  colors: const[
                    Color(0xff2c274c),
                    Color(0xff46426c),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'RNNとは?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
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
                                  margin: 10,
                                  getTitles: (value){
                                    switch(value.toInt()){
                                      case 2:
                                        return 'ANN';
                                      case 7:
                                        return 'CNN';
                                      case 12:
                                        return 'RNN';
                                    }
                                    return '';
                                  },
                                ),
                                leftTitles: SideTitles(
                                  showTitles: true,
                                  textStyle: const TextStyle(
                                    color: Color(0xff75729e),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  )
                                ),
                              ),
                              borderData: FlBorderData(
                                show: true,
                                border: const Border(
                                  bottom: BorderSide(
                                    color: Color(0xff4e4965),
                                    width: 4,
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
                              minX: 0,
                              maxX: 14,
                              maxY: 4,
                              minY: 0,
                              lineBarsData: rnnBarData(),
                            ),
                          ),
                        ),
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
              RnnSentences().getExactSentence(currentIndex),
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
              if (currentIndex == 0){
                Navigator.pop(context);
              }
              else {
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
              if (currentIndex < RnnSentences().getSentenceLength() - 1){
                setState(() {
                  currentIndex++;
                });
              }
              else{
                _launchURL();
              }
            },
            icon: Icons.navigate_next,
            label: currentIndex==RnnSentences().getSentenceLength()-1 ? 'ソースコードを見る' : '次へ',
            backgroundColor: currentIndex==RnnSentences().getSentenceLength()-1 ? Colors.black : Colors.blueAccent.shade100,
          ),
        ],
      ),
      bottomNavigationBar: BottomMenu(),
    );
  }
}

