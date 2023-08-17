import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/get_utils.dart';

import '../theme.dart';


class InputField extends StatelessWidget {
  InputField({
    Key? key,
    required this.title,
    required this.hintTitle,
    this.widget,
    this.keyboardType,
    this.controller,
  }) : super(key: key);
  final String title;
  final String hintTitle;
  Widget? widget;
 TextInputType? keyboardType;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
            child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Themes().title,
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              padding: EdgeInsets.only(left:9 ),
              margin: EdgeInsets.only(top: 2),
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey
                )
                ),

              child: Row(
                children:[ Expanded(
                  child: TextFormField(
                    autofocus: false,
                    readOnly: widget==null?false:true,
                    controller: controller,
                    keyboardType: keyboardType,
                    style: Themes().styleInField,
                    cursorColor: Get.isDarkMode?Colors.white:darkGreyClr,
                    cursorHeight: 20,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                       borderSide: BorderSide(
                         width: 0,
                         color: context.theme.backgroundColor)
                       ),
       focusedBorder: UnderlineInputBorder(
                             borderSide: BorderSide(
                               width: 0,
                                 color: context.theme.backgroundColor
                             )
                         ),



                      hintText: hintTitle,
                      hintStyle: Themes().hintTitle,
                    ),
                  ),
                ),
                  widget??Container() ,
              ]),
            ),

          ],
        ));
  }
}
