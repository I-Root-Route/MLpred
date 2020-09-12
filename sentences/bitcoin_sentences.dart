import 'package:machine_learning_pred/screens/deep_learning/data_processing.dart';

class BitcoinSentences{
  int _current = 0;
  final now = DateTime.now();

  var jsonData = JsonData().getJsonData();

  List<String> _sentences = [
    "Deep Learningを使うと、様々な予測モデルを作成することができます。",
    "今回はBitcoin(BTC)の価格を予測してみましょう。",
    "Deep Learningには様々な手法がありますが、今回はRNNを用いて価格の予測を行います(RNNについては後述)。",
    "まずは準備ですが、Deep Learningを始めとした機械学習では、最初に既存のデータを取ってくる作業が必要となります。",
    "例として、本日は${DateTime.now().year}年${DateTime.now().month}月${DateTime.now().day}日なので、"
        "${DateTime.now().month}月${DateTime.now().add(Duration(days: 1)*-1).day}日までの直近5日間の価格を見てみましょう",

    "今回は5日分のみのデータを取ってきましたが、実際の予測では数年分のデータを元に予測しています。",
    "それでは、データを取ってくることができたので、早速予測結果を見ていきましょう！",

    "ここで、RNNについてお話します。"
  ];


  String getSentence(){
    return _sentences[_current];
  }

  int increment(){
    _current ++;
    return _current;
  }

  int getCurrent(){
    return _current;
  }

  int getSentenceLength(){
    return _sentences.length;
  }

  int decrement(){
    _current --;
    return _current;
  }

  int setCurrent(int n){
    _current = n;
    return _current;
  }

  String getExactSentence(n){
    return _sentences[n];
  }

}