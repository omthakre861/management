import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:management/pages/task.dart';
import 'package:management/pages/upload.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  User? currentuser = FirebaseAuth.instance.currentUser;

  List<String>? paths = [];

  @override
  void initState() {
    super.initState();
    getImage();
  }

  // Obtain shared preferences.

  Future<void> getImage() async {
    final prefs = await SharedPreferences.getInstance();
    paths = prefs.getStringList('plansPath');
    setState(() {});
  }

 

  List<String> drawerTitle = ["Plans", "Task", "People"];
  List<int> pageindex = [0, 1, 2];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   // title: Text("Plans"),
         
        // ),
        drawer: Drawer(
          child: Column(children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: drawerTitle.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(drawerTitle[index]),
                    onTap: () {
                      currentIndex = index;
                      setState(() {});
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ]),
        ),
        body: currentIndex == 0
            ? Column(
                children: [
                  if (paths != null) ...[
                    Expanded(
                        child: ListView.builder(
                      itemCount: paths!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Image.file(
                              height: 200,
                              fit: BoxFit.cover,
                              File(
                                paths![index],
                              )),
                        );
                      },
                    )
                        // : SizedBox(),
                        )
                  ] else
                    ...[]
                ],
              )
            : TaskPlan(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UploadPage(),
                ));
          },
        ),
      ),
    );
  }
}
