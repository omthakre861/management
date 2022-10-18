import 'package:cloud_firestore/cloud_firestore.dart';


/// Firebase Cloud Firestore [DataBase] class
///
///  Check out,`Firebase Console`  https://console.firebase.google.com/u/0/project/epilepsy-a75ec/firestore/
class Database {


  create(
      String collectionName,
      String documentName,
      String firstname,
      String lastname,
      String gender,
      int age,
      String phoneNumber,
      String careGiverPhoneNo) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentName)
        .set({
      'firstname': firstname,
      'lastname': lastname,
      'gender': gender,
      'age': age,
      'UserPhoneNumber': phoneNumber,
      'CareGiverPhoneno': careGiverPhoneNo,
      'Bluetooth MAC Address': "00:00:00:00:00:00",
      'Total Epilepsy Detected': 0
    });
    // print("Database Updated");
  }

  /// Updates data on the document.
  update(String collectionName, String documentName, field,
      var newFieldValue) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentName)
        .update({field: newFieldValue});
    // print("Fields Updated");
  }

  /// Deletes the current document from the collection
  delete(
    String collectionName,
    String documentName,
  ) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentName)
        .delete();
    // print("Document Deleted");
  }

  createEpilepsyHistory(
      String collectionName,
      String documentName,
      String collectionHistoryName,
      
      int seizureDuration) async {
    late String uid;
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentName)
        .collection(collectionHistoryName)
        .add({
   
      'Real Seizure': true,
      'Seizure Duration (sec)': seizureDuration,
      'Time': DateTime.now()
    }).then((value) {
      // print(value.id);
      uid = value.id;
    });
    return uid;
  }

  updateExcavation(
      String collectionName,
      String documentName,
     Map<String,dynamic> map
     
     ) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentName)
        .collection('task')
        .doc('excavation')
        .update(map);
    //print("Fields Updated");
  }

  Future<bool?> registerdataisExists(String userId) async {
    bool exists = false;
    await FirebaseFirestore.instance
        .collection('info')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        //  print('Document exists on the database');
        exists = true;
      }
    });
    return exists;
  }

  Future<int?> getExistingDetectionValue(String userId) async {
    int? totalDetection;
    await FirebaseFirestore.instance
        .collection('info')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        totalDetection = documentSnapshot.get("Total Epilepsy Detected") as int;
      }
    });
    return totalDetection;
  }

  // Future<List<String?>> getContact(String userId) async {
  //   List<String?> details = []..length = 3;
  //   shared.init();

  //   await FirebaseFirestore.instance
  //       .collection('info')
  //       .doc(userId)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       details[0] = documentSnapshot.get("firstname") as String;
  //       details[1] = documentSnapshot.get("CareGiverPhoneno") as String;
  //       details[2] =
  //           documentSnapshot.get("gender") as String == "Male" ? "He" : "She";
  //       shared.setNewValue(key: "UserName", value: details[0]);
  //       shared.setNewValue(key: "CareGiverPhoneno", value: details[1]);
  //     }
  //   });

  //   return details;
  // }
}
