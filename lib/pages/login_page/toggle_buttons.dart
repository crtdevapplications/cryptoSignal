import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto_signal_app/constants.dart';

class ToggleButtonsWidget extends StatefulWidget {
  const ToggleButtonsWidget({Key? key}) : super(key: key);

  @override
  _ToggleButtonsWidgetState createState() => _ToggleButtonsWidgetState();
}

class _ToggleButtonsWidgetState extends State<ToggleButtonsWidget> {
  final List<bool> selectedType = <bool>[true, false];
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: [
        Container(
          width: (MediaQuery.of(context).size.width-36) / 2,
          child: Center(child: const Text('Sign Up')),
        ),
        Container(
            width: (MediaQuery.of(context).size.width-36) / 2,
            child: Center(child: const Text('Login')))
      ],
      isSelected: selectedType,
      textStyle: toggleButtonStyle,
      selectedColor: textBlack,
      borderColor: toggleButtonBorderColor,
      selectedBorderColor: Colors.white,
      borderRadius: BorderRadius.circular(4),
      color: Colors.white,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      fillColor: Colors.white,
      onPressed: (int newIndex) {
        setState(() {
          for (int index = 0; index < selectedType.length; index++) {
            if (index == newIndex) {
              selectedType[index] = true;
            } else {
              selectedType[index] = false;
            }
          }
        });
      },
    );
  }
}
