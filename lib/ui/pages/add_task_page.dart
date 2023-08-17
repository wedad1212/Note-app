import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note/controllers/task_controller.dart';
import '../../models/task.dart';
import '../theme.dart';
import '../widgets/button.dart';
import '../widgets/input_field.dart';
import 'home_page.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  // object TaskController with Get.put
  TaskController _taskController = Get.put(TaskController());

  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  DateTime _selectedDateTime = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(Duration(minutes: 15)))
      .toString();

  int selectedRemind = 5;
  List<int> listRemind = [5, 10, 15, 20];

  String repeat = "None";
  List<String> listRepeat = ["None", "daily", "monthly", "weekly"];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Center(
                    child: Text(
                  "Add Task",
                  style: Themes().styleTextAdd,
                )),
                InputField(
                  title: 'Title',
                  hintTitle: 'Enter title here.',
                  keyboardType: TextInputType.text,
                  controller: titleController,
                ),
                InputField(
                  title: 'Note',
                  hintTitle: 'Enter note here.',
                  keyboardType: TextInputType.text,
                  controller: noteController,
                ),
                InputField(
                  title: 'Date',
                  hintTitle: DateFormat.yMd().format(_selectedDateTime),
                  widget: IconButton(
                    color: Colors.grey,
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _getDateFromUser(),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        title: 'Start Time',
                        hintTitle: _startTime,
                        widget: IconButton(
                          icon: Icon(
                            Icons.watch_later_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () => _getTimeFromUser(true),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: InputField(
                        title: 'End Time',
                        hintTitle: _endTime,
                        keyboardType: TextInputType.datetime,
                        widget: IconButton(
                          icon: Icon(
                            Icons.watch_later_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () => _getTimeFromUser(false),
                        ),
                      ),
                    )
                  ],
                ),
                InputField(
                  title: 'Remind',
                  hintTitle: '$selectedRemind minutes early',
                  widget: Row(children: [
                    DropdownButton(
                      underline: Container(
                        height: 0,
                      ),
                      elevation: 4,
                      dropdownColor: Colors.blueGrey,
                      icon: Icon(
                        Icons.arrow_drop_down_sharp,
                        size: 30,
                        color: Colors.grey,
                      ),
                      onChanged: (String? newVal) {
                        setState(() {
                          selectedRemind = int.parse(newVal.toString());
                        });
                      },
                      items: listRemind
                          .map<DropdownMenuItem<String>>(
                              (int value) => DropdownMenuItem<String>(
                                    value: value.toString(),
                                    child: Text('$value'),
                                  ))
                          .toList(),
                    ),
                    SizedBox(
                      width: 6,
                    )
                  ]),
                ),
                InputField(
                  title: "Repeat",
                  hintTitle: '$repeat',
                  widget: Row(
                    children: [
                      DropdownButton(
                        icon: Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.grey,
                          size: 30,
                        ),
                        underline: Container(
                          height: 0,
                        ),
                        dropdownColor: Colors.blueGrey,
                        items: listRepeat
                            .map(
                              (value) => DropdownMenuItem(
                                child: Text('$value'),
                                value: value,
                              ),
                            )
                            .toList(),
                        onChanged: (newValue) {
                          setState(() {
                            repeat = newValue as String;
                          });
                        },
                      ),
                      SizedBox(
                        width: 6,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    pickColor(),
                    MyButton(
                        titleButton: "Add Task",
                        onTap: () {
                          validate();
                        })
                  ],
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  validate() async {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      addTaskToDb();
      Get.back();
    } else if (titleController.text.isEmpty || noteController.text.isEmpty) {
      Get.snackbar(
        'required',
        'All fields are required!',
        snackPosition: SnackPosition.BOTTOM,
        messageText: Text(
          'All fields are required!',
          style: TextStyle(fontSize: 15, color: Colors.red),
        ),
        colorText: Colors.red,
        backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white,
        icon: Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
      );
    } else {
      print("error");
    }
  }

  addTaskToDb() async {
    try{
      int value=  await _taskController.addTask(
          task: Task(
            title: titleController.text,
            note: noteController.text,
            date: DateFormat.yMd().format(_selectedDateTime),
            startTime: _startTime,
            endTime: _endTime,
            remind: selectedRemind,
            repeat: repeat,
            isCompleted: 0,
            color: _selectedColor,
          ));
      print('$value');
    }catch(e){
      print("error");
    }

  }

  Column pickColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: Themes().title,
        ),
        SizedBox(height: 5,),
        Row(
            children: List.generate(
                3,
                (index) => Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor = index;
                          });
                        },
                        child: CircleAvatar(
                          child: _selectedColor == index
                              ? Icon(
                                  Icons.done,
                                  color: Colors.white,
                                )
                              : null,
                          backgroundColor: index == 0
                              ? pinkClr
                              : index == 1
                                  ? orangeClr
                                  : bluishClr,
                        ),
                      ),
                    )))
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      elevation: 0,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () {
            Get.to(HomePage());
          }),
      actions: [
        Padding(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/person.jpeg'),
            )),
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2015),
      lastDate: DateTime(2040),
      initialEntryMode: DatePickerEntryMode.calendar,
    );
    if (_pickedDate != null)
      setState(() {
        _selectedDateTime = _pickedDate;
      });
    else {
      print('cancel');
    }
  }

  _getTimeFromUser(bool isLeft) async {
    TimeOfDay? _pickedTime = await showTimePicker(
        context: context,
        initialTime: isLeft
            ? TimeOfDay.fromDateTime(DateTime.now())
            : TimeOfDay.fromDateTime(
                DateTime.now().add(Duration(minutes: 15))));
    String _pickedTimeFormat = _pickedTime!.format(context);
    if (isLeft)
      setState(() {
        _startTime = _pickedTimeFormat;
      });
    else if (!isLeft)
      setState(() {
        _endTime = _pickedTimeFormat;
      });
    else {
      print('cancel');
    }
  }
}
