import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:management/database/cloud_storage_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadPage extends StatefulWidget {
  UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? _fileName;
  String? _saveAsFileName;
  List<PlatformFile>? _paths = [];
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _userAborted = false;
  bool _multiPick = true;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();

  List<String> fileName = <String>[
    "Excavation",
    "Foundation",
    "RCC",
    "Flooring"
  ];
  String fileselect = "";

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: fileName[btnValue],
          groupValue: fileselect,
          onChanged: (value) {
            setState(() {
              fileselect = value as String;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  Future<void> _pickFiles() async {
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
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      _userAborted = _paths == null;
    });
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          if (_paths != null) ...[
            _paths!.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _paths!.length,
                      itemBuilder: (context, index) {
                        return Wrap(
                          children: [
                            Image.file(
                              File(_paths![0].path!),
                              height: 150,
                            ),
                            addRadioButton(0, fileName[0]),
                            addRadioButton(1, fileName[1]),
                            addRadioButton(2, fileName[2]),
                            addRadioButton(3, fileName[3])
                          ],
                        );
                      },
                    ),
                  )
                : SizedBox()
          ] else ...[
            SizedBox()
          ],
          TextButton(
            onPressed: () async {
              await _pickFiles();

              print(_paths);
            },
            child: Text("Pick File"),
          ),
          TextButton(
            onPressed: () async {
              List<String> paths = _paths!.map((e) => e.path!).toList();
              CloudStorage.uploadFiles(paths);
              // Obtain shared preferences.
              final prefs = await SharedPreferences.getInstance();
              await prefs.setStringList('plansPath', paths);

              Navigator.pop(context);
            },
            child: Text("Upload"),
          ),
        ],
      )),
    );
  }
}
