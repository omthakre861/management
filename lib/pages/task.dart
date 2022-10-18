import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:management/pages/taskexcavtion.dart';
import 'package:management/pages/taskinside.dart';

class TaskPlan extends StatefulWidget {
  TaskPlan({Key? key}) : super(key: key);

  @override
  State<TaskPlan> createState() => _TaskPlanState();
}

class _TaskPlanState extends State<TaskPlan> {
  List<String> pior1 = ["Excavation", 'Foundation', 'RCC', 'Flooring'];
  List<String> pior2 = ["asd", 'asdas', 'asdsa'];

  List<String> completed = [];

  List<String> verify = [];

  User? currentuser;
  Stream<DocumentSnapshot>? _usersStream;
  @override
  void initState() {
    // TODO: implement initState
    fir();

    super.initState();
  }

  void fir() {
    currentuser = FirebaseAuth.instance.currentUser;
    _usersStream = FirebaseFirestore.instance
        .collection('admin')
        .doc(currentuser!.uid.toString())
        .collection('task')
        .doc('excavation')
        .get()
        .asStream();
    // print(currentuser!.uid.toString());
    // _usersStream!.listen((event) {
    //   var data = event.data() as Map<String, dynamic>;
    //   print(data["verified"]);
    //   if (data["verified"] == "excavation") {}
    // });
  }

