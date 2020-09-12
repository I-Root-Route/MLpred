import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';

class BitcoinFuturePrice{
  Future<String> _loadPredictedJsonAsset() async{
  return await rootBundle.loadString('json/predicted_data.json');
  }

  Future getPredictedJsonData() async{
  String jsonString = await _loadPredictedJsonAsset();
  return json.decode(jsonString);
  }

}
