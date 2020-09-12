import 'package:flutter/material.dart';
import 'package:machine_learning_pred/components/bottom_menu.dart';

class CommingSoonScreen extends StatelessWidget {
  static const String id = 'commingSoon';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comming Soon...'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          child: Text(
            'アップデートで順次追加する予定です'
          ),
        ),
      ),
      bottomNavigationBar: BottomMenu(),
    );
  }
}
