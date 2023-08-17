import 'package:flutter/material.dart';

import '../theme.dart';


class MyButton extends StatelessWidget {
  final String titleButton;
  final GestureTapCallback onTap;
  const MyButton({Key? key, required this.titleButton,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: bluishClr
        ),
        child: Text(titleButton,style:Themes().titleButton,),
      ),
    );
  }
}
