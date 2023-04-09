import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool hidePassword = true.obs;
  final emailTxtController = TextEditingController();
  final passwordTxtController = TextEditingController();

}
  