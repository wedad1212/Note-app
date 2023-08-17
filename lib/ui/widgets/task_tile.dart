import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/task.dart';
import '../size_config.dart';
import '../theme.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(
    this.task, {
    Key? key,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(
              SizeConfig.orientation == Orientation.landscape ? 4 : 10)),
      width: SizeConfig.orientation == Orientation.landscape
          ? SizeConfig.screenWidth / 2
          : SizeConfig.screenWidth,
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: getProportionateScreenHeight(12)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: swichColor(task.color),
        ),
        child: Row(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title!,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 18,
                        color: Colors.white60,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${task.startTime} - ${task.endTime}',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[100],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    task.note!,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[100],
                      ),
                    ),
                  )
                ],
              ),
            )),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: 0.5,
                height: 90,
                color: Colors.grey[200]!.withOpacity(0.7)),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task.isCompleted == 0 ? "Todo" : "Completed",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  swichColor(int? color) {
    switch (color) {
      case 0:
        return pinkClr;
      case 1:
        return orangeClr;
      case 2:
        return primaryClr;
      default:
        return primaryClr;
    }
  }
}
