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
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  saveLink(Reference ref,String path) async {
    var link = await ref.getDownloadURL();
    instance.add({"image": link, "path": path});
  }

  uploadPhoto() async {
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
        snapshot.then((value) async {
          if (value.state == TaskState.success) {
            saveLink(ref,file.path.split("/").last);
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
                          return InkWell(
                              onTap: () async {
                                try {
                                  Reference ref = firebaseStorage.ref(
                                      'image/${documentSnapshot['path']}');
                                  await ref.delete();
                                  await instance.doc(documentSnapshot.id).delete();
                                } catch (e) {
                                  print('Error deleting reference: $e');
                                }
                              },
                              child: Image.network(
                                documentSnapshot['image'],
                                width: 100,
                                height: 100,
                              ));
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
