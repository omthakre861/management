import 'package:flutter/material.dart';
import 'package:management/pages/mainpage.dart';
import 'package:management/pages/pageController.dart';

class ProjectPage extends StatefulWidget {
  ProjectPage({Key? key}) : super(key: key);

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  String projectName = "";
  String projectCode = "";

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
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
              child: const Text('Approve'),
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
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(
                  Icons.add,
                  color: Colors.blue,
                ),
                title: Text("Add Project"),
                subtitle: Text("Create your first project to get started"),
                onTap: () => bottomsheet(context),
              ),
              Text("Recent Projects")
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          bottomsheet(context);
        },
      ),
    );
  }

  Future<dynamic> bottomsheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: Wrap(
            children: [
              Text(
                "New Project",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Project Name'),
                key: ValueKey('projectName'),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Full Name should not be Empty';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  projectName = value.toString();
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration:
                    InputDecoration(hintText: 'Project Code (Optional)'),
                key: ValueKey('projectCode'),
                validator: (value) {},
                onSaved: (value) {
                  projectName = value.toString();
                },
              ),
              Container(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageControllerr(),
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  alignment: Alignment.center,
                  width: 400,
                  height: 45,
                  child: Text(
                    "Create",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 400,
                  height: 45,
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }
}
