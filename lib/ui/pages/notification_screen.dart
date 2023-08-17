import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';


class NotificationScreen extends StatefulWidget {
  final String payload;

  const NotificationScreen({Key? key, required this.payload}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _payload = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: context.theme.backgroundColor,
          leading: IconButton(
            color: Get.isDarkMode?Colors.white:Colors.black,
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Get.back(),
          ),
          title: Text(
            _payload.toString().split('|')[0],
            style: TextStyle(
                color: Get.isDarkMode ? Colors.white : darkHeaderClr,
                fontSize: 15),
          ),
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Hello",
                    style: TextStyle(
                        color: Get.isDarkMode ? Colors.white : darkGreyClr,
                        fontSize: 25),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("you have a new reminder",
                      style: TextStyle(color: Colors.grey, fontSize: 20)),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      margin:EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(20),
                        color: bluishClr,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.wb_incandescent_rounded,color: Colors.white,size: 30,),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text("Title",style: TextStyle(fontSize: 20,color: Colors.white ),),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(_payload.toString().split('|')[0],style: TextStyle(fontSize: 20,color:Colors.white54 ),),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Icon(Icons.description,color: Colors.white,size: 30,),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text("Description",style: TextStyle(fontSize: 20,color: Colors.white ),),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(_payload.toString().split('|')[1],style: TextStyle(fontSize: 20,color:Colors.white54 ),),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Icon(Icons.calendar_today,color: Colors.white,size: 30,),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text("Date",style: TextStyle(fontSize: 20,color: Colors.white ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(_payload.toString().split('|')[2],style: TextStyle(fontSize: 20,color:Colors.white54 ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
