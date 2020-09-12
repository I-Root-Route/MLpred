import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:machine_learning_pred/screens/home.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomMenu extends StatefulWidget {

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _currentIndex = 0;

  _launchURL() async{
    const url = 'https://github.com/I-Root-Route/predict_bitvalues';
    if (await canLaunch(url)){
      await launch(url);
    }
    else{
      throw '$urlを開ませんでした。';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.fileCode),
            title: Text('Source Code'),
          ),
        ],
        selectedItemColor: Colors.blueAccent,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
        if (_currentIndex == 0){
          Navigator.pushNamed(context, Home.id);
        }
        else if(_currentIndex == 1){
          _launchURL();
        }
      },
      );
  }
}
