import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';

class CloudStorage {
  static Future<void> uploadFiles(List<String> csv) async {
    await Future.wait(csv.map((cssv) => uploadFile(cssv)));
  }

  static Future<void> uploadFile(String filePath) async {
    File file = File(filePath);

    String path = filePath.split("/").last;
    User? currentuser = FirebaseAuth.instance.currentUser;

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('plans/${currentuser!.uid}/$path')
          .putFile(file);
    } on FirebaseException {
      // e.g, e.code == 'canceled'
    }
  }

  static Future<String> uploadFileUrl(String filePath) async {
    String urll = "";
    File file = File(filePath);

    String path = filePath.split("/").last;
    User? currentuser = FirebaseAuth.instance.currentUser;

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('plans/${currentuser!.uid}/$path')
          .putFile(file)
          .then((tasksnapshot) async {
        if (tasksnapshot.state == TaskState.success) {
          urll = await FirebaseStorage.instance
              .ref('plans/${currentuser.uid}/$path')
              .getDownloadURL();
        }
        // return null;
      });
    } on FirebaseException {
      // e.g, e.code == 'canceled'
    }
    print("FUnction");
    print(urll);

    return urll;
  }

  // static Future<void> storagelist(User currentuser) async {
  //   Directory? directory;
  //   directory = await getExternalStorageDirectory();
  //   String newPath = "";

  //   List<String> notUploadCloud = [];

  //   newPath = directory!.path + "/bin/csv/${currentuser.uid}";
  //   // print(newPath);
  //   directory = Directory(newPath);

  //   List<FileSystemEntity> files =
  //       directory.listSync(recursive: false).toList();

  //   late firebase_storage.ListResult result;

  //   List<String> filesPath = List.generate(
  //       files.length, (index) => files[index].path.split("/").last);

  //   List<String> firebasePath = [];
  //   try {
  //     result = await firebase_storage.FirebaseStorage.instance
  //         .ref('csv/${currentuser.uid}/')
  //         .listAll();

  //     for (var ref in result.items) {
  //       String path = ref.fullPath.split("/").last;
  //       firebasePath.add(path);
  //     }
  //   } on FirebaseException {
  //     // TODO
  //   }

  //   notUploadCloud =
  //       filesPath.where((item) => !firebasePath.contains(item)).toList();

  //   List<String> filesUpload = [];

  //   for (var element in notUploadCloud) {
  //     filesUpload.add(directory.path + "/" + element);
  //   }

  //   if (notUploadCloud.isNotEmpty) {
  //     await uploadFiles(filesUpload);
  //   }
  // }
}
