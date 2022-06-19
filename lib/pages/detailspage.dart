import 'package:flutter/material.dart';
import 'package:nft_marketplace/models/user_model.dart';
import 'package:nft_marketplace/services/database.dart';
import 'package:provider/provider.dart';

Future<dynamic> customAlert(
    BuildContext context, User? user, UserData? userdata, int price) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        actions: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Are you sure to purchase this NFT for $price ETH?",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        int newbalance = userdata!.balance! - price;
                        await DatabaseService(uid: user!.uid)
                            .updateBalance(newbalance);
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          primary: Colors.white,
                          backgroundColor:
                              const Color.fromRGBO(13, 183, 183, 1),
                          textStyle: const TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                      child: const Text("Confirm"),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          primary: const Color.fromRGBO(13, 183, 183, 1),
                          backgroundColor: Colors.white,
                          textStyle: const TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                      child: const Text("Cancel"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

class DetailsPage extends StatefulWidget {
  const DetailsPage(
      {Key? key,
      required this.kreator,
      required this.judul,
      required this.harga,
      required this.gambar,
      required this.kreatorImg})
      : super(key: key);
  final String kreator, judul, gambar, kreatorImg;
  final int harga;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user?.uid).usersdata,
        builder: (context, snapshot) {
          UserData? userData = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              toolbarHeight: 70,
            ),
            backgroundColor: const Color.fromRGBO(255, 255, 255, 0.95),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin:
                      const EdgeInsets.only(left: 28, right: 28, bottom: 28),
                  width: 358,
                  height: 358,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            blurStyle: BlurStyle.outer,
                            blurRadius: 15,
                            color: Colors.black26)
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                          image: AssetImage(widget.gambar), fit: BoxFit.cover)),
                ),
                Container(
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurStyle: BlurStyle.outer,
                            blurRadius: 12,
                            color: Colors.black26)
                      ],
                      color: Colors.white70,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(
                              top: 32, left: 28, right: 28, bottom: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(right: 16),
                                    width: 86,
                                    height: 86,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image:
                                                AssetImage(widget.kreatorImg),
                                            fit: BoxFit.cover))),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(widget.kreator,
                                        style: const TextStyle(
                                            color: Color.fromRGBO(
                                                132, 132, 132, 1),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16)),
                                    Text(widget.judul,
                                        style: const TextStyle(
                                            color:
                                                Color.fromRGBO(18, 18, 18, 1),
                                            fontSize: 24,
                                            fontWeight: FontWeight.w800)),
                                    Text('${widget.harga} ETH',
                                        style: const TextStyle(
                                            color:
                                                Color.fromRGBO(18, 183, 183, 1),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                              ])),
                      Container(
                        padding: const EdgeInsets.only(top: 20, bottom: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Text("Current Balance",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 18, 183, 183),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700)),
                                Text("${userData?.balance} ETH",
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 18, 183, 183),
                                        fontSize: 32,
                                        fontWeight: FontWeight.w800)),
                              ],
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(18),
                              elevation: 5,
                              color: const Color.fromRGBO(18, 18, 18, 1),
                              child: MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      customAlert(context, user, userData,
                                          widget.harga);
                                    });
                                  },
                                  minWidth: 158,
                                  height: 58,
                                  child: const Text(
                                    'Buy Now',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
