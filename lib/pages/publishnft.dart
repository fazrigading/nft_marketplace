import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nft_marketplace/constants/form.dart';
import 'package:nft_marketplace/models/user_model.dart';
import 'package:nft_marketplace/services/database.dart';
import 'package:provider/provider.dart';
import '../controllers/controller.dart';

class PublishNFT extends StatelessWidget {
  const PublishNFT({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserController d = Get.find();
    final user = Provider.of<User?>(context);
    CollectionReference nfts = FirebaseFirestore.instance.collection('nfts');
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user?.uid).usersdata,
        builder: (context, snapshot) {
          UserData? userData = snapshot.data;
          return ListView(
            children: [
              const SizedBox(height: 50),
              SizedBox(
                  height: 216,
                  width: 216,
                  child: Image.asset('assets/icon/icon.png')),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 140),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Upload NFT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Get.snackbar("Aplikasi belum sesuai",
                          'Mohon coba lagi setelah pengujian selesai.');
                    }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
                child: Column(
                  children: [
                    TeksFormulir(
                        kontroler: d.formCreator,
                        teks: "Creator",
                        teksValidator: "Masukkan pembuat NFT"),
                    const SizedBox(height: 16),
                    TeksFormulir(
                        kontroler: d.formTitle,
                        teks: "Title",
                        teksValidator: "Masukkan nama NFT"),
                    const SizedBox(height: 16),
                    TeksFormulir(
                        kontroler: d.formPrice,
                        teks: "Price",
                        teksValidator: "Masukkan harga NFT"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 140),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Publish NFT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      int tambahpublikasi = userData!.nftpublished! + 1;
                      await DatabaseService(uid: user!.uid)
                          .updateNFTPublished(tambahpublikasi);
                      nfts.add({
                        'creator': d.formCreator.text,
                        'title': d.formTitle.text,
                        'price': d.formPrice.text
                      });
                      d.cleanformnft();
                      Get.snackbar("Publikasi NFT sukses",
                          'Silakan cek di Profil Anda.');
                    }),
              ),
            ],
          );
        });
  }
}
