import 'package:flutter/material.dart';
import 'package:plan_tasks/utils/colors.dart';
import 'package:plan_tasks/widgets/standard_button.dart';

alertBox(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: black,
          ),
        ),
        content: Text(
          message,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: black,
          ),
        ),
        actions: <Widget>[
          StandardButton(
            label: 'Cancelar',
            onPressed: () {
              Navigator.pop(context);
            },
            color: red,
            width: 120.0,
          ),
          StandardButton(
            label: 'Ok',
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            color: primaryColor,
            width: 80.0,
          ),
        ],
      );
    },
  );
}
