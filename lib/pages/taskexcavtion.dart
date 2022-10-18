import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:management/database/cloud_storage_functions.dart';
import 'package:management/database/database_functions.dart';

class ExcavationTask extends StatefulWidget {
  ExcavationTask({Key? key}) : super(key: key);

  @override
  State<ExcavationTask> createState() => _ExcavationTaskState();
}

class _ExcavationTaskState extends State<ExcavationTask> {
  bool loading = false;
  List<String> q1 = <String>["If Suitable condition", "Unsuitable condition"];
  String q1select = "";

  List<String> q2 = <String>["Yes", "No"];
  String q2select = "";
  List<String> q3 = <String>["Yes", "No"];
  String q3select = "";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? _fileName;
  String? _saveAsFileName;
  List<PlatformFile>? _paths = [];

  List<PlatformFile>? _preexcavation = [];
  List<PlatformFile>? _trenching = [];
  List<PlatformFile>? _digging = [];
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _userAborted = false;
  bool _multiPick = true;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();

  Future<List<PlatformFile>?> _pickFiles() async {
    _resetState();
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      // _logException('Unsupported operation' + e.toString());
    } catch (e) {
      // _logException(e.toString());
    }
    if (!mounted) return null;
    setState(() {
      _isLoading = false;
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      _userAborted = _paths == null;
    });
    return _paths;
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = null;
      _saveAsFileName = null;
      _userAborted = false;
    });
  }

  Row addRadioButton1(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: q1[btnValue],
          groupValue: q1select,
          onChanged: (value) {
            setState(() {
              q1select = value as String;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  Row addRadioButton2(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: q2[btnValue],
          groupValue: q2select,
          onChanged: (value) {
            setState(() {
              q2select = value as String;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  Row addRadioButton3(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: q3[btnValue],
          groupValue: q3select,
          onChanged: (value) {
            setState(() {
              q3select = value as String;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styl = TextStyle(fontWeight: FontWeight.w600, fontSize: 15);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Excavation",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
                Text(
                  "Upload Prexcavation site photo",
                  style: styl,
                ),
                ElevatedButton(
                    onPressed: () async {
                      _preexcavation = await _pickFiles();

                      print(_preexcavation);
                    },
                    child: Text("Upload")),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Elevation water table",
                  style: styl,
                ),
                addRadioButton1(0, "If Suitable condition"),
                addRadioButton1(1, "Unsuitable condition"),
                Text(
                  "Perform dewatering",
                  style: styl,
                ),

                Text(
                  "R Provision made for preventing damage to adjoing property",
                  style: styl,
                ),
                addRadioButton2(0, "Yes"),
                addRadioButton2(1, "No"),
                Text(
                  "Provide Provision",
                  style: styl,
                ),

                Text(
                  "CenterLine Check",
                  style: styl,
                ),
                // Plan view
                // Image

                addRadioButton3(0, "Yes"), //Yes
                addRadioButton3(1, "No"),
                // Text("Redo"),

                Text(
                  "Check for depth and Dimension",
                  style: styl,
                ),
                // Plan view
                // Image
                // addRadioButton(0, "Yes"), //Yes
                // addRadioButton(1, "No"),

                Text("Trenching"),
                ElevatedButton(
                    onPressed: () async {
                      _trenching = await _pickFiles();

                      print(_trenching);
                    },
                    child: Text("Upload")),

                Text("Digging"),
                ElevatedButton(
                    onPressed: () async {
                      _digging = await _pickFiles();

                      print(_digging);
                    },
                    child: Text("Upload")),

                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          User? currentuser = FirebaseAuth.instance.currentUser;

                          String preUrl = await CloudStorage.uploadFileUrl(
                              _preexcavation!.first.path!);
                          String treUrl = await CloudStorage.uploadFileUrl(
                              _trenching!.first.path!);
                          String digUrl = await CloudStorage.uploadFileUrl(
                              _digging!.first.path!);

                          print("Meow");
                          print(digUrl);

                          await Database().updateExcavation(
                              "admin", currentuser!.uid.toString(), {
                            "CenterlineCheck": true,
                            "Overall": true,
                            "checkdepthdimension": true,
                            "diggingPhoto": digUrl,
                            "elevationwatertable": true,
                            "performdewatering": true,
                            "trenchingPhoto": treUrl,
                            "uploadPrexcavationPhoto": preUrl
                          });

                          setState(() {
                            loading = false;
                          });

                          Navigator.pop(context, true);
                        },
                        child: Text("Done")),
                    loading ? CircularProgressIndicator() : SizedBox()
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
