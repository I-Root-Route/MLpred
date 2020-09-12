import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';

class JsonData{
  Future<String> _loadJsonAsset() async{
    return await rootBundle.loadString('json/crypto_data.json');
}

  Future getJsonData() async{
    String jsonString = await _loadJsonAsset();
    return json.decode(jsonString);
  }

}