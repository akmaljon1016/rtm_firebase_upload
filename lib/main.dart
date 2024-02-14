import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CollectionReference instance =
      FirebaseFirestore.instance.collection("images");

  saveLink(Reference ref) async {
    var link = await ref.getDownloadURL();
    instance.add({"image": link});
  }

  uploadPhoto() async {
    final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    final ImagePicker imagePicker = ImagePicker();
    XFile? xFile;

    PermissionStatus permissionStatus = await Permission.photos.request();
    if (permissionStatus.isGranted) {
      try {
        xFile = await imagePicker.pickImage(source: ImageSource.gallery);
        File file = File(xFile?.path ?? "");

        Reference ref =
            firebaseStorage.ref("image").child("${file.path.split("/").last}");
        UploadTask snapshot = ref.putFile(file);
        saveLink(ref);
        snapshot.then((value) async {
          if (value.state == TaskState.success) {
            saveLink(ref);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Success")));
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Error")));
          }
        });
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Upload Photo"),
      ),
      body: Column(
        children: [
          MaterialButton(
            onPressed: () {
              uploadPhoto();
            },
            child: Text("Upload Photo"),
          ),
          Expanded(
            child: StreamBuilder(
                stream: instance.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          return Image.network(documentSnapshot['image'],width: 100,height: 100,);
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          )
        ],
      ),
    );
  }
}
