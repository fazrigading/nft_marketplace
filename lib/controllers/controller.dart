import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var firstname = "".obs;
  var lastname = "".obs;
  var emailaddress = "".obs;
  var username = "".obs;
  var password = "".obs;
  var validation = ''.obs;

  final formFirst = TextEditingController();
  final formLast = TextEditingController();
  final formEmail = TextEditingController();
  final formUsername = TextEditingController();
  final formPassword = TextEditingController();
  final formKonfirmasiPassword = TextEditingController();
  final formValidateUser = TextEditingController();
  final cari = TextEditingController();
  final formCreator = TextEditingController();
  final formTitle = TextEditingController();
  final formPrice = TextEditingController();
  final formWallet = TextEditingController();

  void cleanform() {
    formFirst.text = '';
    formLast.text = '';
    formUsername.text = '';
    formEmail.text = '';
    formPassword.text = '';
    formKonfirmasiPassword.text = '';
    formWallet.text = '';
  }

  void cleanformnft() {
    formCreator.text = '';
    formTitle.text = '';
    formPrice.text = '';
    formWallet.text = '';
  }

  void updateVaidation() {
    validation.value = formValidateUser.text;
  }

  void updateProfile() {
    firstname.value = formFirst.text;
    lastname.value = formLast.text;
    username.value = formUsername.text;
  }
}
