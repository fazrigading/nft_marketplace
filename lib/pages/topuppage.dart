import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nft_marketplace/controllers/controller.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../services/database.dart';

final UserController ctr = Get.find();

class TopUpPage extends StatelessWidget {
  const TopUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user?.uid).usersdata,
        builder: (context, snapshot) {
          UserData? userData = snapshot.data;
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  "Top-Up Balance",
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
              body: Form(
                key: formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 200),
                      const Text("Current Balance",
                          style: TextStyle(
                              color: Color.fromARGB(255, 18, 183, 183),
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                      Text("${userData?.balance} ETH",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 18, 183, 183),
                              fontSize: 32,
                              fontWeight: FontWeight.w800)),
                      const SizedBox(height: 20),
                      TextFormField(
                          controller: ctr.formWallet,
                          validator: (value) {
                            if (value!.isEmpty) {
                              "Input your wallet nominal.";
                            } else if (!value.isNumericOnly) {
                              "Input your wallet correctly.";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Balance",
                              hintText: "ex: 78")),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: Colors.teal[400]),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            int newbalance =
                                int.parse(ctr.formWallet.text.trim());
                            await DatabaseService(uid: user!.uid)
                                .updateBalance(newbalance);
                            ctr.cleanformnft();
                          }
                        },
                        child: const Text("Update NFT"),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
