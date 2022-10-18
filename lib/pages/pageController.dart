import 'package:flutter/material.dart';
import 'package:management/pages/mainpage.dart';
import 'package:management/pages/people.dart';
import 'package:management/pages/task.dart';

class PageControllerr extends StatefulWidget {
  PageControllerr({Key? key}) : super(key: key);

  @override
  State<PageControllerr> createState() => _PageControllerrState();
}

class _PageControllerrState extends State<PageControllerr> {
  List<String> drawerTitle = ["Plans", "Task", "People"];
  List<int> pageindex = [0, 1, 2];
  int currentIndex = 0;
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Safety Measures'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('• Safety Measures'),
                Text('• Use Personal Protective Equiment'),
                Text('• No Crowing inside the perimeter'),
                Text('• Proper site training '),
                Text('• Follow lofing precaution'),
                Text('• Keep the work area clean'),
                Text('• Use mechanincal aids when possible'),
                Text(
                    '• Be attentive when working with electricity and equiment'),
                Text('• First Aid Kit must be readily avaiable')
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(drawerTitle[currentIndex]),
          actions: [
            IconButton(
                onPressed: () {
                  _showMyDialog();
                },
                icon: Icon(Icons.info_outline))
          ],
        ),
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
            ? MainPage()
            : currentIndex == 1
                ? TaskPlan()
                : People());
  }
}