  Future<dynamic> bottomsheet(BuildContext context, String item) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: Wrap(
            children: [
              ListTile(
                title: Text("Priority 1"),
                onTap: () {
                  pior1.add(item);
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              ListTile(
                title: Text("Priority 2"),
                onTap: () {
                  pior2.add(item);
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              ListTile(
                title: Text("Completed"),
                onTap: () {
                  completed.add(item);
                  Navigator.pop(context);
                  setState(() {});
                },
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Piority 1"),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: pior1.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Slidable(
                  key: const ValueKey(1),
                  endActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    motion: const ScrollMotion(),

                    // A pane can dismiss the Slidable.
                    dismissible: DismissiblePane(onDismissed: () {}),

                    // All actions are defined in the children parameter.
                    children: [
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        onPressed: (context) async {
                          await bottomsheet(context, pior1[index]);
                          pior1.removeAt(index);
                        },
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        icon: Icons.more_horiz,
                        // label: 'Delete',
                      ),
                    ],
                  ),

                  // The end action pane is the one at the right or the bottom side.
                  startActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        // An action can be bigger than the others.
                        flex: 2,
                        onPressed: (context) async {
                          setState(() {
                            completed.add(pior1[index]);
                            pior1.removeAt(index);
                          });
                        },
                        backgroundColor: Color(0xFF7BC043),
                        foregroundColor: Colors.white,
                        icon: Icons.check,
                        label: 'Done',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(pior1[index]),
                    onTap: () async {
                      var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExcavationTask(),
                          ));
                      print(result);
                      if (result == true) {
                        completed.add(pior1[index]);
                        pior1.removeAt(index);
                      }
                      setState(() {});
                    },
                  ),
                );
              },
            ),
            // Text("Piority 2"),
            // ListView.builder(
            //   physics: NeverScrollableScrollPhysics(),
            //   itemCount: pior2.length,
            //   shrinkWrap: true,
            //   itemBuilder: (context, index) {
            //     return Slidable(
            //       key: const ValueKey(0),
            //       endActionPane: ActionPane(
            //         // A motion is a widget used to control how the pane animates.
            //         motion: const ScrollMotion(),

            //         // A pane can dismiss the Slidable.
            //         dismissible: DismissiblePane(onDismissed: () {}),

            //         // All actions are defined in the children parameter.
            //         children: [
            //           // A SlidableAction can have an icon and/or a label.
            //           SlidableAction(
            //             onPressed: (context) async {
            //               await bottomsheet(context, pior2[index]);
            //               setState(() {
            //                 pior2.removeAt(index);
            //               });
            //             },
            //             backgroundColor: Colors.grey,
            //             foregroundColor: Colors.white,
            //             icon: Icons.more_horiz,
            //             // label: 'Delete',
            //           ),
            //         ],
            //       ),

            //       // The end action pane is the one at the right or the bottom side.
            //       startActionPane: ActionPane(
            //         motion: ScrollMotion(),
            //         children: [
            //           SlidableAction(
            //             // An action can be bigger than the others.
            //             flex: 2,
            //             onPressed: (context) {
            //               setState(() {
            //                 completed.add(pior2[index]);
            //                 pior2.removeAt(index);
            //               });
            //             },
            //             backgroundColor: Color(0xFF7BC043),
            //             foregroundColor: Colors.white,
            //             icon: Icons.check,
            //             label: 'Done',
            //           ),
            //         ],
            //       ),
            //       child: ListTile(
            //         title: Text(pior2[index]),
            //       ),
            //     );
            //   },
            // ),
            Text("Completed"),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: completed.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Slidable(
                  key: const ValueKey(2),
                  endActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    motion: const ScrollMotion(),

                    // A pane can dismiss the Slidable.
                    dismissible: DismissiblePane(onDismissed: () {}),

                    // All actions are defined in the children parameter.
                    children: [
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        onPressed: (context) async {
                          await bottomsheet(context, completed[index]);
                          setState(() {
                            completed.removeAt(index);
                          });
                        },
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        icon: Icons.more_horiz,
                        // label: 'Delete',
                      ),
                    ],
                  ),

                  // The end action pane is the one at the right or the bottom side.
                  startActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        // An action can be bigger than the others.
                        flex: 2,
                        onPressed: (context) {},
                        backgroundColor: Color(0xFF7BC043),
                        foregroundColor: Colors.white,
                        icon: Icons.check,
                        label: 'Done',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(completed[index]),
                  ),
                );
              },
            ),
            Text("Verified"),
            StreamBuilder<DocumentSnapshot>(
              stream: _usersStream,
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;

                  print(data);
                  if (data["verified"] == "Excavation" && verify.length <= 1)
                    verify.add(data["verified"]);
                  completed.remove(data["verified"]);
                  pior1.remove(data["verified"]);
                  print(verify);

                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: verify.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(verify[index]),
                      );
                    },
                  );
                }

                return SizedBox();
              },
            )
            // ListView.builder(
            //   physics: NeverScrollableScrollPhysics(),
            //   itemCount: verify.length,
            //   shrinkWrap: true,
            //   itemBuilder: (context, index) {
            //     return Slidable(
            //       key: const ValueKey(3),
            //       endActionPane: ActionPane(
            //         // A motion is a widget used to control how the pane animates.
            //         motion: const ScrollMotion(),

            //         // A pane can dismiss the Slidable.
            //         dismissible: DismissiblePane(onDismissed: () {}),

            //         // All actions are defined in the children parameter.
            //         children: [
            //           // A SlidableAction can have an icon and/or a label.
            //           SlidableAction(
            //             onPressed: (context) {},
            //             backgroundColor: Colors.grey,
            //             foregroundColor: Colors.white,
            //             icon: Icons.more_horiz,
            //             // label: 'Delete',
            //           ),
            //         ],
            //       ),

            //       // The end action pane is the one at the right or the bottom side.
            //       startActionPane: ActionPane(
            //         motion: ScrollMotion(),
            //         children: [
            //           SlidableAction(
            //             // An action can be bigger than the others.
            //             flex: 2,
            //             onPressed: (context) {},
            //             backgroundColor: Color(0xFF7BC043),
            //             foregroundColor: Colors.white,
            //             icon: Icons.check,
            //             label: 'Done',
            //           ),
            //         ],
            //       ),
            //       child: ListTile(
            //         title: Text(verify[index]),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskInside(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
