import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nft_marketplace/constants/form.dart';
import 'package:nft_marketplace/services/database.dart';
import 'package:provider/provider.dart';
import '../controllers/controller.dart';
import '../models/user_model.dart';

final UserController ctr = Get.put(UserController());

class ViewProfile extends StatelessWidget {
  const ViewProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    CollectionReference nfts = FirebaseFirestore.instance.collection('nfts');

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user?.uid).usersdata,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 240, 240, 240)),
                        child: Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                width: 100,
                                height: 100,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image:
                                            AssetImage('assets/icon/icon.png'),
                                        fit: BoxFit.contain))),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${userData?.firstname} ${userData?.lastname}",
                                    maxLines: 2,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800)),
                                Text("@${userData?.username}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text("${userData?.useremail}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 245, 245, 245)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 250, 250, 250)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 120,
                              child: Column(
                                children: [
                                  const Text("NFTs Published",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 28, 28, 28),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700)),
                                  Text("${userData?.nftpublished}",
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 28, 28, 28),
                                          fontSize: 32,
                                          fontWeight: FontWeight.w800))
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: Column(
                                children: [
                                  const Text("Followers",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 28, 28, 28),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700)),
                                  Text("${userData?.followers}",
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 28, 28, 28),
                                          fontSize: 32,
                                          fontWeight: FontWeight.w800))
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: Column(
                                children: [
                                  const Text("Following",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 28, 28, 28),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700)),
                                  Text("${userData?.following}",
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 28, 28, 28),
                                          fontSize: 32,
                                          fontWeight: FontWeight.w800))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: nfts.snapshots(),
                  builder: (_, snapshot) {
                    return (snapshot.hasData)
                        ? Column(
                            children: snapshot.data!.docs
                                .map(
                                  (doc) => NFTCard(
                                    doc.get('creator'),
                                    doc.get('title'),
                                    doc.get('price'),
                                    onUpdate: () {
                                      nfts.doc(doc.id).update({
                                        'creator': ctr.formCreator.text,
                                        'title': ctr.formTitle.text,
                                        'price': ctr.formPrice.text
                                      });
                                    },
                                    onDelete: () {
                                      nfts.doc(doc.id).delete();
                                    },
                                  ),
                                )
                                .toList(),
                          )
                        : const Center(
                            child: CircularProgressIndicator.adaptive());
                  },
                ),
              ],
            );
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}

class NFTCard extends StatelessWidget {
  final String kreator;
  final String judul;
  final String harga;
  final Function? onUpdate;
  final Function? onDelete;

  const NFTCard(this.kreator, this.judul, this.harga,
      {Key? key, this.onUpdate, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final user = Provider.of<User?>(context);
    void _showEditPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return StreamBuilder<UserData>(
                stream: DatabaseService(uid: user?.uid).usersdata,
                builder: (context, snapshot) {
                  UserData? userData = snapshot.data;
                  return Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          TeksFormulir(
                              kontroler: ctr.formCreator,
                              teks: "Edit Creator",
                              teksValidator: "Masukkan nama kreator"),
                          const SizedBox(height: 20),
                          TeksFormulir(
                              kontroler: ctr.formTitle,
                              teks: "Edit Title",
                              teksValidator: "Masukkan nama NFT"),
                          const SizedBox(height: 20),
                          TeksFormulir(
                              kontroler: ctr.formPrice,
                              teks: "Edit Price",
                              teksValidator: "Masukkan harga NFT"),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red[400]),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    int kurangipublikasi =
                                        userData!.nftpublished! - 1;
                                    await DatabaseService(uid: user!.uid)
                                        .updateNFTPublished(kurangipublikasi);
                                    if (onDelete != null) onDelete!();
                                    Navigator.pop(context);
                                    ctr.cleanformnft();
                                  }
                                },
                                child: const Text("Delete NFT"),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.teal[400]),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    if (onUpdate != null) onUpdate!();
                                    Navigator.pop(context);
                                    ctr.cleanformnft();
                                  }
                                },
                                child: const Text("Update NFT"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          });
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            height: 370,
            width: 300,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 0.12),
                borderRadius: BorderRadius.circular(30)),
            child: Column(
              children: [
                Container(
                    padding:
                        const EdgeInsets.only(left: 20, top: 310, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(kreator,
                            style: const TextStyle(
                                color: Color.fromRGBO(132, 132, 132, 1),
                                fontWeight: FontWeight.w500,
                                fontSize: 14)),
                        const Text('Price',
                            style: TextStyle(
                                color: Color.fromRGBO(132, 132, 132, 1),
                                fontWeight: FontWeight.w500,
                                fontSize: 14))
                      ],
                    )),
                Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(judul,
                            style: const TextStyle(
                                color: Color.fromRGBO(18, 18, 18, 1),
                                fontWeight: FontWeight.w700,
                                fontSize: 18)),
                        Text(harga,
                            style: const TextStyle(
                                color: Color.fromRGBO(18, 183, 183, 1),
                                fontWeight: FontWeight.w700,
                                fontSize: 18)),
                      ],
                    )),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              ctr.formCreator.text = kreator;
              ctr.formTitle.text = judul;
              ctr.formPrice.text = harga;
              _showEditPanel();
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  image: DecorationImage(
                      image: AssetImage('assets/icon/icon.png'),
                      fit: BoxFit.cover)),
            ),
          ),
        ],
      ),
    );
  }
}
