import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:machine_learning_pred/components/squarebutton.dart';
import 'package:machine_learning_pred/components/bottom_menu.dart';
import 'package:machine_learning_pred/screens/comming_soon.dart';

class Home extends StatefulWidget {
  static const String id = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Home'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SquareButton(
                onTap: (){
                  Navigator.pushNamed(context, CommingSoonScreen.id);
                },
                icon: Icons.timeline,
                label: 'Regression',
                color: Colors.grey,
              ),
              SquareButton(
                onTap: (){
                  Navigator.pushNamed(context, 'dlscreen');
                },
                icon: FontAwesomeIcons.connectdevelop,
                label: 'Deep Learning',
              ),
            ],
          ),
          Row(
            children: <Widget>[
              SquareButton(
                onTap: (){
                  Navigator.pushNamed(context, CommingSoonScreen.id);
                },
                icon: Icons.bubble_chart,
                label: 'Clustering',
                color: Colors.grey,
              ),
              SquareButton(
                onTap: (){
                  Navigator.pushNamed(context, CommingSoonScreen.id);
                },
                icon: Icons.school,
                label: 'Reinforcement\nLearning',
                color: Colors.grey,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              SquareButton(
                onTap: (){
                  Navigator.pushNamed(context, CommingSoonScreen.id);
                },
                icon: Icons.select_all,
                label: 'Model Selection',
                color: Colors.grey,
              ),
              SquareButton(
                onTap: (){
                  Navigator.pushNamed(context, CommingSoonScreen.id);
                },
                icon: Icons.clear_all,
                label: 'Classification',
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomMenu(),
    );
  }
}