import 'package:flutter/material.dart';
import 'package:tirta/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tirta/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TirtaApp());
}