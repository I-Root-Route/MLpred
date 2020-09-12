import 'package:flutter/material.dart';

class ValueCard extends StatelessWidget {
  const ValueCard({
    this.date,
    this.value,
    this.color
  });

  final String value;
  final String date;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: color,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: (MediaQuery.of(context).size.height)/100, horizontal: 28.0),
          child: Text(
            '$date: 1 BTC=$value 円',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: (MediaQuery.of(context).size.height)/40,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
