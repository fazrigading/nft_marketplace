import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import '../constants/form.dart';
import '../controllers/controller.dart';

final UserController c = Get.put(UserController());

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Form(
          key: formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  const SizedBox(height: 80),
                  Image.asset(
                    'assets/icon/icon.png',
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 30),
                  TeksFormulir(
                      kontroler: c.formEmail,
                      teks: "Email",
                      teksValidator: "Input email Anda"),
                  const SizedBox(height: 15),
                  TeksFormulir(
                      kontroler: c.formPassword,
                      teks: "Password",
                      teksValidator: "Input password Anda",
                      sensorinputan: true),
                  const SizedBox(height: 15),
                  SizedBox(
                    child: Align(
                      alignment: Alignment.center,
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        elevation: 5,
                        color: const Color.fromRGBO(18, 18, 18, 1),
                        child: MaterialButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await authService.signIn(
                                    c.formEmail.text.trim(),
                                    c.formPassword.text.trim());
                                if (c.formValidateUser.text == "1") {
                                  c.cleanform();
                                  Get.offNamed('/homepage');
                                  Get.snackbar("Welcome!",
                                      "Signed in as ${c.formEmail.text.trim()}");
                                }
                              }
                            },
                            minWidth: double.infinity,
                            height: 50,
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Haven't registered yet?"),
                      const SizedBox(width: 10),
                      TextButton(
                          onPressed: () {
                            Get.toNamed('/registpage');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(18, 183, 183, 1)),
                          ),
                          child: const Text(
                            "Register Now",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegistPage extends StatelessWidget {
  RegistPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey2,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: ListView(
              children: [
                const SizedBox(height: 80),
                Image.asset(
                  'assets/icon/icon.png',
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Flexible(
                      child: TeksFormulir(
                          kontroler: c.formFirst,
                          aksiInput: TextInputAction.next,
                          teks: "First Name",
                          teksValidator: "Input nama Anda"),
                    ),
                    const SizedBox(width: 15),
                    Flexible(
                      child: TeksFormulir(
                          kontroler: c.formLast,
                          aksiInput: TextInputAction.next,
                          teks: "Last Name",
                          teksValidator: "Input nama Anda"),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                TeksFormulirAkun(
                    kontroler: c.formUsername,
                    aksiInput: TextInputAction.next,
                    teks: "Username",
                    teksValidatorKosong: "Input username Anda",
                    teksValidatorMinimal:
                        "Username harus lebih dari 8 karakter."),
                const SizedBox(height: 15),
                TextFormField(
                    controller: c.formEmail,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Input alamat email Anda";
                      } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Input alamat email yang benar';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email Address")),
                const SizedBox(height: 15),
                TeksFormulirAkun(
                    kontroler: c.formPassword,
                    aksiInput: TextInputAction.next,
                    sensorinputan: true,
                    teks: "Password",
                    teksValidatorKosong: "Input password Anda",
                    teksValidatorMinimal:
                        "Password harus lebih dari 8 karakter."),
                const SizedBox(height: 15),
                TextFormField(
                    controller: c.formKonfirmasiPassword,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Input password yang sama";
                      } else if (value.length < 8) {
                        return "Password harus lebih dari 8 karakter";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Confirm Password")),
                const SizedBox(height: 15),
                SizedBox(
                  child: Align(
                    alignment: Alignment.center,
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      elevation: 5,
                      color: const Color.fromRGBO(18, 18, 18, 1),
                      child: MaterialButton(
                          onPressed: () async {
                            if (formKey2.currentState!.validate()) {
                              if (c.formPassword.text.trim() ==
                                  c.formKonfirmasiPassword.text.trim()) {
                                await authService.signUp(
                                    c.formEmail.text.trim(),
                                    c.formPassword.text.trim(),
                                    c.formFirst.text.trim(),
                                    c.formLast.text.trim(),
                                    c.formUsername.text.trim());
                                c.updateProfile();
                                c.cleanform();
                                Get.snackbar("Registration Success",
                                    "You will be redirected in 2 seconds...");
                                Timer(const Duration(seconds: 2), () {
                                  Get.offNamed('/loginpage');
                                });
                              } else {
                                Get.snackbar("Password Tidak Sama",
                                    "Mohon periksa kembali password Anda.");
                              }
                            }
                          },
                          minWidth: double.infinity,
                          height: 50,
                          child: const Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
