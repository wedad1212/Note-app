import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';

import '../../controllers/task_controller.dart';

import '../../models/task.dart';
import '../../services/notification_services.dart';
import '../../services/theme_services.dart';
import '../size_config.dart';
import '../theme.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/button.dart';
import '../widgets/task_tile.dart';
import 'add_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  final TaskController _taskController = Get.put(TaskController());
  late NotifyHelper notifyHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    // notifyHelper.requestIOSPermissions();
    notifyHelper.initializeNotification();
    _taskController.getTask();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: _appBar(),
        body: Column(
          children: [
            _addTaskBar(),
            SizedBox(
              height: 15,
            ),
            _addDatePiker(),
            SizedBox(
              height: 15,
            ),
            _showTasks(),
          ],
        ));
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      elevation: 0,
      leading: IconButton(
          icon: Icon(
            Get.isDarkMode
                ? Icons.light_mode_rounded
                : Icons.nightlight_round_outlined,
            size: 24,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () {
            ThemeServices().swichTheme();
          }),
      actions: [
        IconButton(
            onPressed: () {
              notifyHelper.cancelAllNotification();
              _taskController.deleteAllTasks();
            },
            icon: Icon(
              Icons.cleaning_services_outlined,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            )),
        Padding(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/person.jpeg'),
            )),
      ],
    );
  }

  _addTaskBar() {
    return Container(
      margin: EdgeInsets.only(top: 10, right: 10, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: Themes().topTitle,
              ),
              Text(
                "Today",
                style: Themes().subTitle,
              )
            ],
          ),
          MyButton(
              titleButton: "+ Add Task",
              onTap: () async => await Get.to(() => AddTaskPage())),
        ],
      ),
    );
  }

  _addDatePiker() {
    return DatePicker(
      DateTime.now(),
      width: 80,
      height: 100,
      selectionColor: primaryClr,
      initialSelectedDate: DateTime.now(),
      onDateChange: (newDate) {
        setState(() {
          _selectedDate = newDate;
        });
      },
      monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey)),
      dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey)),
      dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w600, color: Colors.grey)),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        if (_taskController.taskList.isEmpty) {
          return Center(child: _noTaks());
        } else {
          return RefreshIndicator(
            color: bluishClr,
            backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
            onRefresh: loadTask,
            child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  var task = _taskController.taskList[index];
                  if (task.repeat == 'daily' ||
                      task.date == DateFormat.yMd().format(_selectedDate) ||
                      (task.repeat == 'weekly' &&
                          _selectedDate
                                      .difference(
                                          DateFormat.yMd().parse(task.date!))
                                      .inDays %
                                  7 ==
                              0) ||
                      (task.repeat == 'monthly' &&
                          DateFormat.yMd().parse(task.date!).day ==
                              _selectedDate.day)) {
                    var date = DateFormat.jm().parse(task.startTime!);
                    var time = DateFormat('HH:mm').format(date);

                    notifyHelper.scheduledNotification(
                      int.parse(time.toString().split(':')[0]),
                      int.parse(time.toString().split(':')[1]),
                      task,
                    );
                    return AnimationConfiguration.staggeredList(
                      duration: const Duration(milliseconds: 1000),
                      position: index,
                      child: SlideAnimation(
                        horizontalOffset: 300,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () {
                              _showSheetBottom(
                                context,
                                task,
                              );
                            },
                            child: TaskTile(task),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                itemCount: _taskController.taskList.length,
                scrollDirection: SizeConfig.orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical),
          );
        }
      }),
    );
  }

  _noTaks() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: Duration(milliseconds: 2000),
          child: RefreshIndicator(
            onRefresh: loadTask,
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: SizeConfig.orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                children: [
                  SizeConfig.orientation == Orientation.landscape
                      ? SizedBox(
                          height: 4,
                        )
                      : SizedBox(
                          height: 100,
                        ),
                  SvgPicture.asset(
                    'images/task.svg',
                    width: 120,
                    height: 120,
                    semanticsLabel: "Task",
                    color: primaryClr.withOpacity(0.5),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "you don't have any tasks yet!\nAdd new tasks to make your days productive",
                      textAlign: TextAlign.center,
                      style: Themes().hintTitle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  _buildSheetBottom({
    required String label,
    required Function() onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Get.isDarkMode ? Colors.grey[600]! : Colors.grey[300]!,
            ),
            borderRadius: BorderRadius.circular(20),
            color: color),
        margin: EdgeInsets.symmetric(
          vertical: 4,
        ),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        child: Center(
            child: Text(
          label,
          style: Themes().title.copyWith(color: Colors.white, fontSize: 20),
        )),
      ),
    );
  }

  _showSheetBottom(BuildContext context, Task task) {
    Get.bottomSheet(
      SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(top: 7),
              width: SizeConfig.screenWidth,
              height: (SizeConfig.orientation == Orientation.landscape)
                  ? (task.isCompleted == 1)
                      ? SizeConfig.screenHeight * 0.6
                      : SizeConfig.screenHeight * 0.8
                  : (task.isCompleted == 1)
                      ? SizeConfig.screenHeight * 0.34
                      : SizeConfig.screenHeight * 0.49,
              color: Get.isDarkMode ? Colors.black : Colors.white,
              child: Column(
                children: [
                  Flexible(
                    child: Container(
                      height: 6,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Get.isDarkMode
                              ? Colors.grey[600]!
                              : Colors.grey[300]!),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  task.isCompleted == 1
                      ? Column(
                          children: [
                            _buildSheetBottom(
                                label: 'Deleted',
                                onTap: () {
                                  notifyHelper.cancelNotification(task);
                                  _taskController.deleteTask(task);
                                  Get.back();
                                },
                                color: Colors.red[300]!),
                            Divider(
                              height: 5,
                              color: Get.isDarkMode
                                  ? Colors.grey[600]!
                                  : Colors.grey[300]!,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            _buildSheetBottom(
                                label: 'Cancel',
                                onTap: () {
                                  Get.back();
                                },
                                color: primaryClr)
                          ],
                        )
                      : Column(
                          children: [
                            _buildSheetBottom(
                                label: 'Task Completed',
                                onTap: () {
                                  notifyHelper.cancelNotification(task);
                                  _taskController.updateTask(task.id!);
                                  Get.back();
                                },
                                color: primaryClr),
                            SizedBox(
                              height: 5,
                            ),
                            _buildSheetBottom(
                                label: 'Deleted',
                                onTap: () {
                                  notifyHelper.cancelNotification(task);
                                  _taskController.deleteTask(task);
                                  Get.back();
                                },
                                color: Colors.red[300]!),
                            Divider(
                              height: 5,
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : Colors.grey[800],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _buildSheetBottom(
                                label: 'Cancel',
                                onTap: () {
                                  Get.back();
                                },
                                color: primaryClr)
                          ],
                        )
                ],
              ))),
    );
  }

  Future<void> loadTask() async {
    _taskController.getTask();
  }
}
