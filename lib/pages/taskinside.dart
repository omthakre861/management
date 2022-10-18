import 'package:flutter/material.dart';

class TaskInside extends StatefulWidget {
  TaskInside({Key? key}) : super(key: key);

  @override
  State<TaskInside> createState() => _TaskInsideState();
}

class _TaskInsideState extends State<TaskInside> {
  List<String> gender = <String>["Male", "Female"];
  String genderselect = "";
  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: genderselect,
          onChanged: (value) {
            setState(() {
              genderselect = value as String;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.add_to_photos_outlined))
        ]),
        body: SingleChildScrollView(
          child: Column(
            children: [
              
              Text("Foundation"),
              Text("Check the depth and dimension"),
// Image plan

              Text("Require depth "),
// Fill blank
// TextFormField(
//   controller: ,

// )

              Text("Require Dimension "),
// Fill blank
// TextFormField(
//   controller: ,
// )

              Text("Are the reqirement met?"),

              addRadioButton(0, "Yes"), //Yes
              addRadioButton(1, "No"),
              Text("Redo"),
              Text("Check the reinforement bar"),
// Image Plan
              Text("Size"),
// Fill blank
// TextFormField(
//   controller: ,
// )

              Text("Spacing"),

// Fill blank
// TextFormField(
//   controller: ,
// )

              Text("Grades"),

// Fill blank
// TextFormField(
//   controller: ,
// )

              Text("Are the reqirement met?"),

              addRadioButton(0, "Yes"), //Yes
              addRadioButton(1, "No"),
              Text("Redo"),

              Text("Depth and Dimension of formwork"),
              // Image plan

              Text("Require depth "),
// Fill blank
// TextFormField(
//   controller: ,

// )

              Text("Require Dimension "),
// Fill blank
// TextFormField(
//   controller: ,
// )

              Text("Are the reqirement met?"),

              addRadioButton(0, "Yes"), //Yes
              addRadioButton(1, "No"),
              Text("Redo"),

              Text("Upload photo of foundation"),
              ElevatedButton(onPressed: () {}, child: Text("Upload")),

              SizedBox(
                height: 20,
              ),
              Text("RCC Work"),
              Text("Perform Slump Cone Test"),
              addRadioButton(0, "Performed"), //Yes
              addRadioButton(1, "Not Performed"),
              Text("Perform the test"),

              Text("Check Spacing/ length of hooks and overlap"),

              Text("Require spacing of hooks "),
// Fill blank
// TextFormField(
//   controller: ,

// )

              Text("Require Length of overlap "),
// Fill blank
// TextFormField(
//   controller: ,
// )

              Text("Are the reqirement met?"),

              addRadioButton(0, "Yes"), //Yes
              addRadioButton(1, "No"),
              Text("Redo"),

              Text(
                  "Check expansion/construction joing are properly made and that correct location is provided as the drawing"),
              // Image Plan
              addRadioButton(0, "Yes"), //Yes
              addRadioButton(1, "No"),
              Text("Do Correction"),

              Text("Depth and width of all beams"),
              Text("Require depth "),
// Fill blank
// TextFormField(
//   controller: ,

// )

              Text("Require width "),
// Fill blank
// TextFormField(
//   controller: ,
// )

              Text("Are the reqirement met?"),

              addRadioButton(0, "Yes"), //Yes
              addRadioButton(1, "No"),
              Text("Redo"),
              Text("Is Cleaning done before concreting"),
              addRadioButton(0, "Yes"), //Yes
              addRadioButton(1, "No"),
              Text("Clean"),

              // RCC sub tree

              SizedBox(
                height: 15,
              ),

              Text("Columns and Walls"),
              Text("Check Alignment , dimension and elevation"),
              // Image plan
              addRadioButton(0, "Properly Align"), //Yes
              addRadioButton(1, "Not properly align"),
              Text("Correct the alignment"),

              Text("Check all embedded items and concrete cover are in places"),
              // Image plam
              addRadioButton(0, "Yes"), //Yes
              addRadioButton(1, "No"),
              Text("Correct the placement"),

              Text(
                  "Check Dowel bars/ starters bar are in placed as per approve drawing"),
              addRadioButton(0, "Yes"), //Yes
              addRadioButton(1, "No"),
              Text("Correct the placement"),

              SizedBox(
                height: 20,
              ),
              Text("Flooring"),
              Text("Check for loose tiles"),
              addRadioButton(0, "Loose"),
              //Yes

              Text("Do the require fitting"),

              addRadioButton(1, "Not Loose"),

              Text("Check for Cracked tiles"),
              addRadioButton(0, "Crack"),
              //Yes

              Text("Replace the tiles"),

              addRadioButton(1, "Not Crack"),

              Text("Check for cracked or missing grouting"),
              addRadioButton(0, "Missing"),
              Text("Fill the gaps"),

              addRadioButton(1, "Not Missing"),

              Text("Chech is floor is flat "),
              addRadioButton(0, "Flat"),

              addRadioButton(1, "Not Flat"),
              Text("Correct the alignment"),


              
            ],
          ),
        ),
      ),
    );
  }
}
