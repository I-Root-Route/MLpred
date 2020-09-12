import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  BottomButton({this.onPressed, this.icon, this.backgroundColor, this.label, this.hero});

  final Function onPressed;
  final IconData icon;
  final Color backgroundColor;
  final String label;
  final String hero;

  @override
  Widget build(BuildContext context) {

    return FloatingActionButton.extended(
      heroTag: hero,
      onPressed: onPressed,
      label: Text(label),
      icon: Icon(icon),
      backgroundColor: backgroundColor,
    );
  }
}
