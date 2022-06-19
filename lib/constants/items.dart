import 'package:flutter/material.dart';
import 'button.dart';

class Item extends StatelessWidget {
  const Item(
      {Key? key,
      required this.kreator,
      required this.judul,
      required this.harga,
      required this.gambar,
      required this.kreatorImg})
      : super(key: key);
  final String kreator;
  final String judul;
  final int harga;
  final String gambar;
  final String kreatorImg;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          height: 415,
          width: 320,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(0, 0, 0, 0.12),
              borderRadius: BorderRadius.circular(40)),
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(left: 20, top: 330, right: 20),
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
                      Text(harga.toString(),
                          style: const TextStyle(
                              color: Color.fromRGBO(18, 183, 183, 1),
                              fontWeight: FontWeight.w700,
                              fontSize: 18)),
                    ],
                  )),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          width: 320,
          height: 320,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              image: DecorationImage(
                  image: AssetImage(gambar), fit: BoxFit.cover)),
        ),
        DetailsButton(
            kreator: kreator,
            judul: judul,
            harga: harga,
            gambar: gambar,
            kreatorImg: kreatorImg),
      ],
    );
  }
}
