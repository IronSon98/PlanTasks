import 'package:flutter/material.dart';
import 'package:plan_tasks/utils/colors.dart';

class StandardButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final double? width;

  const StandardButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.color,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width == null ? MediaQuery.of(context).size.width * 0.5 : width,
      height: 48.0,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
