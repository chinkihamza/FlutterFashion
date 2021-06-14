import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fashion/Views/home_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:flutter_fashion/Views/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = LoginPage();
  late Permission cameraPermission;
  PermissionStatus cameraPermissionStatus = PermissionStatus.denied;

  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

  void _listenForPermission() async {
    final p1 = await Permission.camera.status;
    setState(() {
      cameraPermissionStatus = p1;
    });

    switch (p1) {
      case PermissionStatus.denied:
        requestForPermission();
        break;
      case PermissionStatus.granted:
        break;
      case PermissionStatus.restricted:
        Navigator.pop(context);
        break;
      case PermissionStatus.limited:
        Navigator.pop(context);
        break;
      case PermissionStatus.permanentlyDenied:
        Navigator.pop(context);
        break;
    }
  }


  Future<void> requestForPermission() async {
    final p2 = await Permission.camera.request();
    setState(() {
      cameraPermissionStatus = p2;
    });
  }

  @override
  void initState() {
    super.initState();
    _listenForPermission();
    checkLogin();
  }

  void checkLogin() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        currentPage = LoginPage();
      } else {
        currentPage = HomePage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(accentColor: Color(0xFFFF1E00)),
        home: currentPage);
  }
}
