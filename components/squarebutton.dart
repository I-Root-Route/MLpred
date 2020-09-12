import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SquareButton extends StatelessWidget {
  SquareButton({this.icon, this.label, this.onTap, this.color=Colors.white});

  final Function onTap;
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: size.height/80,
              ),
              Icon(
                icon,
                size: size.height/7.5,
              ),
              SizedBox(
                height: size.height/80,
              ),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          margin: EdgeInsets.all(15),
          height: size.height/4.5,
          width: size.width/2,
          decoration: BoxDecoration(
              color: color,
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
        ),
      ),
    );
  }
}
