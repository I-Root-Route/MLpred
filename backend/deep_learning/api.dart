import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

const apiKey = 'yourAPI';
const consURL = 'https://rest.coinapi.io/v1/ohlcv/';
const slash = '/';

DateTime now = new DateTime.now();
DateTime five = new DateTime.now().add(Duration(days: 4)*-1);
DateTime date = new DateTime(now.year, now.month, now.day, 9, 00, 00);
DateTime fiveDaysAgo = new DateTime(now.year, now.month, five.day, 0, 00, 00);
int fitToday = (date.millisecondsSinceEpoch/1000).round();
int fiveDaysAgoSt = (fiveDaysAgo.millisecondsSinceEpoch/1000).round();


String cryptoWatchURL = 'https://api.cryptowat.ch/markets/kraken/btcjpy/ohlc?before=$fitToday&after=$fiveDaysAgoSt&periods=86400';


var formatter = new DateFormat('yyyy-MM-dd');
String formattedDate = formatter.format(now);
String requestURL = '${consURL}BTC${slash}JPY${slash}history?period_id=1DAY&time_end=${formattedDate}T00:00:00&apikey=$apiKey';

class ActualData{
  Future getActualData() async{
    List<double> actualPrices = [];
    http.Response response = await http.get(cryptoWatchURL);
    if(response.statusCode == 200){
      var decodedData = jsonDecode(response.body);
      for (int i = 0; i < 5; i++){
        actualPrices.add(decodedData["result"]["86400"][4-i][4] + 0.0);
      }
    }
    else{
      print(requestURL);
      throw 'Problem with the request';
    }
    return actualPrices;
  }
}
