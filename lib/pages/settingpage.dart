import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nft_marketplace/constants/form.dart';
import 'package:nft_marketplace/services/auth.dart';
import 'package:nft_marketplace/services/database.dart';
import 'package:provider/provider.dart';
import '../controllers/controller.dart';
import '../models/user_model.dart';

final UserController ctr = Get.put(UserController());

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "General Settings",
          style: TextStyle(
              fontFamily: 'Manrope',
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        toolbarHeight: 70,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                Get.to(ChangeDataUser());
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                decoration: BoxDecoration(
                  color: Colors.teal[400],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "User Setting",
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Get.to(GantiPassword());
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                decoration: BoxDecoration(
                  color: Colors.teal[600],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Password Setting",
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Get.snackbar("Fitur belum tersedia",
                    'Mohon coba lagi setelah pengujian selesai.');
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                decoration: BoxDecoration(
                  color: Colors.teal[700],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Email Setting",
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangeDataUser extends StatelessWidget {
  ChangeDataUser({Key? key}) : super(key: key);
  final _datauserFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user?.uid).usersdata,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  "User Settings",
                  style: TextStyle(
                      fontFamily: 'Manrope',
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w800),
                ),
                backgroundColor: Colors.white,
                elevation: 1,
                toolbarHeight: 70,
              ),
              body: const Center(child: CircularProgressIndicator()),
            );
          } else {
            UserData? userData = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  "User Settings",
                  style: TextStyle(
                      fontFamily: 'Manrope',
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w800),
                ),
                backgroundColor: Colors.white,
                elevation: 1,
                toolbarHeight: 70,
              ),
              backgroundColor: Colors.white,
              body: Form(
                key: _datauserFormKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 50),
                    Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        width: 200,
                        height: 200,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage('assets/icon/icon.png'),
                                fit: BoxFit.contain))),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Text("${userData?.firstname} ${userData?.lastname}",
                              style: const TextStyle(
                                  fontFamily: 'Manrope',
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800)),
                          Text("@${userData?.username}"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                  child: TextFormField(
                                      controller: ctr.formFirst,
                                      validator: (value) => value!.isEmpty
                                          ? "Ketik nama depan Anda."
                                          : null,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "First Name",
                                          hintText: "ex: Fazri"))),
                              const SizedBox(width: 10),
                              Flexible(
                                  child: TextFormField(
                                      controller: ctr.formLast,
                                      validator: (value) => value!.isEmpty
                                          ? "Ketik nama belakang Anda."
                                          : null,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Last Name",
                                          hintText: "ex: Gading"))),
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: ctr.formUsername,
                            validator: (value) =>
                                value!.isEmpty ? "Ketik username Anda." : null,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Username",
                                hintText: "ex: fazrigading"),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Material(
                          borderRadius: BorderRadius.circular(18.0),
                          elevation: 5,
                          color: const Color.fromRGBO(18, 18, 18, 1),
                          child: MaterialButton(
                              onPressed: () async {
                                if (_datauserFormKey.currentState!.validate()) {
                                  ctr.updateProfile();
                                  await DatabaseService(uid: user!.uid)
                                      .updateUserData(
                                          ctr.formFirst.text.trim(),
                                          ctr.formLast.text.trim(),
                                          ctr.formUsername.text.trim());
                                  Get.snackbar(
                                      "Success", "Your profile has updated.");
                                }
                              },
                              minWidth: 250,
                              height: 58,
                              child: const Text(
                                'Change Data User',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}

class GantiPassword extends StatelessWidget {
  GantiPassword({Key? key}) : super(key: key);
  final _passwordformKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = Provider.of<User?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user?.uid).usersdata,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  "Email Settings",
                  style: TextStyle(
                      fontFamily: 'Manrope',
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w800),
                ),
                backgroundColor: Colors.white,
                elevation: 1,
                toolbarHeight: 70,
              ),
              body: const Center(child: CircularProgressIndicator()),
            );
          } else {
            UserData? userData = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  "Password Settings",
                  style: TextStyle(
                      fontFamily: 'Manrope',
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w800),
                ),
                backgroundColor: Colors.white,
                elevation: 1,
                toolbarHeight: 70,
              ),
              backgroundColor: Colors.white,
              body: Form(
                key: _passwordformKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 200),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          const Text("Current Email Address"),
                          Text("${userData?.useremail}",
                              style: const TextStyle(
                                  fontFamily: 'Manrope',
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 10),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          TeksFormulirAkun(
                              kontroler: ctr.formPassword,
                              aksiInput: TextInputAction.next,
                              sensorinputan: true,
                              teks: "Password",
                              teksValidatorKosong: "Input password Anda",
                              teksValidatorMinimal:
                                  "Password harus lebih dari 8 karakter."),
                          const SizedBox(height: 15),
                          TextFormField(
                              controller: ctr.formKonfirmasiPassword,
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
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Material(
                          borderRadius: BorderRadius.circular(18.0),
                          elevation: 5,
                          color: const Color.fromRGBO(18, 18, 18, 1),
                          child: MaterialButton(
                              onPressed: () async {
                                if (_passwordformKey.currentState!.validate()) {
                                  await authService.ubahPassword(
                                      ctr.formPassword.text.trim());
                                  ctr.cleanform();
                                  Get.snackbar(
                                      "Success", "Your password has updated.");
                                }
                              },
                              minWidth: 250,
                              height: 58,
                              child: const Text(
                                'Change Password',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
